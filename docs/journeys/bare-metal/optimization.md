# Optimization

This guide covers optimization approaches for AMD Instinct GPUs in a bare metal environment. Before applying optimizations, ensure your system is properly configured by completing the steps in [Environment Setup](environment-setup.md).

## System Configuration

Most performance issues on a fresh deployment trace back to default system settings that are not suited for GPU workloads. If you have not already done so, review the [Environment Setup](environment-setup.md) page — it covers the key changes, including:

- **Disabling NUMA auto-balancing** — this is one of the most impactful single settings for GPU workload performance. Linux's automatic NUMA memory rebalancing can interfere with GPU memory locality and cause unpredictable slowdowns.
- **Setting the CPU governor to `performance` mode** — prevents the CPU from throttling frequency during GPU-driven workloads.
- **BIOS/firmware settings** — PCIe, NUMA, and power management settings that affect every workload on the system.

After completing those steps, review the [ROCm System Optimization Guide](https://rocm.docs.amd.com/en/latest/how-to/system-optimization/index.html), which includes GPU-specific pages with verified settings for each platform (for example, [MI300X](https://instinct.docs.amd.com/projects/amdgpu-docs/en/latest/system-optimization/mi300x.html)). Also see the [ROCm prerequisite system validation guide](https://rocm.docs.amd.com/en/docs-7.2.1/how-to/rocm-for-ai/system-setup/prerequisite-system-validation.html) for recommended pre-workload validation steps, including performance determinism settings that can stabilize GPU clock behavior.

## Performance Profiling

Before making optimization changes, establish a baseline and use profiling tools to understand where time is actually being spent. A GPU workload can be slow for several different reasons — it might be waiting on data transfers, limited by compute throughput, or stalling on memory access — and the right fix depends on which problem is actually occurring. ROCm provides tools that address different stages of this process:

1. **[ROCProfiler SDK (rocprofv3)](https://rocm.docs.amd.com/projects/rocprofiler-sdk/en/latest/)** — The recommended profiling tool for collecting GPU hardware metrics and API traces from the command line. Use this for automated or scripted profiling, or when you need to capture data about a specific kernel or time window.

2. **[ROCm Compute Profiler](https://rocm.docs.amd.com/projects/rocm-compute-profiler/en/latest/)** — A guided analysis tool that categorizes bottlenecks and provides targeted recommendations. This is the best starting point if you've identified that a workload is slow but aren't sure why — it tells you whether the issue is compute, memory bandwidth, or something else, and suggests what to investigate next.

3. **[ROCProfiler (rocprof)](https://rocm.docs.amd.com/projects/rocprofiler/en/latest/)** — The previous-generation command-line profiler. Listed here for users with existing tooling built against the older API; new projects should prefer rocprofv3.

For a practical walkthrough of applying these tools to AI inference workloads, see the [Profiling and Debugging Guide](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/inference-optimization/profiling-and-debugging.html).

## Precision and Model Fit

For AI and LLM workloads, choosing the right numeric precision is often the highest-impact, lowest-effort optimization available. Precision affects how large a model can fit in GPU memory and how fast the hardware can process it:

- **Lower precision = less memory + higher throughput**: GPU hardware executes lower-precision math faster and with less memory. A model that doesn't fit at FP32 may fit at BF16, and may run significantly faster at FP8.
- **BF16 is the recommended default** for most LLM inference workloads. It provides a strong balance of accuracy and performance with minimal configuration.
- **FP8 provides additional throughput** on supported hardware where the accuracy trade-off is acceptable.

Supported precision formats by GPU generation:

- **CDNA 3 (MI300 series)**: FP8, BF16, FP16, TF32, FP32, FP64 in Matrix Cores
- **CDNA 4 (MI350 series)**: Adds MXFP4, MXFP6, MXFP8, and OCP FP8 with Microscaling support for additional compression

As a concrete example: a 70B parameter model requires approximately 140 GB at BF16. This fits on a single MI300X (192 GB HBM) without requiring multi-GPU distribution.

## AI and Machine Learning Optimization

### Framework and Runtime Selection

- **Use ROCm-optimized [PyTorch](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/how-to/3rd-party/pytorch-install.html) or [TensorFlow](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/how-to/3rd-party/tensorflow-install.html)**: ROCm-specific framework builds include GPU kernels tuned for AMD hardware. Generic or CUDA-built packages either will not work on AMD GPUs or will fall back to slower, unoptimized code paths.

- **Use [vLLM](https://docs.vllm.ai/en/latest/) or [SGLang](https://docs.sglang.ai/) for LLM inference**: Serving a model with a simple loop processes one request at a time and leaves the GPU underutilized between requests. These inference frameworks implement continuous batching (handling multiple requests simultaneously) and memory-efficient attention, which together dramatically increase throughput. Both have official ROCm support — consult each project's documentation for AMD-specific configuration options.

- **Leverage [Transformer Engine](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/transformer-engine.html) for mixed-precision training and inference**: Transformer Engine automates FP8 mixed-precision by applying lower precision in performance-critical operations and maintaining higher precision where accuracy requires it, without requiring manual changes throughout a model.

### Model Optimization

- **Quantization**: Reducing weight precision from FP32 to BF16 or FP8 reduces memory usage and increases throughput. This is typically the first optimization to try for LLM serving.
- **Tensor parallelism**: For models that don't fit on a single GPU even at reduced precision, tensor parallelism distributes computation across multiple GPUs so all participate in each step. This tends to provide lower latency than pipeline parallelism for inference workloads.

For a comprehensive overview, refer to the [ROCm for AI Guide](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/index.html).

## High Performance Computing

### GPU-Aware MPI

Standard MPI copies GPU data through host RAM before sending it over the network. GPU-aware MPI (combined with RDMA-capable networking) reads and writes GPU memory directly, eliminating that intermediate copy and reducing inter-node communication overhead. See the [GPU-aware MPI with ROCm Guide](https://gpuopen.com/learn/amd-lab-notes/amd-lab-notes-gpu-aware-mpi-readme/) for configuration details.

### Optimized Math Libraries

AMD provides GPU-accelerated math libraries tuned for Instinct hardware. Using these ensures that common operations — matrix multiplications, FFTs, random number generation — run with hardware-optimized kernels rather than generic implementations:

- **[rocBLAS](https://rocm.docs.amd.com/projects/rocBLAS/en/latest/)**: GPU-accelerated BLAS routines (GEMM, etc.) optimized for AMD Matrix Cores
- **[rocRAND](https://rocm.docs.amd.com/projects/rocRAND/en/latest/)**: GPU-accelerated random number generation, which keeps data in GPU memory and avoids unnecessary transfers to and from the CPU

## Monitoring and Verification

### Real-Time GPU Monitoring

[AMD-smi](https://rocm.docs.amd.com/projects/amdsmi/en/latest/) provides real-time GPU telemetry. The basic commands are covered in [Environment Setup](environment-setup.md#gpu-monitoring); from an optimization perspective, the key metrics to watch during a running workload are:

```bash
# Monitor GPU utilization, memory usage, power, and temperature
amd-smi monitor --watch --interval 1000
```

- **GPU utilization**: Consistently low utilization on a running workload often means the GPU is waiting on data or CPU-side operations, not executing compute.
- **Memory bandwidth**: For memory-intensive workloads (such as LLM inference), high bandwidth utilization is expected. Significant headroom indicates the workload may not be structured to fully use available memory bandwidth.
- **Power and temperature**: Unexpected throttling due to thermal or power limits can silently reduce performance. Watch for sustained operation at or above thermal limits.

### Prometheus Metrics

For continuous monitoring across a fleet of systems, the [AMD Device Metrics Exporter](https://github.com/ROCm/device-metrics-exporter) provides Prometheus-compatible GPU metrics. This allows AMD-smi telemetry to be scraped by Prometheus and visualized in tools like Grafana — useful for tracking GPU health, utilization, and performance trends over time.

### Iterative Optimization

Optimization is rarely a one-time task. Fixing one bottleneck typically reveals the next:

1. Profile to identify the current bottleneck
2. Make one targeted change
3. Measure the result against your baseline
4. Repeat

For detailed guidance on applying this process to inference workloads, see the [Profiling and Debugging Guide](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/inference-optimization/profiling-and-debugging.html).

## Additional Resources

- [ROCm Documentation Home](https://rocm.docs.amd.com/)
- [ROCm System Optimization Guide](https://rocm.docs.amd.com/en/latest/how-to/system-optimization/index.html)
- [ROCm for AI Guide](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/index.html)
- [AMD ROCm Blogs](https://rocm.blogs.amd.com/)

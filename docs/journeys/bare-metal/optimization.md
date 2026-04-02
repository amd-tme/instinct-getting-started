# Optimization

This guide provides a high-level overview of optimization approaches for AMD Instinct accelerators in a single-node environment. It focuses on the *why* behind each recommendation — understanding the reasoning helps you prioritize changes that will have the most impact for your workload. For detailed, step-by-step instructions, follow the linked official documentation.

## System-Level Optimization

Before focusing on application-specific optimizations, ensure your system is properly configured. Misconfigured firmware and OS settings are among the most common causes of below-spec GPU performance, and they affect every workload running on the system.

### BIOS Configuration

- **Enable "Enhanced Preferred I/O" mode** (EPYC processors): This configures the PCIe topology so that GPU I/O requests are routed through the optimal NUMA domain, minimizing cross-socket traffic and reducing PCIe transfer latency.
- **Configure NUMA settings**: AMD EPYC processors expose multiple NUMA domains. When a GPU is accessed by a CPU core in a different NUMA domain, memory traffic must traverse the inter-socket interconnect (Infinity Fabric), which adds latency and reduces effective bandwidth. Proper NUMA configuration ensures GPU-adjacent CPU cores are used for GPU-driving workloads.
- **Disable CPU power management features**: Power-saving states (C-states, P-states) allow the processor to reduce frequency or enter sleep states during idle periods. When a GPU kernel completes and the CPU immediately needs to launch the next one, re-waking from a deep C-state introduces latency that accumulates across thousands of kernel dispatches. Disabling these features eliminates this variability.

Refer to the [System Optimization Guide](https://rocm.docs.amd.com/en/latest/how-to/system-optimization/index.html) for BIOS settings specific to your processor and Instinct GPU model. The [System Prerequisites](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/common/prerequisites.html) page in the Customer Acceptance Guide covers required firmware and BIOS configuration per GPU platform.

### Operating System Tuning

- **Configure huge pages**: The default Linux memory page size is 4 KB. GPU workloads routinely allocate buffers of several gigabytes, which requires the CPU's Translation Lookaside Buffer (TLB) to manage a very large number of page mappings. Enabling huge pages (2 MB or 1 GB) reduces TLB pressure and the cost of virtual-to-physical address translation, which shows up as improved effective memory bandwidth for large allocations.
- **Set appropriate process scheduling policies**: Real-time scheduling policies (such as `SCHED_FIFO`) prevent the OS from preempting the process that is driving the GPU. Preemptions stall the CPU-side command submission loop, which starves the GPU of work and creates idle gaps in the execution timeline.
- **Keep drivers and firmware current**: ROCm releases regularly include performance improvements, bug fixes, and new hardware workarounds. Running outdated drivers can mean missing significant gains that require no code changes.

The [ROCm System Optimization Guide](https://rocm.docs.amd.com/en/latest/how-to/system-optimization/index.html) includes GPU-specific pages (for example, [MI300X](https://instinct.docs.amd.com/projects/amdgpu-docs/en/latest/system-optimization/mi300x.html)) with the exact settings for each platform.

## Performance Profiling

Optimizing without profiling is guesswork. GPUs are complex pipelines — a kernel can be slow because it is compute-bound, memory-bandwidth-bound, latency-bound, or simply occupying the hardware inefficiently. The right fix depends entirely on which of these is the actual bottleneck, and profiling is the only reliable way to find out.

### Key Profiling Tools

ROCm provides a set of complementary tools that address different stages of the profiling workflow:

1. **[ROCProfiler SDK (rocprofv3)](https://rocm.docs.amd.com/projects/rocprofiler-sdk/en/latest/)** — The current-generation profiling API and command-line tool. Use this when you need hardware performance counter data, API traces, or want to integrate profiling into automated workflows and CI pipelines. It provides lower overhead than its predecessor and is the recommended starting point for command-line profiling.

2. **[ROCm Compute Profiler](https://rocm.docs.amd.com/projects/rocm-compute-profiler/en/latest/)** — A guided analysis tool that runs on top of ROCProfiler data. Use this when you want to understand *why* a kernel is slow: it categorizes kernels as compute-bound, memory-bound, or latency-bound and provides targeted recommendations. It is particularly useful when you have identified a hot kernel but are unsure how to improve it.

3. **[ROCProfiler (rocprof)](https://rocm.docs.amd.com/projects/rocprofiler/en/latest/)** — The previous-generation command-line profiler. Useful if you are working with tooling or scripts built against the older API. New projects should prefer rocprofv3.

For a practical walkthrough of applying these tools to AI inference workloads, see the [Profiling and Debugging Guide](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/inference-optimization/profiling-and-debugging.html).

## Memory Optimization

Memory is the most common bottleneck in GPU computing. AMD Instinct GPUs provide exceptional HBM bandwidth — but only workloads that are structured to exploit it will see those numbers in practice.

### Host-to-Device Data Movement

PCIe bandwidth between the host CPU and GPU (~64 GB/s bidirectional on PCIe 5.0 x16) is roughly 100x slower than the GPU's on-chip HBM bandwidth. Every byte that must cross that boundary is a potential bottleneck. Strategies to minimize this:

- Keep data resident on the GPU across multiple operations rather than round-tripping to host memory between kernels.
- Batch host-to-device transfers so the PCIe link is used efficiently rather than in many small transactions.
- Use asynchronous transfers (via HIP streams) to overlap data movement with GPU computation, hiding transfer latency behind useful work.

### Memory Access Patterns

How your kernel accesses GPU memory has a large impact on effective bandwidth:

- **Coalesced access**: Threads within a wavefront that access contiguous memory addresses allow the hardware to combine those requests into a single memory transaction. Non-coalesced (strided or random) access generates one transaction per thread, multiplying memory traffic and wasting bandwidth.
- **Shared memory**: On-chip shared memory has much lower latency and higher bandwidth than HBM. Using it as a staging area for data that is reused within a thread block reduces the number of round trips to HBM.

### Leveraging HBM Capacity and Bandwidth

AMD Instinct GPUs are designed around high-bandwidth memory, which is a key architectural advantage:

- CDNA 3 GPUs (MI300X, MI325X): 192–256 GB HBM3/HBM3E at up to ~6 TB/s
- CDNA 4 GPUs (MI350X, MI355X): up to 288 GB HBM3E at up to ~8 TB/s

The large HBM capacity means very large models can often fit on a single GPU (or a small number of GPUs) without offloading, eliminating a major source of latency. Algorithms should be structured to stream through this memory sequentially and keep the memory bus saturated — bandwidth utilization is the primary performance lever for memory-bound workloads.

## Compute Optimization

### Precision Selection

Using the lowest precision that meets your accuracy requirements is one of the highest-impact, lowest-effort optimizations available. Lower precision:

- Reduces memory footprint, allowing larger models or batch sizes to fit in HBM.
- Increases throughput: Matrix Cores execute low-precision operations at significantly higher FLOP rates than FP32 or FP64.

Supported precision formats by architecture:

- **CDNA 3 (MI300 series)**: FP8, BF16, FP16, TF32, FP32, FP64 in Matrix Cores
- **CDNA 4 (MI350 series)**: Adds MXFP4, MXFP6, MXFP8, and OCP FP8, enabling Microscaling-based formats for lower-precision inference with higher throughput

For most LLM inference workloads, BF16 provides a strong baseline with minimal accuracy impact. FP8 can provide additional throughput gains where quantization error is acceptable.

### Kernel-Level Optimization

If profiling reveals that a custom HIP kernel is the bottleneck, the primary levers are:

- **Occupancy**: GPUs hide memory latency by switching between in-flight wavefronts. If too few wavefronts are active (due to high register usage or large shared memory allocations), the compute unit stalls waiting for memory instead of executing other work. Increasing occupancy gives the hardware more wavefronts to switch between. The ROCm Compute Profiler reports occupancy and whether a kernel is bottlenecked by it.
- **Thread block dimensions**: Block size affects how work is distributed across compute units and how effectively shared memory is used. Experimentation guided by profiler data is usually required to find the optimal configuration for a given kernel.

For detailed guidance on HIP kernel optimization, refer to the [ROCm for AI — Workload Optimization Guide](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/inference-optimization/workload.html).

## Domain-Specific Optimizations

### AI and Machine Learning

#### Framework and Runtime Selection

- **Use ROCm-optimized [PyTorch](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/how-to/3rd-party/pytorch-install.html) or [TensorFlow](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/how-to/3rd-party/tensorflow-install.html)**: The ROCm-specific builds include custom GPU kernels tuned for AMD hardware, HIP-native operator implementations, and AMD-specific memory management. Generic or CUDA-built packages either will not run on AMD GPUs or will fall back to unoptimized code paths.

- **Use [vLLM](https://docs.vllm.ai/en/latest/) or [SGLang](https://docs.sglang.ai/) for LLM inference**: Naive inference implementations process one request at a time, leaving the GPU underutilized while waiting for the next request. These frameworks implement continuous batching (processing multiple requests simultaneously as they arrive) and memory-efficient attention (such as PagedAttention in vLLM), which together dramatically increase GPU utilization and throughput. Both have official ROCm support — consult each project's documentation for AMD-specific configuration options.

- **Leverage [Transformer Engine](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/transformer-engine.html) for LLM training and inference**: Transformer Engine provides FP8 mixed-precision with automatic precision management, allowing models to use FP8 in performance-critical matrix multiplications while maintaining FP16 or BF16 precision elsewhere. This maximizes Matrix Core utilization without requiring manual precision assignment throughout the model.

#### Model Optimization

- **Quantization**: Reducing weight and activation precision from FP32 to BF16, FP16, or FP8 reduces memory usage and increases throughput. For a 70B parameter model in FP16, this is the difference between requiring multiple GPUs and fitting on a single MI300X (192 GB HBM). CDNA 4 GPUs additionally support MXFP4/MXFP6/MXFP8 Microscaling formats for further compression.
- **Tensor parallelism**: Models that do not fit in a single GPU's HBM must be distributed across multiple GPUs. Tensor parallelism splits individual weight matrices across GPUs, enabling each GPU to hold a shard of every layer. This is preferred over pipeline parallelism for latency-sensitive inference because all GPUs participate in every token generation step.

For a comprehensive overview, refer to the [ROCm for AI Guide](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/index.html).

### High Performance Computing

#### GPU-Aware MPI

Standard MPI implementations transfer data by reading from host RAM. This means GPU-to-GPU transfers must follow the path: GPU HBM → PCIe → host RAM → network → host RAM → PCIe → GPU HBM. GPU-aware MPI (combined with RDMA-capable networking) eliminates the host RAM staging, allowing the network to read and write GPU memory directly. This can reduce inter-node communication latency by 2–4x for collective operations. See the [GPU-aware MPI with ROCm Guide](https://gpuopen.com/learn/amd-lab-notes/amd-lab-notes-gpu-aware-mpi-readme/) for configuration details.

#### Optimized Math Libraries

Use AMD's GPU-accelerated math libraries rather than generic or CPU implementations:

- **[rocBLAS](https://rocm.docs.amd.com/projects/rocBLAS/en/latest/)**: GPU-accelerated BLAS routines (GEMM, etc.) tuned for AMD Matrix Cores. Most AI and HPC workloads are dominated by matrix multiplications — using rocBLAS (directly or through frameworks that call it) ensures these are executed with hardware-optimized kernels.
- **[rocRAND](https://rocm.docs.amd.com/projects/rocRAND/en/latest/)**: GPU-accelerated random number generation. Generating random numbers on the CPU and copying them to the GPU is a common bottleneck in Monte Carlo and stochastic training workloads; rocRAND generates them directly in GPU memory.

## Optimization Verification

Optimization changes should be measured systematically. Without before-and-after comparison, it is easy to misattribute performance changes or miss regressions introduced alongside improvements.

1. **Establish a baseline first**: Before making changes, record performance metrics for your workload — throughput, latency, time-to-solution. Use consistent, repeatable inputs and warm up the GPU before measurement to avoid including initialization costs.

2. **Profile before and after**: Use [AMD-smi](https://rocm.docs.amd.com/projects/amdsmi/en/latest/) to monitor GPU utilization, HBM bandwidth, power draw, and thermal headroom during workload execution. A well-optimized workload should show high GPU utilization with memory bandwidth near the theoretical maximum for memory-bound workloads, or high compute utilization for compute-bound ones.

3. **Re-profile after each change**: Fixing one bottleneck often reveals the next. After addressing a memory access issue, a previously hidden compute bottleneck may become the new limiter. Profiling after each significant change ensures you are always targeting the actual bottleneck rather than optimizing code that is no longer on the critical path.

## Additional Resources

- [ROCm Documentation Home](https://rocm.docs.amd.com/)
- [ROCm System Optimization Guide](https://rocm.docs.amd.com/en/latest/how-to/system-optimization/index.html)
- [ROCm for AI Guide](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/index.html)
- [AMD ROCm Blogs](https://rocm.blogs.amd.com/)

# Optimization

This guide provides a high-level overview of optimization approaches for AMD Instinct accelerators in a single-node environment. For detailed, step-by-step instructions, refer to the linked official documentation.

## System-Level Optimization

Before focusing on application-specific optimizations, ensure your system is properly configured for maximum performance.

### BIOS Configuration

Proper BIOS settings are essential for optimal GPU performance:

- Enable "Enhanced Preferred I/O" mode for EPYC processors
- Configure NUMA settings appropriately for your workload and processor generation
- Disable power management features that can impact performance

Refer to the [System Optimization Guide](https://rocm.docs.amd.com/en/latest/how-to/system-optimization/index.html) for detailed BIOS settings based on your specific processor and Instinct GPU model. The [System Prerequisites](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/common/prerequisites.html) page in the Customer Acceptance Guide also covers required firmware and BIOS configuration per GPU platform.

### Operating System Tuning

Apply these OS-level optimizations:

- Set appropriate process scheduling policies
- Configure huge pages for improved memory performance
- Adjust kernel parameters for optimized I/O
- Ensure up-to-date drivers and firmware

The [ROCm System Optimization Guide](https://rocm.docs.amd.com/en/latest/how-to/system-optimization/index.html) includes GPU-specific pages (for example, [MI300X](https://instinct.docs.amd.com/projects/amdgpu-docs/en/latest/system-optimization/mi300x.html)) — check that guide for the page corresponding to your GPU model.

## Performance Profiling

Effective optimization starts with identifying bottlenecks through proper profiling.

### Key Profiling Tools

ROCm offers several profiling tools to analyze GPU performance:

1. **[ROCProfiler SDK (rocprofv3)](https://rocm.docs.amd.com/projects/rocprofiler-sdk/en/latest/)** - Next-generation profiling toolkit
   - Enhanced tracing capabilities
   - Improved initialization performance
   - Comprehensive API services

2. **[ROCm Compute Profiler](https://rocm.docs.amd.com/projects/rocm-compute-profiler/en/latest/)** - GUI-based analysis tool built on ROCProfiler
   - Visualizes performance data
   - Provides guided bottleneck identification
   - Offers memory analysis capabilities

3. **[ROCProfiler (rocprof)](https://rocm.docs.amd.com/projects/rocprofiler/en/latest/)** - Command-line tool for collecting hardware metrics and API traces
   - Lists performance counters
   - Tracks kernel execution
   - Monitors memory operations

Learn more about these tools in the [Profiling and Debugging Guide](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/inference-optimization/profiling-and-debugging.html).

## Memory Optimization

Memory performance is often a critical factor in GPU computing performance.

### Key Memory Optimization Strategies

1. **Minimize Host-Device Transfers**
   - Keep data on the GPU as long as possible
   - Batch transfers when possible
   - Use asynchronous memory operations

2. **Optimize Memory Access Patterns**
   - Ensure coalesced memory access
   - Minimize bank conflicts
   - Utilize shared memory effectively

3. **Leverage HBM Capacity and Bandwidth**
   - CDNA 3 GPUs (MI300X, MI325X) offer 192–256 GB HBM3/HBM3E at up to ~6 TB/s
   - CDNA 4 GPUs (MI350X, MI355X) offer up to 288 GB HBM3E at up to 8 TB/s
   - Structure algorithms to maximize bandwidth utilization; high-bandwidth memory is the key advantage of the Instinct architecture

4. **Memory Pool Management**
   - Use [hip-extensions](https://github.com/ROCm/hip-extensions) for memory allocations
   - Monitor memory fragmentation
   - Implement proper cleanup procedures

## Compute Optimization

Optimize computational aspects of your application for maximum performance.

### Kernel Optimization

1. **Occupancy Optimization**
   - Balance registers per thread
   - Tune thread block dimensions
   - Optimize shared memory usage

2. **Instruction Mix**
   - Utilize specialized instructions
   - Balance ALU vs. memory operations
   - Minimize control flow divergence
  
3. **Precision Selection**
   - CDNA 3 (MI300 Series): FP8, BF16, FP16, TF32, FP32, FP64 in Matrix Cores
   - CDNA 4 (MI350 Series): adds MXFP4, MXFP6, MXFP8, and OCP FP8 for lower-precision inference with Microscaling support
   - Lower precision reduces memory footprint and increases throughput; choose based on your accuracy requirements

### Workload-Specific Optimizations

For detailed workload-specific optimization guidance, refer to the [ROCm for AI — Inference Optimization Guide](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/inference-optimization/workload.html).

## Domain-Specific Optimizations

### AI and Machine Learning

1. **Framework Optimization**
   - Use ROCm-optimized [PyTorch](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/how-to/3rd-party/pytorch-install.html)/[TensorFlow](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/how-to/3rd-party/tensorflow-install.html)
   - Leverage [Transformer Engine](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/transformer-engine.html) for LLMs
   - Consider [vLLM](https://docs.vllm.ai/en/latest/) for optimized inference

2. **Model Optimization**
   - Explore quantization (FP16, BF16, FP8 on CDNA 3; additionally MXFP4/MXFP6/MXFP8 on CDNA 4)
   - Enable tensor parallelism for large models
   - Leverage sparsity support for additional inference throughput

For detailed ML optimization techniques, refer to the [ROCm for AI Guide](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/index.html). Note that [vLLM](https://docs.vllm.ai/en/latest/), [SGLang](https://docs.sglang.ai/), and other inference frameworks have AMD-specific configuration options — consult each project's documentation for ROCm-specific guidance.

### High Performance Computing

1. **Communication Optimization**
   - Configure GPU-aware MPI correctly
   - Optimize collective operations
   - Tune RDMA settings

2. **Math Library Selection**
   - Use optimized libraries ([rocBLAS](https://rocm.docs.amd.com/projects/rocBLAS/en/latest/), [rocRAND](https://rocm.docs.amd.com/projects/rocRAND/en/latest/), etc.)
   - Leverage highly-tuned algorithmic implementations
   - Consider architecture-specific math routines

For more on HPC optimization, see the [GPU-aware MPI with ROCm Guide](https://gpuopen.com/learn/amd-lab-notes/amd-lab-notes-gpu-aware-mpi-readme/).

## Optimization Verification

After implementing optimizations, verify the results:

1. **Benchmark Comparison**
   - Compare performance before and after optimizations
   - Use standard benchmarks relevant to your workload
   - Examine scaling characteristics

2. **Profiling Validation**
   - Confirm bottlenecks have been addressed
   - Identify any new performance limiters
   - Measure key metrics improvement

3. **Performance Monitoring**
   - Use [AMD-smi](https://rocm.docs.amd.com/projects/amdsmi/en/latest/) for real-time monitoring
   - Track thermal and power characteristics
   - Monitor memory usage patterns

## Additional Resources

- [ROCm Documentation Home](https://rocm.docs.amd.com/)
- [AMD ROCm Blogs](https://rocm.blogs.amd.com/)

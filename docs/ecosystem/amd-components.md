# AMD Components

*Last reviewed: 2026-03-31*

These components are developed, maintained, and supported by AMD. They form the
foundation of every AMD Instinct deployment.

## ROCm Core SDK

The foundational software layer for programming AMD GPUs. ROCm is primarily open
source and provides compilers, runtimes, libraries, and tools.

[What is ROCm](https://rocm.docs.amd.com/en/latest/what-is-rocm.html) |
[ROCm Libraries](https://rocm.docs.amd.com/en/latest/reference/api-libraries.html) |
[ROCm Tools](https://rocm.docs.amd.com/en/latest/reference/rocm-tools.html) |
[HIPIFY (CUDA porting)](https://rocm.docs.amd.com/projects/HIPIFY/en/latest/)

### Runtime and compilers

Portable GPU programming model and compiler toolchain.

| Component | Description |
|-----------|-------------|
| [HIP](https://rocm.docs.amd.com/projects/HIP/en/latest/) | Portable GPU programming interface |
| [ROCm Compilers (LLVM)](https://rocm.docs.amd.com/projects/llvm-project/en/latest/) | GPU compiler toolchain |
| [HIPCC](https://rocm.docs.amd.com/projects/HIPCC/en/latest/) | HIP compiler driver |
| [OpenMP](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-hpc/index.html) | Directive-based GPU offloading for HPC |
| OpenCL | Open standard for heterogeneous compute |

### Math and compute libraries

Optimized numerical primitives for linear algebra, FFT, sparse operations, and
matrix math.

| Component | Description |
|-----------|-------------|
| [hipBLAS](https://rocm.docs.amd.com/projects/hipBLAS/en/latest/) / [rocBLAS](https://rocm.docs.amd.com/projects/rocBLAS/en/latest/) | GPU-accelerated BLAS operations |
| [hipBLASLt](https://rocm.docs.amd.com/projects/hipBLASLt/en/latest/) | Lightweight BLAS with mixed-precision support |
| [hipFFT](https://rocm.docs.amd.com/projects/hipFFT/en/latest/) / [rocFFT](https://rocm.docs.amd.com/projects/rocFFT/en/latest/) | Fast Fourier transform |
| [hipRAND](https://rocm.docs.amd.com/projects/hipRAND/en/latest/) / [rocRAND](https://rocm.docs.amd.com/projects/rocRAND/en/latest/) | Random number generation |
| [hipSOLVER](https://rocm.docs.amd.com/projects/hipSOLVER/en/latest/) / [rocSOLVER](https://rocm.docs.amd.com/projects/rocSOLVER/en/latest/) | Dense linear solvers |
| [hipSPARSE](https://rocm.docs.amd.com/projects/hipSPARSE/en/latest/) / [rocSPARSE](https://rocm.docs.amd.com/projects/rocSPARSE/en/latest/) | Sparse linear algebra |
| [rocWMMA](https://rocm.docs.amd.com/projects/rocWMMA/en/latest/) | Wave matrix multiply-accumulate |
| [Tensile](https://rocm.docs.amd.com/projects/Tensile/en/latest/) | GEMM kernel generation |

### AI libraries

Deep learning primitives, graph inference, and kernel composition.

| Component | Description |
|-----------|-------------|
| [MIOpen](https://rocm.docs.amd.com/projects/MIOpen/en/latest/) | GPU-accelerated deep learning primitives |
| [MIGraphX](https://rocm.docs.amd.com/projects/AMDMIGraphX/en/latest/) | Graph-based inference optimization engine |
| [Composable Kernel](https://rocm.docs.amd.com/projects/composable_kernel/en/latest/) | Kernel composition and fusion framework |

### Parallel primitives

GPU-accelerated parallel algorithms and abstractions.

| Component | Description |
|-----------|-------------|
| [hipCUB](https://rocm.docs.amd.com/projects/hipCUB/en/latest/) | Collective primitives for GPU programming |
| [rocPRIM](https://rocm.docs.amd.com/projects/rocPRIM/en/latest/) | Parallel primitive operations |
| [rocThrust](https://rocm.docs.amd.com/projects/rocThrust/en/latest/) | High-level parallel algorithms |
| [hipTensor](https://rocm.docs.amd.com/projects/hipTensor/en/latest/) | Tensor contraction operations |

### Communication libraries

Multi-GPU and multi-node collective communication.

| Component | Description |
|-----------|-------------|
| [RCCL](https://rocm.docs.amd.com/projects/rccl/en/latest/) | Collective communication across GPUs and nodes |
| [rocSHMEM](https://rocm.docs.amd.com/projects/rocSHMEM/en/latest/) | OpenSHMEM implementation for GPU memory |

### Media and vision

Image/video decode, augmentation, and computer vision pipelines.

| Component | Description |
|-----------|-------------|
| [rocDecode](https://rocm.docs.amd.com/projects/rocDecode/en/latest/) | Hardware video decoding |
| [rocJPEG](https://rocm.docs.amd.com/projects/rocJPEG/en/latest/) | JPEG decoding on GPU |
| [MIVisionX](https://rocm.docs.amd.com/projects/MIVisionX/en/latest/) | Computer vision and neural net inference toolkit |
| [rocAL](https://rocm.docs.amd.com/projects/rocAL/en/latest/) | Data augmentation library |
| [RPP](https://rocm.docs.amd.com/projects/rpp/en/latest/) | Raster processing primitives |

### Profiling and debugging

Performance profiling, tracing, and debugging tools.

| Component | Description |
|-----------|-------------|
| [ROCProfiler](https://rocm.docs.amd.com/projects/rocprofiler/en/latest/) | GPU kernel profiling |
| [ROCProfiler SDK](https://rocm.docs.amd.com/projects/rocprofiler-sdk/en/latest/) | Programmatic profiling interface |
| [ROCTracer](https://rocm.docs.amd.com/projects/roctracer/en/latest/) | API and activity tracing |
| [ROCgdb](https://rocm.docs.amd.com/projects/ROCgdb/en/latest/) | Source-level GPU debugger |
| [ROCm Compute Profiler](https://rocm.docs.amd.com/projects/rocprofiler-compute/en/latest/) | Compute kernel analysis |
| [ROCm Systems Profiler](https://rocm.docs.amd.com/projects/rocprofiler-systems/en/latest/) | System-wide performance analysis |

### System management

GPU monitoring, health, power, and utilization metrics.

| Component | Description |
|-----------|-------------|
| [AMD SMI](https://rocm.docs.amd.com/projects/amdsmi/en/latest/) | GPU system management interface |
| [ROCm SMI](https://rocm.docs.amd.com/projects/rocm_smi_lib/en/latest/) | GPU monitoring and control library |

## GPU infrastructure and drivers

| Component | Description |
|-----------|-------------|
| **AMD GPU Driver (amdgpu)** | Kernel-mode driver for AMD Instinct GPUs |
| [GIM Virtualization Driver](https://instinct.docs.amd.com/latest/system-admin/virtualization.html) | SR-IOV GPU virtualization for multi-tenant environments |
| [AMD GPU Operator](https://instinct.docs.amd.com/projects/gpu-operator/en/latest/) | Kubernetes operator for automated driver install, device plugin, metrics, and node labeling |
| [K8s Device Plugin](https://instinct.docs.amd.com/projects/k8s-device-plugin/en/latest/) | Exposes AMD GPUs as schedulable resources in Kubernetes |
| [Device Metrics Exporter](https://instinct.docs.amd.com/projects/device-metrics-exporter/en/latest/) | Exports GPU metrics to Prometheus |
| [AMD Container Toolkit](https://instinct.docs.amd.com/projects/container-toolkit/en/latest/) | Container runtime hooks for GPU access |
| [GPU Partitioning](https://rocm.docs.amd.com/en/latest/conceptual/gpu-isolation.html) | Compute and memory partitioning for workload isolation |

[Instinct Documentation](https://instinct.docs.amd.com) |
[GPU Operator](https://instinct.docs.amd.com/projects/gpu-operator/en/latest/)

## AMD Enterprise AI Suite

A full-stack Kubernetes-native platform for enterprise AI workloads. Provides
management, orchestration, and serving layers above ROCm.

| Component | Description |
|-----------|-------------|
| [AMD AI Resource Manager](https://enterprise-ai.docs.amd.com/en/resource-manager/overview.html) | Multi-tenant GPU resource orchestration, quotas, and project isolation |
| [AMD AI Workbench](https://enterprise-ai.docs.amd.com/en/workbench/overview.html) | Development environment for fine-tuning, evaluation, and experimentation |
| [AMD Inference Microservices (AIM)](https://enterprise-ai.docs.amd.com/en/workbench/inference/overview.html) | Pre-packaged, optimized inference containers for serving LLMs on Instinct GPUs |
| **AI-Native Workload Orchestration** | Intelligent job scheduling and dynamic resource allocation |
| **Solution Blueprints** | Pre-validated deployment patterns and reference architectures |

[Enterprise AI Suite documentation](https://enterprise-ai.docs.amd.com/en/latest/platform-overview.html)

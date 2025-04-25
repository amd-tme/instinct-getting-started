# Hardware Selection Guide for AMD Instinct GPUs

:::{card}
:class-card: journey-progress
**[Hardware Selection](hardware-selection.md)** → [Installation](installation.md) → [Validation](validation.md) → [Optimization](optimization.md)
:::

## Introduction

Selecting the right AMD Instinct GPU accelerator for your workload is a critical first step in your bare metal deployment journey. This guide will help you understand the available options and make an informed decision based on your specific requirements.

## AMD Instinct Product Families

AMD offers several generations of Instinct accelerators, each optimized for different types of workloads:

### Instinct MI300/MI325X Series

The MI300/MI325X series represents AMD's latest generation of accelerators, designed for the most demanding AI and HPC workloads.

**MI325X**: AMD's flagship AI accelerator

- 256GB HBM3E memory with 6 TB/s memory bandwidth
- Built on the AMD CDNA 3 architecture
- Up to 1307 TFLOPS of half precision (FP16/BF16) performance
- 2614 TFLOPS peak theoretical 8-bit precision (FP8)
- Supports INT8, FP8, BF16, FP16, FP32, and FP64 precisions
- OAM (OCP Accelerator Module) form factor
- Platform configurations with up to 8 fully-connected accelerators
- Ideal for: Foundation model training, large language models, generative AI, and memory-intensive workloads

**MI300X**: Previous generation dedicated GPU accelerator

- 192GB HBM3 memory
- 5.3 TB/s memory bandwidth
- Optimized for AI inference and training
- Ideal for: Large language models (LLMs), generative AI, and high-memory workloads

### Instinct MI200 Series

The MI200 series offers excellent performance for a wide range of HPC and AI workloads.

**MI250X**: High-performance accelerator with dual-GPU design

- 128GB HBM2e memory
- Up to 383 TFLOPS half-precision (FP16)
- Industry-leading FP64 performance for scientific computing
- Ideal for: Traditional HPC, scientific simulations, and mixed-precision AI

**MI250**: Cost-effective version of the MI250X

- Similar architecture with slightly lower specifications
- Good balance of performance and value

**MI210**: Entry-level option in the MI200 series

- Designed for smaller workloads and development environments
- Lower power requirements

## Workload Considerations

When selecting your Instinct GPU, consider these key factors:

### Memory Requirements

- **Large AI Models**: For large language model training or inference, prioritize accelerators with the highest memory capacity (MI325X with 256GB)
- **Multi-billion Parameter Models**: MI325X can fit larger models or more batch sizes in a single GPU
- **HPC Simulations**: For memory-intensive scientific computing, MI325X offers the most HBM3E capacity
- **Cost-sensitive Deployments**: MI300X or MI250X provide good memory capacity at different price points

### Precision Needs

Different workloads require different numerical precision:

- **AI Training and Inference**: Benefits from FP16, BF16, and FP8 (MI300 series)
- **Scientific Computing**: May require FP64 double-precision (MI250X excels here)
- **Mixed Precision**: Consider accelerators supporting multiple precision formats

### Scale Requirements

- **Single-node**: All Instinct GPUs work well in single-node configurations
- **Multi-node**: For large clusters, consider the Infinity Fabric connectivity options
- **Specialized infrastructure**: Liquid cooling may be required for maximum performance

## Deployment Considerations

### Power and Cooling

- MI325X: Up to 1000W per accelerator
- MI300X: Up to 750W per accelerator
- MI250X: Up to 560W per accelerator
- Ensure your infrastructure can support the power and cooling requirements
- Consider liquid cooling solutions for maximum performance, especially for MI325X platforms

### System Integration

- Requires compatible server platforms with PCIe Gen 4/5 support
- Consider OCP Accelerator Module (OAM) form factor requirements
- Verify host CPU compatibility (AMD EPYC processors recommended)

### Software Stack

- All Instinct accelerators use the AMD ROCm™ software platform
- Verify software compatibility with your application stack
- Consider the level of software optimization available for your specific workloads

## Choosing the Right Solution

### For AI and Machine Learning

- **Large model inference**: MI325X (highest memory capacity at 256GB)
- **AI training**: MI325X for large models, MI250X for smaller models
- **Generative AI**: MI325X (optimized for LLMs and diffusion models)
- **Cost-sensitive AI**: MI300X or MI250X (balance of performance and value)

### For HPC and Scientific Computing

- **Double-precision workloads**: MI325X or MI250X (both offer excellent FP64 performance)
- **Memory-bound simulations**: MI325X (largest memory capacity)
- **Mixed workloads**: MI325X (versatile precision support from INT8 to FP64)

## Next Steps

Once you've determined the appropriate hardware for your workload:

- [Server Configuration Guide](../server-configuration)
- [Installation and Setup](../installation-setup)
- [Validation and Testing](../validation-testing)

## Additional Resources

- [Detailed Specifications](https://www.amd.com/en/products/accelerators/instinct.html)
- [Performance Benchmarks](https://www.amd.com/en/technologies/infinity-hub.html)
- [ROCm Software Platform](https://www.amd.com/en/graphics/servers-solutions-rocm.html)
# Hardware Selection

## Introduction

Selecting the right AMD Instinct GPU accelerator is the first step in your bare metal deployment. This page provides a high-level overview of the current Instinct product lineup and key selection criteria. For detailed per-GPU specifications, validation requirements, and acceptance criteria, refer to the [AMD Instinct Customer Acceptance Guide](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/).

## AMD CDNA Architecture Overview

All AMD Instinct GPUs are built on the AMD CDNA™ compute architecture. Current products span two generations:

| | CDNA 3 | CDNA 4 |
|---|---|---|
| **Process** | 5nm + 6nm FinFET | 3nm + 6nm FinFET |
| **Products** | MI300 Series (MI300X, MI325X) | MI350 Series (MI350X, MI355X) |
| **Memory** | Up to 256 GB HBM3E | Up to 288 GB HBM3E |
| **Peak Bandwidth** | Up to ~6 TB/s | Up to 8 TB/s |
| **Matrix data types** | INT8, FP8, BF16, FP16, TF32, FP32, FP64 | MXFP4, MXFP6, INT8, MXFP8, OCP FP8, BF16, FP16, TF32\*, FP32, FP64 |
| **Sparsity** | INT8, FP8, BF16, FP16 | OCP FP8, INT8, FP16, BF16 |

\* TF32 is supported by software emulation on CDNA 4.

For a full architecture comparison across all CDNA generations, see the [AMD CDNA Architecture page](https://www.amd.com/en/technologies/cdna.html).

## Current Products

### CDNA 4: MI350 Series

AMD's latest compute architecture. CDNA 4 doubles the matrix compute throughput for low-precision data types compared to CDNA 3, and adds Microscaling (MX) format support (MXFP4, MXFP6, MXFP8) for greater flexibility in balancing model accuracy, speed, and power efficiency.

#### MI355X

- AMD CDNA 4 architecture
- Highest memory capacity in the current Instinct lineup
- Designed for the most demanding large-scale AI training, LLM inference, and memory-bound HPC
- OAM form factor; up to 8 fully-connected accelerators per node

#### MI350X

- AMD CDNA 4 architecture
- High-throughput AI and HPC with large HBM3E memory capacity
- Well-suited for generative AI, large model inference, and scientific computing
- OAM form factor; up to 8 accelerators per node

### CDNA 3: MI300 Series

AMD's previous generation, widely deployed across AI and HPC workloads. CDNA 3 introduced chiplet-based packaging, shared AMD Infinity Cache, and FP8 support for the Instinct product line.

#### MI325X

- AMD CDNA 3 architecture
- 256 GB HBM3E memory, ~6 TB/s peak bandwidth
- 1,216 Matrix Cores; supports INT8, FP8, BF16, FP16, TF32, FP32, FP64
- OAM form factor

#### MI300X

- AMD CDNA 3 architecture
- 192 GB HBM3 memory, ~5.3 TB/s peak bandwidth
- Proven across many production AI and HPC deployments
- OAM form factor

For side-by-side specifications, performance benchmarks, and platform requirements for each GPU, see the [Customer Acceptance Guide GPU pages](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/).

## Previous Generation

AMD Instinct MI200 Series GPUs (MI250X, MI250, MI210) are built on CDNA 2 architecture and are not covered by the full acceptance workflow in the current acceptance guide, but remain supported under ROCm for existing deployments. If you are working with MI200 Series hardware, refer to the [AMD Instinct Documentation](https://instinct.docs.amd.com/latest/) for available guidance.

## Workload Considerations

### Memory Capacity

The large HBM memory footprint of the Instinct lineup is a key differentiator for AI and HPC work:

- **Large language models and generative AI**: Prioritize memory capacity — models with tens to hundreds of billions of parameters may require 192 GB or more to run efficiently at full precision or with larger batch sizes. MI355X and MI350X offer the highest capacity in the current lineup.
- **HPC simulations**: Memory-bound scientific workloads benefit from high HBM bandwidth and capacity.
- **Development and testing**: Any current-generation Instinct GPU is suitable; choose based on the production target you are developing toward.

### Precision and Data Types

CDNA 3 and CDNA 4 differ in their low-precision format support, which is relevant for inference optimization:

- **CDNA 4 (MI350 Series)** adds Microscaling (MX) formats — MXFP4, MXFP6, MXFP8 — enabling finer-grained quantization for LLM inference with lower memory and power cost. It also supports OCP FP8, BF16, FP16, FP32, and FP64.
- **CDNA 3 (MI300 Series)** supports FP8, BF16, FP16, TF32, FP32, and FP64. Well-established software support across PyTorch, JAX, and inference frameworks.

For scientific computing with strict FP64 requirements, both generations offer strong FP64 throughput — verify peak FP64 performance for your specific GPU against your workload's needs.

### Scale

- **Single-node inference or development**: Any current-generation Instinct GPU works well.
- **Multi-node training or large-scale HPC**: Plan your interconnect (InfiniBand, Ethernet, and AMD Infinity Fabric topology) alongside GPU selection — see the [GPU Cluster Networking Guide](https://instinct.docs.amd.com/projects/gpu-cluster-networking/en/latest/).

## Platform and Infrastructure Requirements

All current-generation Instinct OAM-form-factor GPUs share similar infrastructure requirements:

- **Server platform**: OAM-compatible server chassis (typically 8 GPUs per node)
- **CPU**: AMD EPYC processors recommended for optimal PCIe and NUMA topology; MI350 Series GPUs support PCIe 5
- **Power and cooling**: High-density power delivery and liquid or high-flow air cooling required; refer to your server vendor's thermal design documentation
- **Firmware and BIOS**: Specific firmware versions and BIOS settings are required before installing ROCm — see [System Prerequisites](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/common/prerequisites.html) in the acceptance guide

## Next Steps

Once you have identified the right GPU for your workload:

1. Review the [System Prerequisites](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/common/prerequisites.html) to ensure your server platform is correctly configured before installing software
2. Proceed to [Installation](installation.md) to install ROCm
3. Follow [Validation](validation.md) to confirm your system is operating correctly

## Additional Resources

- [AMD CDNA Architecture](https://www.amd.com/en/technologies/cdna.html) — Architecture overview, data type support, and whitepaper links for each generation
- [AMD Instinct Customer Acceptance Guide](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/) — Per-GPU validation workflows, specifications, and acceptance criteria
- [AMD Instinct Documentation Hub](https://instinct.docs.amd.com/latest/) — Full documentation for Instinct products and software
- [AMD Instinct Product Page](https://www.amd.com/en/products/accelerators/instinct.html) — Product family overview and datasheet links


# Microsoft Azure

## Overview

Microsoft Azure is one of the world's leading cloud service providers, offering a comprehensive suite of cloud solutions including infrastructure as a service (IaaS), platform as a service (PaaS), and software as a service (SaaS). Azure has partnered with AMD to provide high-performance GPU computing solutions powered by AMD Instinct GPUs.

## Available AMD Instinct GPU Instances

### Azure ND MI300X v5 Series

The Azure ND MI300X v5 series is Microsoft's latest GPU-accelerated virtual machine offering powered by AMD Instinct MI300X accelerators. These VMs are specifically designed for demanding AI and high-performance computing (HPC) workloads.

**Key Specifications:**

- **GPU**: 8x AMD Instinct MI300X accelerators per VM
- **CPU**: Two 4th Gen Intel Xeon Scalable processors with 96 physical cores
- **Memory**: 1.5TB of HBM3 GPU memory with 5.3TB/s bandwidth
- **System Memory**: 2TB
- **Interconnect**: AMD Infinity Fabric links with 128 GB/s bandwidth per GPU (896 GB/s aggregate)
- **Networking**: Dedicated 400 Gb/s NVIDIA Quantum-2 CX7 InfiniBand connection per GPU
- **Scalability**: Up to thousands of GPUs with 3.2 Tb/s of interconnect bandwidth per VM

These instances are optimized for large-scale AI training, large language model (LLM) inference, and other memory-intensive AI workloads.

### Azure NVv4 Series

The Azure NVv4 series offers virtual desktop infrastructure (VDI) solutions powered by AMD Radeon Instinct MI25 GPUs.

**Key Features:**

- **GPU**: AMD Radeon Instinct MI25 GPUs
- **CPU**: AMD EPYC 7742 processor
- **GPU Virtualization**: SR-IOV-based fractional GPU virtualization
- **Flexibility**: Four configurable options to deliver customized GPU capability
- **Use Cases**: Financial analysis, architecture, engineering, and design applications

The NVv4 series provides a cost-effective solution for desktop virtualization with zero-cost license GPU partitioning.

## Getting Started with Azure AMD Instinct GPUs

### Prerequisites

- An active Azure account
- Sufficient quota for GPU VMs in your subscription
- Basic knowledge of Azure Virtual Machines

### Deploying an ND MI300X v5 VM

1. **Sign in to the Azure Portal**
   Visit [portal.azure.com](https://portal.azure.com) and sign in with your Azure account.

2. **Create a new Virtual Machine**
   - Click on "Create a resource"
   - Search for and select "Virtual Machine"
   - Click "Create"

3. **Configure the VM settings**
   - Choose your subscription and resource group
   - Enter a name for your VM
   - Select a region where ND MI300X v5 is available
   - Select the ND MI300X v5 size from the available VM sizes
   - Configure authentication and other settings as needed

4. **Install ROCm**
   Follow the standard ROCm installation procedure for Linux VMs. Azure provides optimized VM images with ROCm pre-installed.

## Pricing and Availability

Pricing for ND MI300X v5 instances varies by region and commitment term. For the most up-to-date pricing information, visit the [Azure Pricing Calculator](https://azure.microsoft.com/en-us/pricing/calculator/).

Currently, the ND MI300X v5 series is available in select Azure regions with plans for broader availability in the future.

## Documentation and Resources

- [Azure ND MI300X v5 Documentation](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/gpu-accelerated/ndmi300xv5-series)
- [GPU Computing on Azure](https://azure.microsoft.com/en-us/solutions/gpu-computing/)
- [Azure AMD Partnership](https://azure.microsoft.com/en-us/partners/directory/amd-corporation/)
- [ROCm on Azure Documentation](https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/hpc/rocm-installation)

## Support

- [Azure Support](https://azure.microsoft.com/en-us/support/options/)
- [Azure Community Forums](https://learn.microsoft.com/en-us/answers/products/azure)
- [AMD ROCm Community](https://www.amd.com/en/developer/resources/rocm-hub/forums.html)

# Vultr

## Overview

Vultr is one of the world's largest privately-held cloud infrastructure companies, providing global access to high-performance computing resources. Vultr has partnered with AMD to offer AMD Instinct GPUs for AI/ML, high-performance computing, and other GPU-intensive workloads.

## Available AMD Instinct GPU Instances

### AMD Instinct MI300X

Vultr offers AMD Instinct MI300X GPUs for AI and ML workloads, designed to handle compute-intensive tasks efficiently.

**Key Features:**

- **GPU**: AMD Instinct MI300X accelerators
- **Memory**: 192GB of HBM3 memory per GPU
- **Deployment Options**: Available as either virtual machines or bare metal
- **Use Cases**: Ideal for AI/ML, deep learning, and high-performance computing

### AMD Instinct MI325X

In addition to the MI300X, Vultr has recently deployed AMD Instinct MI325X GPUs in its Chicago data center region.

**Key Specifications:**

- **GPU**: AMD Instinct MI325X
- **Memory**: 256GB of HBM3E memory with 8 TB/s of memory bandwidth
- **Server Hardware**: Supermicro AS-8126GS-TNMR 8-U servers
- **Performance**: Optimized for demanding AI tasks including foundation model training, fine-tuning, and inference

## Getting Started with Vultr AMD Instinct GPUs

### Prerequisites

- A Vultr account
- Basic knowledge of cloud computing and GPU instances
- Understanding of the AMD ROCm platform

### Deploying an AMD Instinct GPU Instance

1. **Sign up or log in to Vultr**
   Visit [vultr.com](https://www.vultr.com) and create an account or sign in to your existing account.

2. **Deploy a new server**
   - Click on the "+" button to deploy a new server
   - Select a location close to your target users
   - Under server type, select "Cloud GPU"
   - Choose the AMD Instinct option that fits your requirements
   - Select an operating system
   - Configure additional options as needed
   - Click "Deploy Now"

3. **Connect to your server**
   - Once deployed, you'll receive login credentials
   - Connect via SSH (Linux) or RDP (Windows)
   - Verify GPU availability using ROCm tools

### Using SR-IOV-based GPU Virtualization

Vultr uses Single Root I/O Virtualization (SR-IOV) based GPU partitioning, offering flexibility in GPU resource allocation. This allows you to select just the right amount of GPU resources needed for your workload, making GPU-accelerated computing more cost-effective.

## Documentation and Resources

- [Vultr Cloud GPU Pricing](https://www.vultr.com/pricing/#cloud-gpu)
- [AMD ROCm Documentation](https://rocm.docs.amd.com/)
- [AMD-Vultr Partnership](https://www.vultr.com/cloudalliance/amd/)

## Support

- [Vultr Support](https://www.vultr.com/support/)
- [Vultr Knowledge Base](https://docs.vultr.com/)

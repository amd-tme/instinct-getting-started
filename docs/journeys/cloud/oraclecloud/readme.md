# Oracle Cloud Infrastructure AMD Instinct GPU Offerings

## Overview

Oracle Cloud Infrastructure (OCI) is a comprehensive cloud solution that provides a wide range of computing services including high-performance computing with AMD Instinct GPUs. OCI has partnered with AMD to offer some of the most powerful and cost-effective GPU solutions for AI and HPC workloads.

## Available AMD Instinct GPU Instances

### OCI BM.GPU.MI300X.8

Oracle Cloud offers the BM.GPU.MI300X.8 instance, featuring AMD Instinct MI300X accelerators on bare metal for maximum performance.

**Key Specifications:**

- **GPU**: 8x AMD Instinct MI300X accelerators per instance
- **Memory**: 192GB of HBM3 memory per GPU (1.5TB total GPU memory)
- **Performance**: Optimized for large language model (LLM) inference and training
- **Deployment**: Offered as bare metal instances to eliminate virtualization overhead
- **Pricing**: $6 per GPU-hour, providing competitive price/performance ratio
- **Scalability**: OCI Supercluster supports up to 16,384 AMD MI300X GPUs in a single cluster

These instances are designed to handle complex computational tasks with advanced GPUs, high memory capacity, and ultrafast network fabric.

## Getting Started with OCI AMD Instinct GPUs

### Prerequisites

- An active Oracle Cloud account
- Sufficient service limits for GPU resources
- Basic knowledge of OCI compute instances

### Deploying a BM.GPU.MI300X.8 Instance

1. **Sign in to the OCI Console**
   Visit [cloud.oracle.com](https://cloud.oracle.com) and sign in to your OCI account.

2. **Navigate to Compute**
   - From the hamburger menu, select "Compute"
   - Click on "Instances"
   - Click "Create Instance"

3. **Configure the Instance**
   - Enter a name for your instance
   - Choose a compartment
   - Select an availability domain where BM.GPU.MI300X.8 is available
   - In the "Image and shape" section, click "Change shape"
   - Select "Bare Metal Machine" and look for BM.GPU.MI300X.8
   - Configure networking, storage, and other settings as needed

4. **Install ROCm**
   Oracle provides optimized images with ROCm pre-installed, or you can install it manually following AMD's documentation.

### Try Before You Buy Program

Oracle offers a "try-before-you-buy" program for OCI Compute with AMD Instinct MI300X GPUs, allowing potential customers to test the capabilities before committing to a purchase. Visit the [AMD Evaluation Program](https://www.amd.com/en/products/accelerators/instinct/eval-request/oracle-cloud-infrastructure.html) to apply.

## Documentation and Resources

- [OCI GPU Computing](https://www.oracle.com/cloud/compute/gpu/)
- [OCI Compute Documentation](https://docs.oracle.com/en-us/iaas/Content/Compute/Concepts/computeoverview.htm)
- [General Availability of OCI Compute with AMD Instinct MI355X GPUs](https://blogs.oracle.com/cloud-infrastructure/announcing-general-availability-of-oci-amd-mi355x)

## Support

- [OCI Support](https://support.oracle.com/)

## Pricing and Availability

OCI offers AMD Instinct MI300X GPUs at $6 per GPU-hour for bare metal instances. This pricing makes OCI one of the most cost-effective cloud providers for AMD GPU compute.

For the most current pricing and availability information, visit the [OCI Pricing Calculator](https://www.oracle.com/cloud/cost-estimator.html).

# IBM Cloud

## Overview

IBM Cloud is an enterprise-grade cloud computing platform designed for security, compliance, and hybrid cloud capabilities. IBM has collaborated with AMD to deploy AMD Instinct MI300X accelerators as a service on IBM Cloud, available through IBM Cloud Virtual Servers for VPC. This offering is currently under select availability.

## Available AMD Instinct GPU Instances

### IBM Cloud Virtual Servers for VPC with AMD Instinct MI300X

IBM Cloud offers AMD Instinct MI300X accelerators through Virtual Servers for Virtual Private Cloud (VPC).

**Instance Specifications:**

- **GPUs**: 8x AMD Instinct MI300X accelerators
- **GPU Memory**: 192 GB HBM3 per GPU (1.5 TB total)
- **vCPUs**: 208
- **System Memory**: 1,792 GB RAM
- **Storage**: 8x 3.2 TB NVMe instance storage

**Availability**: Currently under select availability. Contact IBM Cloud or open a [support case](https://cloud.ibm.com/docs/account?topic=account-open-case&interface=ui) to request access.

### Container Platform Support

IBM Cloud supports AMD Instinct MI300X accelerators through:

- **IBM Cloud Kubernetes Service** — managed Kubernetes for containerized AI workloads
- **Red Hat OpenShift on IBM Cloud** — enterprise Kubernetes with OpenShift tooling

### Integration with IBM watsonx

AMD Instinct MI300X accelerators on IBM Cloud integrate with IBM's watsonx AI platform, providing:

- Additional AI infrastructure resources for watsonx customers
- Support for Red Hat Enterprise Linux AI (RHEL AI) inferencing
- Red Hat OpenShift AI for model serving and MLOps workflows
- Efficient GenAI inferencing for IBM and partner models

## Use Cases

### Enterprise AI Inferencing

The 192 GB HBM3 memory capacity per GPU enables:

- Running large foundation models with fewer GPUs
- Memory-efficient deployment of 70B+ parameter models on a single GPU
- Cost-effective generative AI at scale

### HPC Applications

IBM Cloud and AMD enable enterprise AI and HPC across hybrid environments, with support for FP8, FP16, BF16, and INT8 precision for mixed-precision workloads.

## Getting Started with IBM Cloud AMD Instinct GPUs

### Prerequisites

- An active IBM Cloud account
- Sufficient VPC quota for GPU instances
- A support case submitted to request access to the MI300X offering

### Deploying a GPU Instance

1. **Request Access**
   Open a [support case on IBM Cloud](https://cloud.ibm.com/docs/account?topic=account-open-case&interface=ui) expressing interest in AMD Instinct MI300X GPU instances on IBM Cloud VPC.

2. **Review Documentation**
   See the [IBM Cloud VPC Accelerated Profile documentation](https://cloud.ibm.com/docs/vpc?topic=vpc-accelerated-profile-family&interface=ui) for instance configuration details.

3. **Launch an Instance**
   - Sign in to the [IBM Cloud Console](https://cloud.ibm.com/)
   - Navigate to **VPC Infrastructure → Virtual server instances**
   - Select the AMD MI300X GPU accelerated profile
   - Configure networking, storage, and security groups
   - Launch and connect via SSH

4. **Install and Verify ROCm**
   Follow AMD's ROCm installation documentation for your chosen Linux distribution, or use an IBM Cloud image with ROCm pre-installed.

   ```bash
   rocm-smi
   ```

## AMD Instinct GPU Evaluation Program

IBM Cloud participates in the AMD Instinct GPU Evaluation Program. Visit the [AMD Evaluation Program](https://www.amd.com/en/products/accelerators/instinct/eval-request.html) to apply for access.

## Documentation and Resources

- [AMD Instinct MI300X on IBM Cloud](https://www.ibm.com/products/gpu-ai-accelerator/amd)
- [IBM Cloud VPC Accelerated Profile Documentation](https://cloud.ibm.com/docs/vpc?topic=vpc-accelerated-profile-family&interface=ui)
- [IBM watsonx Platform](https://www.ibm.com/products/watsonx)
- [Red Hat OpenShift AI on IBM Cloud](https://www.ibm.com/products/cloud/redhat)
- [AMD ROCm Documentation](https://rocm.docs.amd.com/)

## Support

- [IBM Cloud Support](https://www.ibm.com/cloud/support)
- [IBM Cloud Community](https://community.ibm.com/community/user/cloud/home)
- [AMD ROCm Community](https://www.amd.com/en/developer/resources/rocm-hub/forums.html)

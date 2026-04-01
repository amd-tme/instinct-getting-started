# Crusoe Cloud

## Overview

Crusoe is an AI-focused cloud provider offering high-performance GPU compute built for large-scale training and inference. Originally founded to address energy efficiency in AI compute, Crusoe operates AI-optimized data centers and offers a range of AMD and NVIDIA GPU instances — including the AMD Instinct MI355X and MI300X accelerators.

Crusoe participates in the AMD Instinct GPU Evaluation Program. Visit the [AMD Evaluation Program](https://www.amd.com/en/products/accelerators/instinct/eval-request.html) to apply for access.

## Available AMD Instinct GPU Instances

### AMD Instinct MI355X

Crusoe's latest AMD offering features the MI355X — AMD's CDNA 4-generation accelerator with 288GB of HBM3E memory.

**Key Specifications:**

- **GPU**: AMD Instinct MI355X
- **Memory**: 288 GB HBM3E per GPU
- **Architecture**: AMD CDNA 4
- **Pricing**: Contact Crusoe sales for availability and pricing

[Learn more about the MI355X on Crusoe →](https://www.crusoe.ai/cloud/gpus/amd-mi355x)

### AMD Instinct MI300X

Crusoe's MI300X instances offer on-demand access to 192GB HBM3 memory per GPU at competitive pricing.

**Key Specifications:**

- **GPU**: AMD Instinct MI300X
- **Memory**: 192 GB HBM3 per GPU
- **Architecture**: AMD CDNA 3
- **Pricing**: $3.45/GPU-hour (on-demand)

[Learn more about the MI300X on Crusoe →](https://www.crusoe.ai/cloud/gpus/amd-mi300x)

## Pricing

| GPU | On-Demand | Spot |
|---|---|---|
| AMD MI355X (288 GB) | Contact sales | Contact sales |
| AMD MI300X (192 GB) | $3.45/GPU-hr | Contact sales |

Reserved capacity pricing is available for longer commitments. [Contact Crusoe sales](https://www.crusoe.ai/contact-sales) for enterprise pricing.

## Getting Started with Crusoe

### Prerequisites

- A Crusoe Cloud account ([console.crusoecloud.com](https://console.crusoecloud.com/request))
- Familiarity with AMD ROCm platform

### Deployment Process

1. **Create an Account**
   Visit [crusoecloud.com](https://www.crusoe.ai/) and register for access. GPU instance availability may require approval.

2. **Provision a GPU Instance**
   - Log into the Crusoe Cloud console
   - Select AMD MI300X or MI355X from the GPU instance catalog
   - Choose on-demand, spot, or reserved pricing
   - Configure instance size, storage, and networking
   - Launch your instance

3. **Connect and Verify**
   SSH into your instance and verify GPU availability:

   ```bash
   rocm-smi
   ```

4. **Deploy Your Workload**
   Use ROCm-compatible frameworks (PyTorch, TensorFlow, JAX) to run your AI training or inference workloads.

## Documentation and Resources

- [Crusoe Cloud Platform](https://www.crusoe.ai/cloud/)
- [Crusoe GPU Pricing](https://www.crusoe.ai/cloud/pricing#gpu-instances)
- [AMD MI300X on Crusoe](https://www.crusoe.ai/cloud/gpus/amd-mi300x)
- [AMD MI355X on Crusoe](https://www.crusoe.ai/cloud/gpus/amd-mi355x)
- [AMD ROCm Documentation](https://rocm.docs.amd.com/)

## Support

- [Crusoe Support](https://www.crusoe.ai/contact-sales)
- [AMD ROCm Community](https://www.amd.com/en/developer/resources/rocm-hub/forums.html)

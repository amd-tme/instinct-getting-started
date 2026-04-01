# AMD Developer Cloud

## Overview

The AMD Developer Cloud (ADC) is AMD's own hosted GPU environment, purpose-built for developers, researchers, and open-source contributors building AI, machine learning, and HPC workloads on AMD hardware. It provides immediate access to AMD Instinct MI300X GPUs through a self-service portal powered by DigitalOcean — with no hardware investment, no procurement delays, and no long-term contracts.

**This is the fastest way to get started with AMD Instinct GPUs.**

[Sign up at amd.digitalocean.com →](https://amd.digitalocean.com/login)

## Access Options

### Free Credits — AMD AI Developer Program

Qualified developers can receive **$100 in complimentary AMD Developer Cloud credits** by joining the AMD AI Developer Program.

**Eligibility:**
- Independent developers and open-source project contributors
- Involvement with ML, low-level programming, or AI application development
- Intended use cases: inference, training, fine-tuning

Credit allocation is determined by AMD based on your intended use case and project description. Credits expire 30 days from deposit and apply only to AMD Instinct MI300X GPU usage.

[Join the AMD AI Developer Program →](https://www.amd.com/en/developer/ai-dev-program.html)

### Pay-As-You-Go

Immediately access AMD Instinct MI300X GPUs by linking a credit card to your AMD Developer Cloud account. No application required — ideal for developers ready to build now.

[Sign up for pay-as-you-go access →](https://amd.digitalocean.com/login)

## Available GPU Configurations

The AMD Developer Cloud offers two MI300X instance sizes:

| Configuration | GPUs | GPU Memory | vCPUs | System Memory | Boot Disk | Scratch Disk |
|---|---|---|---|---|---|---|
| Small | 1x MI300X | 192 GB | 20 | 240 GB | 720 GB NVMe | 5 TB NVMe |
| Large | 8x MI300X | 1,536 GB | 160 | 1,920 GB | 1,920 GB NVMe | 40 TB NVMe |

## Key Features

### Zero Setup — Instant Productivity

- Jupyter Notebook environment available immediately on VM launch
- Write and run Python code directly in the browser
- No local setup or software installation required

### Pre-Configured AI Environments

Docker containers come preloaded with popular AI frameworks including PyTorch and common ML libraries. You can run workloads out of the box or customize the environment for your specific needs.

### Full Access to ROCm

The AMD Developer Cloud provides access to the full ROCm software stack, including HIP, ROCm libraries, and AMD-optimized AI frameworks. Ideal for:

- Testing ROCm compatibility for existing CUDA workloads
- Developing and debugging ROCm-native applications
- Evaluating AMD Instinct GPU performance for your model architecture

## Getting Started

### 1. Create Your Account

Visit [amd.digitalocean.com](https://amd.digitalocean.com/login) and sign up. If you're applying for free credits, apply through the [AMD AI Developer Program](https://www.amd.com/en/developer/ai-dev-program.html) first.

### 2. Launch a GPU Instance

Select either the 1x or 8x MI300X configuration. The instance will be provisioned within minutes.

### 3. Verify GPU Access

Once your VM launches, open the Jupyter Notebook interface or SSH in and run:

```bash
rocm-smi
```

You should see your MI300X GPU(s) listed with memory and temperature information.

### 4. Run Your First Workload

Use the pre-installed PyTorch environment to verify GPU access:

```python
import torch
print(torch.cuda.is_available())   # Returns True on ROCm with HIP
print(torch.cuda.get_device_name(0))
```

## Important Notes

- **Billing for powered-off instances**: If you power off a GPU VM, you are still billed. Disk space, CPU, RAM, and IP address remain reserved. Destroy the instance when not in use.
- **Data loss on credit expiry**: If complimentary credits expire without a payment method on file, your GPU VM is destroyed and data is lost.
- **Terms of use**: The AMD Developer Cloud is intended for development and research. It may not be used to provide commercial GPU services to third parties.

## Documentation and Resources

- [AMD Developer Cloud Login](https://amd.digitalocean.com/login)
- [How to Get Started on the AMD Developer Cloud](https://www.amd.com/en/developer/resources/technical-articles/2025/how-to-get-started-on-the-amd-developer-cloud-.html)
- [ROCm AI Developer Hub](https://www.amd.com/en/developer/resources/rocm-hub/dev-ai.html)
- [Instinct GPU Documentation](https://instinct.docs.amd.com/latest/)
- [AMD Developer Cloud Terms of Use](https://www.amd.com/content/dam/amd/en/documents/developer/cloud/developer-cloud-terms-of-use.pdf)

## Support

- [DigitalOcean Cloud Support](https://cloudsupport.digitalocean.com/) (AMD Developer Cloud is hosted by DigitalOcean)
- [ROCm GitHub Discussions](https://github.com/ROCm/ROCm/discussions)

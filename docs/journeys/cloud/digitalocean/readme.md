# DigitalOcean

## Overview

DigitalOcean offers AMD Instinct GPU instances through its **Gradient AI GPU Droplets** product — a developer-friendly cloud platform designed for fast provisioning, simple billing, and broad GPU availability. DigitalOcean also powers the [AMD Developer Cloud](../amd-developer-cloud/readme), which provides free-tier and pay-as-you-go access to AMD Instinct MI300X GPUs for qualified developers.

DigitalOcean participates in the AMD Instinct GPU Evaluation Program. Visit the [AMD Evaluation Program](https://www.amd.com/en/products/accelerators/instinct/eval-request.html) to apply for access.

## Available AMD Instinct GPU Instances

DigitalOcean offers multiple generations of AMD Instinct accelerators through GPU Droplets, with both single-GPU and 8-GPU configurations:

### AMD Instinct MI350X (CDNA 4)

DigitalOcean's newest AMD offering, based on AMD's 4th-generation CDNA 4 architecture:

| Configuration | GPU Memory | System Memory | vCPUs | Boot Disk | Scratch Disk |
|---|---|---|---|---|---|
| 1x MI350X | 288 GB | 256 GiB | 24 | 720 GiB NVMe | 5 TiB NVMe |
| 8x MI350X | 2,304 GB | 2,048 GiB | 192 | 2,046 GiB NVMe | 40 TiB NVMe |

### AMD Instinct MI325X (CDNA 3)

| Configuration | GPU Memory | System Memory | vCPUs | Boot Disk | Scratch Disk |
|---|---|---|---|---|---|
| 1x MI325X | 256 GB | 164 GiB | 20 | 720 GiB NVMe | 5 TiB NVMe |
| 8x MI325X | 2,048 GB | 1,310 GiB | 160 | 2,046 GiB NVMe | 40 TiB NVMe |

### AMD Instinct MI300X (CDNA 3)

| Configuration | GPU Memory | System Memory | vCPUs | Boot Disk | Scratch Disk |
|---|---|---|---|---|---|
| 1x MI300X | 192 GB | 240 GiB | 20 | 720 GiB NVMe | 5 TiB NVMe |
| 8x MI300X | 1,536 GB | 1,920 GiB | 160 | 2,046 GiB NVMe | 40 TiB NVMe |

All GPU Droplet configurations provide **10 Gbps public** and **25 Gbps private** network bandwidth.

**Note**: MI325X and MI350X instances require [contacting DigitalOcean sales](https://www.digitalocean.com/company/contact/sales) to reserve capacity.

## Pricing

On-demand pricing for AMD GPU Droplets ranges from approximately $0.76 to $7.99 per GPU/hour depending on GPU model. Reserved pricing with longer-term contracts can be significantly lower. See [DigitalOcean GPU Droplet pricing](https://www.digitalocean.com/products/gradient/gpu-droplets) for current rates.

DigitalOcean bills per-second with a 5-minute minimum. Powered-off Droplets continue to accrue charges — destroy instances when not in use.

## Getting Started with DigitalOcean GPU Droplets

### Prerequisites

- A DigitalOcean account ([cloud.digitalocean.com](https://cloud.digitalocean.com/registrations/new))
- Basic familiarity with cloud VMs and SSH

### Deploying a GPU Droplet

1. **Sign In to DigitalOcean**
   Go to [cloud.digitalocean.com](https://cloud.digitalocean.com) and sign in.

2. **Create a GPU Droplet**
   - Navigate to **GPUs** in the left sidebar
   - Click **Create GPU Droplet**
   - Select your AMD GPU model (MI300X, MI325X, or MI350X)
   - Choose a data center region (NYC2, TOR1, ATL1, RIC1, or AMS3)
   - Select an OS or pre-built AI image
   - Configure SSH keys and optional settings
   - Click **Create Droplet**

3. **Connect and Verify**

   ```bash
   ssh root@<droplet-ip>
   rocm-smi
   ```

4. **Run Your Workload**

   GPU Droplets come with Python and deep learning tools pre-installed. For PyTorch:

   ```python
   import torch
   print(torch.cuda.is_available())   # Returns True via ROCm HIP
   print(torch.cuda.get_device_name(0))
   ```

### Kubernetes Integration

GPU Droplets integrate with DigitalOcean Managed Kubernetes (DOKS), Terraform, and the DigitalOcean CLI and API for automated deployments.

## AMD Developer Cloud Note

The AMD Developer Cloud — AMD's own hosted GPU program — is powered by DigitalOcean infrastructure. If you're a developer looking for free credits or low-cost pay-as-you-go access specifically for AMD MI300X, see the [AMD Developer Cloud](../amd-developer-cloud/readme) page.

## Documentation and Resources

- [DigitalOcean GPU Droplets](https://www.digitalocean.com/products/gradient/gpu-droplets)
- [GPU Droplet Documentation](https://docs.digitalocean.com/products/droplets/details/features/)
- [AMD MI350X on DigitalOcean](https://www.digitalocean.com/blog/now-available-amd-instinct-mi350x-gpus)
- [AMD MI325X on DigitalOcean](https://www.digitalocean.com/blog/now-available-amd-instinct-mi325x-gpus)
- [AMD MI300X on DigitalOcean](https://www.digitalocean.com/blog/now-available-amd-instinct-mi300x-gpus)
- [AMD ROCm Documentation](https://rocm.docs.amd.com/)

## Support

- [DigitalOcean Support](https://www.digitalocean.com/products/support)
- [DigitalOcean GPU SLA](https://docs.digitalocean.com/products/droplets/details/gpu-sla/)

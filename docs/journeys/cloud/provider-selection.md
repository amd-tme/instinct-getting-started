# Provider Selection

## Choosing the Right Cloud Provider

The cloud ecosystem for AMD Instinct accelerators is rapidly expanding, offering diverse options from AMD's own developer cloud and major hyperscalers to specialized GPU cloud providers. This guide helps you navigate the available choices and select the optimal provider for your specific workload requirements.

## Start Here: AMD Developer Cloud

Before evaluating third-party providers, consider the **AMD Developer Cloud** — AMD's own hosted GPU environment designed for developers, researchers, and open-source contributors.

**Why start with AMD Developer Cloud:**

- **Free credits**: AMD AI Developer Program members receive $100 in complimentary cloud credits
- **Zero setup**: Jupyter Notebook and Docker containers pre-configured on launch
- **No commitment**: Pay-as-you-go with no contracts
- **MI300X GPUs**: 1x (192 GB) or 8x (1,536 GB) configurations

The AMD Developer Cloud is powered by DigitalOcean infrastructure and is the fastest way to evaluate AMD Instinct GPUs before committing to a provider.

[Learn more →](amd-developer-cloud/readme)

---

## AMD Instinct Evaluation Program

Multiple cloud providers participate in AMD's formal evaluation program, which offers guided proof-of-concept access to AMD Instinct GPUs. Apply at [amd.com/en/products/accelerators/instinct/eval-request](https://www.amd.com/en/products/accelerators/instinct/eval-request.html).

**Current evaluation program partners:** Microsoft Azure, Oracle Cloud, Crusoe, TensorWave, Vultr, DigitalOcean, IBM Cloud, Cirrascale, Hot Aisle, and Evergrid AI.

---

## Major Cloud Providers

### Microsoft Azure

Azure offers AMD Instinct MI300X accelerators through the **ND MI300X v5 series** — enterprise-grade infrastructure with global reach and managed service integrations.

**Key Features:**

- **VM size**: `Standard_ND96isr_MI300X_v5` — 96 vCPUs, 1,850 GiB memory
- **GPUs per VM**: 8x AMD Instinct MI300X (192 GB each, 1.5 TB total)
- **Interconnect**: 4th-Gen AMD Infinity Fabric links, 128 GB/s per GPU (896 GB/s aggregate)
- **Networking**: 400 Gb/s NVIDIA Quantum-2 CX7 InfiniBand per GPU with GPUDirect RDMA
- **Scale-out**: Thousands of GPUs with 3.2 Tb/s interconnect bandwidth per VM
- **Managed services**: Azure Kubernetes Service (AKS), Azure HPC deployments

[Learn more about Azure deployment →](azure/readme)

---

### Oracle Cloud Infrastructure (OCI)

OCI offers AMD Instinct MI300X bare metal instances with one of the largest scale-out configurations available in the cloud.

**Key Features:**

- **Instance type**: `BM.GPU.MI300X.8` — 8x MI300X GPUs, bare metal
- **Pricing**: $6.00 per GPU/hour
- **Memory**: 1.5 TB HBM3 GPU memory (5.3 TB/s bandwidth)
- **CPU**: 2x Intel Sapphire Rapids (56c each), 2 TB DDR5 system memory
- **Networking**: 8x 400G cluster network ports for RDMA
- **Supercluster**: Up to 16,384 MI300X GPUs in a single OCI Supercluster fabric

[Learn more about OCI deployment →](oraclecloud/readme)

---

### IBM Cloud

IBM Cloud offers AMD Instinct MI300X accelerators as a service through IBM Cloud Virtual Servers for VPC. Currently under select availability.

**Key Features:**

- **Instance**: 8x AMD Instinct MI300X, 208 vCPUs, 1,792 GB RAM, 8x 3.2 TB NVMe storage
- **Platform integration**: Support for IBM watsonx AI, Red Hat OpenShift AI, and Red Hat Enterprise Linux AI
- **Kubernetes**: IBM Cloud Kubernetes Service and Red Hat OpenShift on IBM Cloud
- **Enterprise focus**: Hybrid cloud and multi-cloud capabilities

[Learn more about IBM Cloud →](ibmcloud/readme)

---

## Specialized GPU Cloud Providers

### TensorWave

TensorWave is an AMD-focused cloud and bare metal provider building large-scale AMD GPU clusters with competitive per-GPU pricing and support for AMD's latest accelerators.

**Key Features:**

- **GPUs**: MI300X, MI325X, MI355X bare metal
- **Pricing**: Starting at $1.71/GPU-hr (MI300X), $2.25/GPU-hr (MI325X), $2.95/GPU-hr (MI355X)
- **Scale**: Over 1 GW of capacity; among the first to deploy MI325X training clusters
- **Security**: SOC 2 Type II certified and HIPAA compliant
- **Storage**: Weka high-performance storage integration
- **Orchestration**: Bare metal, managed Kubernetes, and Slurm clusters

[Learn more about TensorWave deployment →](tensorwave/readme)

---

### Crusoe

Crusoe is an AI-focused cloud provider offering AMD Instinct MI300X and MI355X instances alongside NVIDIA GPUs. Known for energy-efficient, purpose-built AI infrastructure.

**Key Features:**

- **GPUs**: AMD MI355X (288 GB HBM3E, CDNA 4) and MI300X (192 GB HBM3)
- **Pricing**: MI300X from $3.45/GPU-hr on-demand; MI355X contact sales
- **Pricing models**: On-demand, spot, and reserved capacity
- **Managed inference**: Pay-as-you-go and provisioned throughput options
- **Platform**: Managed Kubernetes available

[Learn more about Crusoe deployment →](crusoe/readme)

---

### DigitalOcean

DigitalOcean's Gradient AI GPU Droplets provide AMD Instinct GPUs in a developer-friendly environment with fast provisioning and straightforward billing. DigitalOcean also powers the AMD Developer Cloud.

**Key Features:**

- **GPUs**: MI300X (192 GB), MI325X (256 GB), and MI350X (288 GB, CDNA 4)
- **Pricing**: On-demand from ~$0.76–$7.99/GPU-hr; reserved rates available
- **Availability**: NYC2, TOR1, ATL1, RIC1, AMS3 data centers
- **Developer experience**: Zero-to-GPU in under a minute; pre-installed AI frameworks
- **SLA**: 99.5% uptime SLA for GPU Droplets
- **Compliance**: HIPAA-eligible and SOC 2 compliant

[Learn more about DigitalOcean deployment →](digitalocean/readme)

---

### Cirrascale

Cirrascale's AI Innovation Cloud specializes in AMD Instinct accelerators with a transparent, flat-rate billing model and no data transfer fees.

**Key Features:**

- **GPUs**: AMD Instinct MI250, MI300X, and MI325X (now available)
- **Billing model**: Flat monthly rates — no hourly fluctuations, no ingress/egress fees
- **Volume discounts**: Up to 20% off with longer commitments (monthly, 3-month, 6-month, annual)
- **Pre-configured**: AMD drivers, ROCm stack, and Hugging Face transformers included
- **Heritage**: Trusted by early-stage AI companies including OpenAI

[Learn more about Cirrascale deployment →](cirrascale/readme)

---

### Hot Aisle

Hot Aisle is a specialized provider of high-performance bare metal compute focused exclusively on AMD Instinct accelerators, with deep expertise in ROCm and large-scale cluster architecture.

**Key Features:**

- **Deep AMD expertise**: Specialized knowledge of ROCm and AMD software stack
- **Custom architectures**: Tailored solutions from compact to multi-data-center scale
- **Flagship cluster**: 128-GPU MI300X bare metal configurations
- **Consulting services**: Architecture design, workload optimization, and ongoing support

[Learn more about Hot Aisle deployment →](hotaisle/readme)

---

### Evergrid AI

Evergrid AI is a managed AI infrastructure provider — the "inference neocloud" — focused on single-tenant, high-performance clusters for enterprise and research workloads.

**Key Features:**

- **Scale**: Over 1 GW of capacity under development
- **Single-tenant**: Dedicated clusters for isolation and predictable performance
- **24/7 support**: 12-minute response SLA with dedicated engineering contact
- **Services**: Managed AI (inference/training), compute platform (K8s/Slurm/VMs), fleet operations
- **Hardware**: Latest emerging hardware with manufacturer-level optimization

[Learn more about Evergrid deployment →](evergrid/readme)

---

### Vultr

Vultr offers AMD Instinct MI300X and MI325X GPUs through both virtual machine and bare metal deployments, with a global data center footprint.

**Key Features:**

- **GPUs**: AMD Instinct MI300X and MI325X
- **Deployment options**: Virtual machines or bare metal
- **GPU virtualization**: SR-IOV-based partitioning for cost-efficient resource allocation

[Learn more about Vultr deployment →](vultr/readme)

---

### Nscale

Nscale is a sustainable GPU cloud provider operating from Northern Norway with 100% renewable energy and natural cooling, offering AMD Instinct MI300X and MI250X GPUs.

**Key Features:**

- **Sustainability**: 100% renewable energy, Arctic natural cooling
- **GPUs**: AMD Instinct MI300X and MI250X
- **Deployment models**: On-demand, reserved clusters, API endpoints, bare metal

[Learn more about Nscale deployment →](nscale/readme)

## Next Steps

1. **Try the AMD Developer Cloud** — free credits available for qualified developers
2. **Apply for evaluation access** via the [AMD Instinct Evaluation Program](https://www.amd.com/en/products/accelerators/instinct/eval-request.html)
3. **Review provider-specific guides** for account setup, provisioning, and ROCm configuration
4. **Follow the [Environment Setup](environment-setup) guide** once you have GPU access

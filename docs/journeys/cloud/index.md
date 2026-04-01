---
MyST:
  HTML_meta:
    "description": "Cloud Journey for AMD Instinct GPUs - choose a provider and get started"
    "keywords": "Instinct, GPU, cloud, Azure, Oracle, DigitalOcean, IBM, TensorWave, Crusoe, getting started"
---

# Cloud Deployment

AMD Instinct GPUs are available across a growing ecosystem of cloud providers — from major hyperscalers to AMD's own developer cloud. Choose a path based on your goals:

::::{grid} 1 1 2 2
:gutter: 3

:::{grid-item-card} AMD Developer Cloud
:link: amd-developer-cloud/readme
:link-type: doc
:class-card: journey-card

**Start here for free access**

The fastest way to get hands-on with AMD Instinct MI300X GPUs. AMD's own developer-focused cloud offers instant access with no hardware investment required.

* $100 in free credits for AMD AI Developer Program members
* Pay-as-you-go with no long-term commitment
* Pre-configured Docker containers and Jupyter Notebooks
* 1x or 8x GPU configurations

[https://amd.digitalocean.com](https://amd.digitalocean.com/login)
:::

:::{grid-item-card} Evaluate Through a Partner
:link: provider-selection
:link-type: doc
:class-card: journey-card

**Try before you buy**

AMD's cloud service partners offer proof-of-concept access to AMD Instinct GPUs with support from both AMD and the provider. Ideal for evaluating AMD hardware before a production commitment.

* Microsoft Azure, Oracle Cloud, IBM Cloud
* TensorWave, Cirrascale, Hot Aisle, Crusoe, and more
* Apply via the [AMD Instinct Evaluation Program](https://www.amd.com/en/products/accelerators/instinct/eval-request.html)
:::

::::

## Choose a Cloud Provider

AMD Instinct GPUs are available from a range of providers — each with different strengths depending on your scale, budget, and deployment model:

::::{grid} 1 1 3 3
:gutter: 2

:::{grid-item-card} Hyperscalers
:class-card: journey-card

Large-scale, globally available infrastructure with managed services, enterprise SLAs, and broad geographic coverage.

* [Microsoft Azure](azure/readme)
* [Oracle Cloud (OCI)](oraclecloud/readme)
* [IBM Cloud](ibmcloud/readme)
:::

:::{grid-item-card} GPU-Focused Providers
:class-card: journey-card

Specialized cloud and bare metal providers with deep AMD expertise, competitive pricing, and direct hardware access.

* [TensorWave](tensorwave/readme)
* [Crusoe](crusoe/readme)
* [DigitalOcean](digitalocean/readme)
* [Cirrascale](cirrascale/readme)
* [Hot Aisle](hotaisle/readme)
* [Evergrid](evergrid/readme)
:::

:::{grid-item-card} Bare Metal Only
:class-card: journey-card

Dedicated hardware with no virtualization overhead — maximum performance for large training runs and latency-sensitive inference.

* [Hot Aisle](hotaisle/readme)
* [TensorWave](tensorwave/readme)
* [Evergrid](evergrid/readme)
:::

::::

## What to Do Next

1. **Try AMD Developer Cloud** — get immediate access to MI300X GPUs with no contracts or procurement delays.
2. **Review the provider comparison** — see [Provider Selection](provider-selection) for a side-by-side breakdown of available GPU types, pricing models, and specializations.
3. **Follow a provider guide** — each provider page walks through account setup, instance provisioning, and ROCm verification.
4. **Set up your environment** — once you have GPU access, see [Environment Setup](environment-setup) for ROCm and framework configuration.

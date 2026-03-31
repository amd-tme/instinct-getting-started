# Software Ecosystem Overview

*Last reviewed: 2026-03-31*

The AMD Instinct platform provides a full-stack, open software ecosystem for
building and deploying AI, ML, and HPC workloads. This section maps the key
software building blocks by source and shows how they compose into end-to-end
solutions.

## What software do I need?

The software you need depends on your workload, but the building blocks fall
into three categories:

::::{grid} 1 1 3 3
:gutter: 3

:::{grid-item-card} AMD Components
:link: amd-components
:link-type: doc

ROCm Core SDK, GPU drivers, infrastructure operators, and the Enterprise AI
Suite. These are developed, maintained, and supported by AMD.
:::

:::{grid-item-card} Open Source Ecosystem
:link: open-source-ecosystem
:link-type: doc

AI frameworks, LLM inference engines, and training tools. Community-developed
with AMD contributing optimizations and upstream support.
:::

:::{grid-item-card} Third-Party Infrastructure
:link: third-party-infrastructure
:link-type: doc

Container orchestration, monitoring, storage, and networking. Standard
infrastructure tools that integrate with the AMD stack.
:::

::::

## How the pieces fit together

Every deployment uses the same foundation: **AMD Instinct GPUs** +
**AMD GPU drivers** + **ROCm Core SDK**. On top of that foundation, you choose
frameworks, tools, and infrastructure based on your use case.

```text
  Applications & Workloads
         |
  AI Frameworks & Inference Engines        [Open Source]
         |
  ROCm Core SDK (HIP, libraries, tools)   [AMD]
         |
  GPU Drivers + Infrastructure             [AMD]
         |
  AMD Instinct GPUs                        [AMD Hardware]
         |
  Orchestration & Monitoring               [Third Party / Open Source]
```

See [Reference Architectures](reference-architectures/index.md) for worked
examples showing how these layers compose for specific use cases.

## Documentation resources

| Resource | Covers |
|----------|--------|
| [ROCm Documentation](https://rocm.docs.amd.com/en/latest/) | Core SDK, libraries, compilers, AI framework integration |
| [Instinct Documentation](https://instinct.docs.amd.com/latest/index.html) | GPU drivers, GPU Operator, K8s infrastructure, metrics |
| [Enterprise AI Suite](https://enterprise-ai.docs.amd.com/en/latest/platform-overview.html) | AI Workbench, Resource Manager, Inference Microservices |
| [Developer Hub](https://www.amd.com/en/developer/resources/rocm-hub/dev-ai.html) | Tutorials, ecosystem partners, getting started resources |
| [ROCm Compatibility Matrix](https://rocm.docs.amd.com/en/compatibility/compatibility-matrix.html) | Supported GPUs, OS versions, framework versions |

# Software Ecosystem Overview

Last reviewed: 2026-03-31

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

```{raw} html
<div class="id-stack-diagram" role="img" aria-label="AMD Instinct software stack diagram">

  <div class="id-stack-layer" style="--layer-color: #4A9EBF; --layer-color-rgb: 74,158,191;">
    <div class="id-stack-label">Applications &amp; Workloads</div>
    <div class="id-stack-pills">
      <span class="id-stack-pill">LLM Inference</span>
      <span class="id-stack-pill">Model Training</span>
      <span class="id-stack-pill">HPC Simulation</span>
      <span class="id-stack-pill">AI Pipelines</span>
    </div>
  </div>

  <div class="id-stack-connector"></div>

  <div class="id-stack-layer" style="--layer-color: #3A9E6E; --layer-color-rgb: 58,158,110;">
    <div class="id-stack-label">AI Frameworks &amp; Inference Engines</div>
    <div class="id-stack-pills">
      <span class="id-stack-pill">PyTorch</span>
      <span class="id-stack-pill">TensorFlow</span>
      <span class="id-stack-pill">JAX</span>
      <span class="id-stack-pill">vLLM</span>
      <span class="id-stack-pill">SGLang</span>
      <span class="id-stack-pill">Triton</span>
    </div>
  </div>

  <div class="id-stack-connector"></div>

  <div class="id-stack-layer" style="--layer-color: #7A5CB8; --layer-color-rgb: 122,92,184;">
    <div class="id-stack-label">ROCm Core SDK</div>
    <div class="id-stack-pills">
      <span class="id-stack-pill">HIP</span>
      <span class="id-stack-pill">rocBLAS</span>
      <span class="id-stack-pill">MIOpen</span>
      <span class="id-stack-pill">RCCL</span>
      <span class="id-stack-pill">rocProfiler</span>
      <span class="id-stack-pill">Composable Kernel</span>
    </div>
  </div>

  <div class="id-stack-connector"></div>

  <div class="id-stack-layer" style="--layer-color: #5A4A9E; --layer-color-rgb: 90,74,158;">
    <div class="id-stack-label">GPU Drivers &amp; Infrastructure</div>
    <div class="id-stack-pills">
      <span class="id-stack-pill">amdgpu driver</span>
      <span class="id-stack-pill">GPU Operator</span>
      <span class="id-stack-pill">AMD SMI</span>
      <span class="id-stack-pill">ROCm SMI</span>
    </div>
  </div>

  <div class="id-stack-connector"></div>

  <div class="id-stack-layer" style="--layer-color: #C47A3A; --layer-color-rgb: 196,122,58;">
    <div class="id-stack-label">AMD Instinct GPUs</div>
    <div class="id-stack-pills">
      <span class="id-stack-pill">MI300X</span>
      <span class="id-stack-pill">MI325X</span>
      <span class="id-stack-pill">MI350X</span>
      <span class="id-stack-pill">MI355X</span>
    </div>
  </div>

  <div class="id-stack-connector"></div>

  <div class="id-stack-layer" style="--layer-color: #3A9E6E; --layer-color-rgb: 58,158,110;">
    <div class="id-stack-label">Orchestration &amp; Monitoring</div>
    <div class="id-stack-pills">
      <span class="id-stack-pill">Kubernetes</span>
      <span class="id-stack-pill">Prometheus</span>
      <span class="id-stack-pill">Grafana</span>
      <span class="id-stack-pill">DCGM Exporter</span>
    </div>
  </div>

</div>

<style>
.id-stack-diagram {
  display: flex;
  flex-direction: column;
  align-items: stretch;
  gap: 0;
  margin: 2rem 0;
  max-width: 680px;
}

.id-stack-layer {
  display: flex;
  align-items: center;
  gap: 1.25rem;
  padding: 0.9rem 1.25rem;
  border-radius: 10px;
  border: 1px solid rgba(var(--layer-color-rgb), 0.35);
  background: rgba(var(--layer-color-rgb), 0.08);
  border-left: 4px solid rgb(var(--layer-color-rgb));
  transition: background 200ms ease, border-color 200ms ease, box-shadow 200ms ease;
  cursor: default;
}

.id-stack-layer:hover {
  background: rgba(var(--layer-color-rgb), 0.14);
  box-shadow: 0 4px 24px rgba(var(--layer-color-rgb), 0.18);
}

html[data-theme="light"] .id-stack-layer {
  background: rgba(var(--layer-color-rgb), 0.06);
  border-color: rgba(var(--layer-color-rgb), 0.25);
}

html[data-theme="light"] .id-stack-layer:hover {
  background: rgba(var(--layer-color-rgb), 0.1);
}

.id-stack-label {
  font-family: Klavika, 'Inter', system-ui, sans-serif;
  font-weight: 500;
  font-size: 0.95rem;
  white-space: nowrap;
  min-width: 220px;
  color: rgb(var(--layer-color-rgb));
}

html[data-theme="light"] .id-stack-label {
  color: color-mix(in srgb, rgb(var(--layer-color-rgb)) 85%, #000 15%);
}

.id-stack-pills {
  display: flex;
  flex-wrap: wrap;
  gap: 0.35rem;
}

.id-stack-pill {
  font-size: 0.65rem;
  font-weight: 500;
  padding: 0.15rem 0.5rem;
  border-radius: 999px;
  background: rgba(var(--layer-color-rgb), 0.12);
  color: rgb(var(--layer-color-rgb));
  border: 1px solid rgba(var(--layer-color-rgb), 0.25);
  white-space: nowrap;
  letter-spacing: 0.02em;
}

html[data-theme="light"] .id-stack-pill {
  background: rgba(var(--layer-color-rgb), 0.08);
  color: color-mix(in srgb, rgb(var(--layer-color-rgb)) 80%, #000 20%);
}

.id-stack-connector {
  width: 2px;
  height: 16px;
  background: linear-gradient(to bottom, rgba(101,107,114,0.4), rgba(101,107,114,0.4));
  margin-left: calc(1.25rem + 2px); /* align with left border */
  flex-shrink: 0;
}
</style>
```

See [Example Architectures](reference-architectures/index.md) for worked
examples showing how these layers compose for specific use cases.

## Documentation resources

| Resource | Covers |
|----------|--------|
| [ROCm Documentation](https://rocm.docs.amd.com/en/latest/) | Core SDK, libraries, compilers, AI framework integration |
| [Instinct Documentation](https://instinct.docs.amd.com/latest/index.html) | GPU drivers, GPU Operator, K8s infrastructure, metrics |
| [Enterprise AI Suite](https://enterprise-ai.docs.amd.com/en/latest/platform-overview.html) | AI Workbench, Resource Manager, Inference Microservices |
| [Developer Hub](https://www.amd.com/en/developer/resources/rocm-hub/dev-ai.html) | Tutorials, ecosystem partners, getting started resources |
| [ROCm Compatibility Matrix](https://rocm.docs.amd.com/en/latest/compatibility/compatibility-matrix.html) | Supported GPUs, OS versions, framework versions |

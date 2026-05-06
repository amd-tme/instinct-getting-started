# Inference as a Service

Last reviewed: 2026-03-31

This example architecture shows how the ecosystem building blocks compose for
a customer building an inference-as-a-service business — for example, LLM API
endpoints powered by AMD Instinct GPUs.

## Architecture overview

```{raw} html
<div class="id-arch-diagram" role="img" aria-label="Inference as a Service architecture diagram">

  <!-- Entry point -->
  <div class="id-arch-entry">
    <div class="id-arch-entry-pill" style="--entry-color: #9D9FA2; --entry-color-rgb: 157,159,162;">
      Customer Traffic
    </div>
    <div class="id-arch-entry-arrow">↓</div>
    <div class="id-arch-entry-pill" style="--entry-color: #4A9EBF; --entry-color-rgb: 74,158,191;">
      Load Balancer &amp; API Gateway
    </div>
    <div class="id-arch-entry-arrow">↓</div>
  </div>

  <!-- Two deployment paths -->
  <div class="id-arch-paths-group">
    <div class="id-arch-paths-label">DEPLOYMENT PATH — CHOOSE ONE</div>
    <div class="id-arch-paths">

      <div class="id-arch-path" style="--path-color: #3A9E6E; --path-color-rgb: 58,158,110;">
        <div class="id-arch-path-title">Self-Managed Open Source</div>
        <div class="id-arch-path-components">
          <div class="id-arch-component">K8s &amp; Prometheus / Grafana</div>
          <div class="id-arch-component-arrow">↓</div>
          <div class="id-arch-component">vLLM or SGLang</div>
          <div class="id-arch-component-arrow">↓</div>
          <div class="id-arch-component">PyTorch + Hugging Face</div>
        </div>
      </div>

      <div class="id-arch-or">or</div>

      <div class="id-arch-path" style="--path-color: #7A5CB8; --path-color-rgb: 122,92,184;">
        <div class="id-arch-path-title">AMD Enterprise AI Suite</div>
        <div class="id-arch-path-components">
          <div class="id-arch-component">AI Workbench &amp; Resource Manager</div>
          <div class="id-arch-component-arrow">↓</div>
          <div class="id-arch-component">AMD Inference Microservices (AIM)</div>
          <div class="id-arch-component-arrow">↓</div>
          <div class="id-arch-component">PyTorch + Hugging Face</div>
        </div>
      </div>

    </div>
  </div>

  <!-- Shared foundation -->
  <div class="id-arch-foundation-label">
    <span>SHARED AMD FOUNDATION</span>
  </div>

  <div class="id-arch-foundation">
    <div class="id-arch-found-layer" style="--fc: #7A5CB8; --fc-rgb: 122,92,184; border-radius: 10px 10px 0 0;">
      <div class="id-arch-found-label">ROCm Core SDK</div>
      <div class="id-arch-found-pills">
        <span class="id-arch-found-pill">HIP</span>
        <span class="id-arch-found-pill">MIOpen</span>
        <span class="id-arch-found-pill">hipBLAS</span>
        <span class="id-arch-found-pill">RCCL</span>
      </div>
    </div>
    <div class="id-arch-found-connector"></div>
    <div class="id-arch-found-layer" style="--fc: #5A4A9E; --fc-rgb: 90,74,158; border-radius: 0;">
      <div class="id-arch-found-label">GPU Driver &amp; GPU Operator</div>
      <div class="id-arch-found-pills">
        <span class="id-arch-found-pill">amdgpu driver</span>
        <span class="id-arch-found-pill">GPU Operator</span>
        <span class="id-arch-found-pill">AMD SMI</span>
      </div>
    </div>
    <div class="id-arch-found-connector"></div>
    <div class="id-arch-found-layer" style="--fc: #C47A3A; --fc-rgb: 196,122,58; border-radius: 0 0 10px 10px;">
      <div class="id-arch-found-label">AMD Instinct GPUs</div>
      <div class="id-arch-found-pills">
        <span class="id-arch-found-pill">MI300X</span>
        <span class="id-arch-found-pill">MI325X</span>
        <span class="id-arch-found-pill">MI350X</span>
        <span class="id-arch-found-pill">MI355X</span>
      </div>
    </div>
  </div>

</div>

<style>
.id-arch-diagram {
  display: flex;
  flex-direction: column;
  align-items: stretch;
  gap: 0;
  margin: 2rem 0;
  max-width: 680px;
  font-family: Klavika, 'Inter', system-ui, sans-serif;
}

/* Entry point */
.id-arch-entry {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0;
  margin-bottom: 0.5rem;
}

.id-arch-entry-pill {
  padding: 0.6rem 1.5rem;
  border-radius: 999px;
  border: 1px solid rgba(var(--entry-color-rgb), 0.4);
  background: rgba(var(--entry-color-rgb), 0.08);
  color: rgb(var(--entry-color-rgb));
  font-size: 0.85rem;
  font-weight: 500;
  text-align: center;
}

html[data-theme="light"] .id-arch-entry-pill {
  background: rgba(var(--entry-color-rgb), 0.06);
  color: color-mix(in srgb, rgb(var(--entry-color-rgb)) 80%, #000 20%);
}

.id-arch-entry-arrow {
  font-size: 1rem;
  color: var(--id-border, #656b72);
  line-height: 1.4;
  text-align: center;
}

/* Two-path group */
.id-arch-paths-group {
  border: 1px dashed rgba(101, 107, 114, 0.4);
  border-radius: 10px;
  padding: 1rem;
  margin-bottom: 0.5rem;
}

.id-arch-paths-label {
  font-size: 0.6rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.15em;
  color: var(--id-muted-text, #b4b9bc);
  margin-bottom: 0.75rem;
}

html[data-theme="light"] .id-arch-paths-label {
  color: var(--id-muted-text-light, #5E5E5E);
}

.id-arch-paths {
  display: grid;
  grid-template-columns: 1fr auto 1fr;
  gap: 0.75rem;
  align-items: start;
}

.id-arch-or {
  font-size: 0.75rem;
  font-weight: 500;
  color: var(--id-muted-text, #b4b9bc);
  padding-top: 2.5rem;
  text-align: center;
  font-style: italic;
}

html[data-theme="light"] .id-arch-or {
  color: var(--id-muted-text-light, #5E5E5E);
}

/* Individual path card */
.id-arch-path {
  border: 1px solid rgba(var(--path-color-rgb), 0.3);
  border-top: 3px solid rgb(var(--path-color-rgb));
  border-radius: 8px;
  padding: 0.75rem;
  background: rgba(var(--path-color-rgb), 0.05);
}

html[data-theme="light"] .id-arch-path {
  background: rgba(var(--path-color-rgb), 0.04);
}

.id-arch-path-title {
  font-size: 0.78rem;
  font-weight: 600;
  color: rgb(var(--path-color-rgb));
  margin-bottom: 0.6rem;
  line-height: 1.3;
}

html[data-theme="light"] .id-arch-path-title {
  color: color-mix(in srgb, rgb(var(--path-color-rgb)) 80%, #000 20%);
}

.id-arch-path-components {
  display: flex;
  flex-direction: column;
  gap: 0;
}

.id-arch-component {
  font-size: 0.75rem;
  padding: 0.4rem 0.6rem;
  border-radius: 6px;
  background: rgba(var(--path-color-rgb), 0.08);
  border: 1px solid rgba(var(--path-color-rgb), 0.2);
  color: inherit;
  text-align: center;
  line-height: 1.3;
}

html[data-theme="light"] .id-arch-component {
  background: rgba(var(--path-color-rgb), 0.06);
}

.id-arch-component-arrow {
  font-size: 0.75rem;
  color: rgba(var(--path-color-rgb), 0.5);
  text-align: center;
  line-height: 1.6;
}

/* Foundation connector */
.id-arch-foundation-label {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  margin: 0.75rem 0 0.5rem;
  font-size: 0.6rem;
  font-weight: 600;
  letter-spacing: 0.15em;
  text-transform: uppercase;
  color: var(--id-muted-text, #b4b9bc);
}

html[data-theme="light"] .id-arch-foundation-label {
  color: var(--id-muted-text-light, #5E5E5E);
}

.id-arch-foundation-label::before,
.id-arch-foundation-label::after {
  content: "";
  flex: 1;
  height: 1px;
  background: rgba(101, 107, 114, 0.3);
}

/* Foundation layers — self-contained, no external class dependency */
.id-arch-foundation {
  display: flex;
  flex-direction: column;
  gap: 0;
}

.id-arch-found-layer {
  display: flex;
  align-items: center;
  gap: 1.25rem;
  padding: 0.9rem 1.25rem;
  border: 1px solid rgba(var(--fc-rgb), 0.35);
  border-left: 4px solid var(--fc);
  background: rgba(var(--fc-rgb), 0.08);
  transition: background 200ms ease, box-shadow 200ms ease;
}

.id-arch-found-layer:hover {
  background: rgba(var(--fc-rgb), 0.14);
  box-shadow: 0 4px 24px rgba(var(--fc-rgb), 0.18);
}

html[data-theme="light"] .id-arch-found-layer {
  background: rgba(var(--fc-rgb), 0.06);
}

html[data-theme="light"] .id-arch-found-layer:hover {
  background: rgba(var(--fc-rgb), 0.1);
}

.id-arch-found-label {
  font-family: Klavika, 'Inter', system-ui, sans-serif;
  font-weight: 500;
  font-size: 0.95rem;
  min-width: 200px;
  color: var(--fc);
}

html[data-theme="light"] .id-arch-found-label {
  filter: brightness(0.8);
}

.id-arch-found-pills {
  display: flex;
  flex-wrap: wrap;
  gap: 0.35rem;
}

.id-arch-found-pill {
  font-size: 0.65rem;
  font-weight: 500;
  padding: 0.15rem 0.5rem;
  border-radius: 999px;
  background: rgba(var(--fc-rgb), 0.12);
  color: var(--fc);
  border: 1px solid rgba(var(--fc-rgb), 0.25);
  white-space: nowrap;
}

.id-arch-found-connector {
  width: 2px;
  height: 14px;
  background: rgba(101, 107, 114, 0.4);
  margin-left: calc(1.25rem + 2px);
}

@media (max-width: 560px) {
  .id-arch-paths {
    grid-template-columns: 1fr;
  }
  .id-arch-or {
    padding-top: 0;
    padding-bottom: 0;
  }
}
</style>
```

## Two deployment paths

Both paths use the same **ROCm Core SDK** and **AMD GPU drivers** as their
foundation. The choice depends on your operational requirements.

### Self-managed open source path

Full control over component selection; assemble your own stack from open source building blocks.

| Layer | Components |
|-------|------------|
| **Inference engine** | [vLLM](https://docs.vllm.ai/) or [SGLang](https://docs.sglang.io/) |
| **Framework** | [PyTorch](https://pytorch.org/) + [Hugging Face](https://huggingface.co/docs/transformers/) |
| **GPU software** | [ROCm Core SDK](../amd-components.md#rocm-core-sdk) |
| **Infrastructure** | [AMD GPU Operator](https://instinct.docs.amd.com/projects/gpu-operator/en/latest/) on Kubernetes |
| **Monitoring** | [Prometheus](https://prometheus.io/) + [Grafana](https://grafana.com/) via [Device Metrics Exporter](https://instinct.docs.amd.com/projects/device-metrics-exporter/en/latest/) |

### AMD Enterprise AI Suite path

Also open source with no licensing requirements, the Enterprise AI Suite adds
a well-designed web UI, enterprise authentication integration (SSO/IAM/RBAC),
and pre-validated AI components — all built on the same Kubernetes foundation.

| Layer | Components |
|-------|------------|
| **Inference engine** | [AMD Inference Microservices (AIM)](https://enterprise-ai.docs.amd.com/en/latest/aims/overview.html) |
| **Development** | [AMD AI Workbench](https://enterprise-ai.docs.amd.com/en/latest/workbench/overview.html) |
| **Resource management** | [AMD Resource Manager](https://enterprise-ai.docs.amd.com/en/latest/resource-manager/overview.html) |
| **GPU software** | [ROCm Core SDK](../amd-components.md#rocm-core-sdk) |
| **Infrastructure** | [AMD GPU Operator](https://instinct.docs.amd.com/projects/gpu-operator/en/latest/) on Kubernetes |

## Key decision points

- **Control vs. convenience:** The self-managed path gives full control over
  every component. The Enterprise AI Suite reduces operational burden with a
  web UI, pre-validated containers, and built-in resource management.
- **Licensing:** Both paths are fully open source with no AMD licensing
  requirements.
- **Enterprise integration:** The Enterprise AI Suite includes built-in RBAC
  and federation with existing SSO and IAM solutions, which teams assembling
  their own stack must configure separately.

# Inference as a Service

Last reviewed: 2026-03-31

This example architecture shows how the ecosystem building blocks compose for
a customer building an inference-as-a-service business — for example, LLM API
endpoints powered by AMD Instinct GPUs.

## Architecture overview

![Inference as a Service architecture diagram](../../_static/images/amd_token-aas.png)

## Two deployment paths

Both paths use the same **ROCm Core SDK** and **AMD GPU drivers** as their
foundation. The choice depends on your operational requirements.

### Self-managed open source path

Full control, no AMD enterprise licensing.

| Layer | Components |
|-------|------------|
| **Inference engine** | [vLLM](https://docs.vllm.ai/) or [SGLang](https://sgl-project.github.io/) |
| **Framework** | [PyTorch](https://pytorch.org/) + [Hugging Face](https://huggingface.co/docs/transformers/) |
| **GPU software** | [ROCm Core SDK](../amd-components.md#rocm-core-sdk) |
| **Infrastructure** | [AMD GPU Operator](https://instinct.docs.amd.com/projects/gpu-operator/en/latest/) on Kubernetes |
| **Monitoring** | [Prometheus](https://prometheus.io/) + [Grafana](https://grafana.com/) via [Device Metrics Exporter](https://instinct.docs.amd.com/projects/device-metrics-exporter/en/latest/) |

### Enterprise-managed path

Adds resource management, workbench, pre-optimized AIM containers, and
AI-native orchestration on top of the same ROCm + open source foundation.

| Layer | Components |
|-------|------------|
| **Inference engine** | [AMD Inference Microservices (AIM)](https://enterprise-ai.docs.amd.com/en/workbench/inference/overview.html) |
| **Development** | [AMD AI Workbench](https://enterprise-ai.docs.amd.com/en/workbench/overview.html) |
| **Resource management** | [AMD AI Resource Manager](https://enterprise-ai.docs.amd.com/en/resource-manager/overview.html) |
| **GPU software** | [ROCm Core SDK](../amd-components.md#rocm-core-sdk) |
| **Infrastructure** | [AMD GPU Operator](https://instinct.docs.amd.com/projects/gpu-operator/en/latest/) on Kubernetes |

## Key decision points

- **Control vs. convenience:** The open source path gives full control over
  every component; the enterprise path reduces operational burden with
  pre-validated, optimized containers and built-in resource management.
- **Licensing:** The open source path has no AMD enterprise licensing
  requirements. The enterprise path requires an AMD Enterprise AI Suite license.
- **Support:** Both paths benefit from AMD's ROCm support. The enterprise path
  adds dedicated support for the Enterprise AI Suite components.

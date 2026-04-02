## Current State Summary

The site has two journeys today, both **infrastructure/deployment-oriented**:

- **Bare Metal**: Hardware selection → ROCm install → Environment setup → Validation → Optimization
- **Cloud**: Provider selection → Per-provider provisioning → Environment setup

There's also an **Ecosystem** section (software stack reference) and **Reference Architectures** (one so far: Inference as a Service).

The journeys are solid for "how do I get GPU access" but stop short of "now what do I do with it?" — there's nothing persona-specific and nothing that takes a developer from GPU access to actually building something.

---

## Existing Journeys — Mermaid Diagrams

Here's what the documented journeys look like, for reference when we add these to the site:

**Bare Metal Journey**
```mermaid
flowchart LR
    A([Start]) --> B[Hardware Selection\nMI300X–MI355X]
    B --> C[ROCm Installation\namdgpu-install]
    C --> D[Environment Setup\nkernel params, monitoring,\ncontainer access]
    D --> E[Validation\nAGFHC + CVS]
    E --> F[Optimization\nBIOS, profiling, tuning]
    F --> G([GPU Ready])
```

**Cloud Journey**
```mermaid
flowchart LR
    A([Start]) --> B{Goal}
    B -- Free/fast access --> C[AMD Developer Cloud\namd.digitalocean.com]
    B -- Evaluate w/ support --> D[Partner Cloud\nEval Program]
    B -- Production scale --> E[Choose Provider\nAzure / OCI / IBM\nTensorWave / Crusoe / etc.]
    C --> F[Environment Setup]
    D --> F
    E --> F
    F --> G([GPU Ready])
```

---

## Proposed Persona Journeys

### Persona 1: C++/Kernel Developer

**Who**: Low-level GPU programmers, CUDA developers evaluating AMD, folks writing or optimizing custom kernels.

**Their question**: "How do I write GPU code for AMD hardware, and how do I port my existing CUDA work?"

**Proposed journey flow:**
```mermaid
flowchart TD
    A([C++ / Kernel Dev]) --> B{Starting point?}
    B -- New to AMD GPU --> C[Get GPU Access\nbare-metal or cloud]
    B -- Have GPU already --> D[ROCm Dev Environment\nHIP + compilers + libs]
    C --> D
    D --> E{Starting from?}
    E -- CUDA code --> F[HIPIFY\nautomated translation]
    E -- Greenfield --> G[HIP Hello World\nkernel basics]
    F --> H[Build & Test\nhipcc, cmake]
    G --> H
    H --> I[ROCm Math Libraries\nrocBLAS, rocFFT, etc.]
    I --> J[Profile & Debug\nrocprofv3, ROCm Compute Profiler,\nROCgdb]
    J --> K[Advanced Optimization\nComposable Kernel, Tensile,\nwave-level programming]
    K --> L([Ship it])
```

**Key content gaps to fill**: HIP programming primer, HIPIFY walkthrough, rocBLAS/rocFFT usage, kernel profiling with rocprofv3, ROCgdb debugging guide.

---

### Persona 2: AI/Data Science Developer (PyTorch / Framework Level)

**Who**: ML researchers, model developers, fine-tuning engineers, people who work above the framework API and don't write kernels.

**Their question**: "How do I run my PyTorch workloads on AMD, fine-tune models, and serve them?"

**Proposed journey flow:**
```mermaid
flowchart TD
    A([AI / ML Developer]) --> B[Get GPU Access\ncloud or bare metal]
    B --> C[PyTorch on ROCm\ninstall + verify]
    C --> D{What are you building?}
    D -- Inference / evaluation --> E[Run a Model\nHugging Face + ROCm]
    D -- Training --> F[Training Workflow\nPyTorch + DeepSpeed\nor Megatron-LM]
    D -- Fine-tuning --> G[Fine-Tuning\nLoRA / QLoRA via PEFT]
    E --> H[Optimize Inference\nvLLM or SGLang serving\nquantization FP8/BF16]
    F --> I[Multi-GPU Training\nRCCL, tensor/pipeline\nparallelism]
    G --> H
    I --> J[Profile & Debug\nROCm Systems Profiler\nPyTorch Profiler]
    H --> K([Model in production])
    J --> K
```

**Key content gaps to fill**: PyTorch on ROCm setup guide, HF models on ROCm, fine-tuning walkthrough (LoRA), vLLM/SGLang getting started, quantization guide.

---

### Persona 3: IT Infrastructure / DevOps / MLOps

**Who**: Platform engineers, cluster admins, MLOps practitioners who provision and manage GPU infrastructure for teams.

**Their question**: "How do I stand up AMD GPU infrastructure that my data science team can actually use?"

**Proposed journey flow:**
```mermaid
flowchart TD
    A([IT / DevOps / MLOps]) --> B{Deployment model?}
    B -- Single node / small cluster --> C[Bare Metal Setup\nhardware + ROCm]
    B -- Kubernetes cluster --> D[GPU Operator\nautomated driver, device plugin,\nmetrics, node labeling]
    C --> E[Container Runtime\nAMD Container Toolkit\nDocker / Podman]
    D --> E
    E --> F[Monitoring Stack\nDevice Metrics Exporter\nPrometheus + Grafana]
    F --> G{Multi-tenant?}
    G -- No --> H[Single-user\nor namespace isolation]
    G -- Yes --> I[GPU Partitioning\ncompute + memory partitioning]
    I --> J[Enterprise AI Suite\nResource Manager + Workbench\nRBAC / SSO / quotas]
    H --> K[CI/CD Integration\ncontainer builds, GPU tests]
    J --> K
    K --> L([Platform ready for teams])
```

**Key content gaps to fill**: GPU Operator deployment guide, Prometheus/Grafana stack setup, multi-tenant GPU partitioning, Enterprise AI Suite deployment, CI/CD patterns for GPU workloads.

---

## Additional Journeys Worth Adding

Beyond the three personas, a few more gap areas stand out:

| Journey | Who it's for | Key gap |
|---|---|---|
| **HPC / Scientific Computing** | HPC researchers, MPI users | GPU-aware MPI, OpenMP offloading, rocBLAS for HPC, multi-node scaling |
| **LLM Inference as a Service** | Teams building LLM APIs | Expands the existing reference arch into a full walkthrough (vLLM/SGLang + monitoring + scaling) |
| **CUDA → ROCm Migration** | Developers porting existing NVIDIA workloads | HIPIFY, compatibility testing, common gotchas, CI validation strategy |
| **Model Fine-Tuning End-to-End** | Applied AI teams | From dataset → fine-tuned model → serving, as a self-contained story |
| **AI Workbench / Developer Platform** | Teams using Enterprise AI Suite | Getting developers productive on a managed platform |

---

## Structural Proposal

Right now the site top-level is: `Bare Metal | Cloud | Ecosystem`. I'd suggest evolving toward something like:

```
Start Here (where/how do I access a GPU?)
  ├── Bare Metal
  └── Cloud

What do you want to build?  ← NEW
  ├── C++ / Kernel Development
  ├── AI / ML Development (PyTorch)
  ├── Platform / Infrastructure (DevOps/MLOps)
  ├── LLM Inference Service
  └── [others]

Reference
  ├── Software Ecosystem
  └── Example Architectures
```

The "Start Here" journeys become prerequisites that the persona journeys reference, rather than standalone end-to-end paths. This keeps them DRY while making it easy for each persona to find their entry point.

---

Pausing here for your review. A few questions to help sharpen the direction:

1. **Depth vs. breadth**: Should persona journeys be self-contained how-tos (with actual commands and configs), or navigation guides that link out to existing docs (ROCm, Instinct docs, etc.) like the current journeys tend to be?
2. **Overlap with existing AMD docs**: The ROCm docs already cover some of this well (e.g., PyTorch install, fine-tuning guides). Do you want this site to duplicate/consolidate that, or curate and link?
3. **Contributor model**: Since the team is new, are any of these personas closer to home (i.e., you have SMEs internally who could draft the C++ or MLOps sections more readily than others)?
4. **Priority**: If you had to pick one persona journey to build first, which would it be?
# Third-Party Infrastructure

*Last reviewed: 2026-03-31*

Standard infrastructure tools that integrate with the AMD stack but are not
AMD-specific. Customers typically select these based on their existing
environment.

## Container and orchestration

| Component | Role |
|-----------|------|
| [Kubernetes](https://kubernetes.io/) | Container orchestration platform |
| [OpenShift](https://www.redhat.com/en/technologies/cloud-computing/openshift) | Enterprise Kubernetes (validated with GPU Operator) |
| [Docker](https://www.docker.com/) / [Podman](https://podman.io/) | Container runtimes |
| [Helm](https://helm.sh/) | Kubernetes package management |

## Cluster operations and MLOps

| Component | Role |
|-----------|------|
| [Prometheus](https://prometheus.io/) + [Grafana](https://grafana.com/) | GPU and cluster monitoring (via [Device Metrics Exporter](https://instinct.docs.amd.com/projects/device-metrics-exporter/en/latest/)) |
| [Slurm](https://slurm.schedmd.com/) | HPC workload scheduling |
| [Kubeflow](https://www.kubeflow.org/) | ML pipelines on Kubernetes |
| [MLflow](https://mlflow.org/) | Experiment tracking and model registry |
| [Ray](https://www.ray.io/) | Distributed computing framework |

## Networking and storage

| Component | Role |
|-----------|------|
| **InfiniBand / RoCE** | High-bandwidth GPU-to-GPU interconnect |
| **Longhorn / Ceph / NFS** | Persistent storage for model weights, datasets, checkpoints |
| [RCCL](https://rocm.docs.amd.com/projects/rccl/en/latest/) | AMD's collective communication library (NCCL-compatible API) |

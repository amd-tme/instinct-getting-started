# Validation

This page provides a high-level overview of validation procedures for AMD Instinct accelerators on bare metal. The goal is to confirm that ROCm is installed and your GPUs are operating correctly before running production workloads or formal acceptance testing.

For comprehensive, production-grade validation — including BIOS prerequisites, health checks, benchmark baselines, and explicit pass/fail acceptance criteria — refer to the **[AMD Instinct Customer Acceptance Guide](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/)**.

## Quick Sanity Check

After completing [Installation](installation.md), run these commands to confirm ROCm can see your GPUs:

```bash
# Confirm ROCm installation and GPU detection
rocminfo

# Monitor GPU status, power, and temperature
amd-smi monitor
```

If `rocminfo` lists your GPUs and `amd-smi monitor` shows them in a healthy state, ROCm is installed correctly and you can proceed to deeper validation.

If GPUs are not detected, check:

1. User group membership — your user must be in the `render` and `video` groups:

   ```bash
   groups | grep -E 'render|video'
   sudo usermod -a -G render,video $USER
   # Log out and back in for group changes to take effect
   ```

2. Kernel messages for driver errors:

   ```bash
   dmesg | grep -i amdgpu
   ```

3. ROCm environment paths:

   ```bash
   echo $PATH | grep rocm
   ```

## System Smoke Tests and Burn-in

Once basic GPU visibility is confirmed, use the [ROCm Validation Suite (RVS)](https://rocm.docs.amd.com/projects/ROCmValidationSuite/en/latest/) to run more thorough system validation. RVS is a collection of tests and benchmarks targeting specific subsystems of the ROCm platform — GPU compute, memory, PCIe interconnects, and more.

Common RVS use cases include:

- **Smoke tests**: Quickly verify that GPU hardware and the ROCm stack are functioning correctly after installation or system changes.
- **Burn-in testing**: Stress-test GPUs under sustained load to surface hardware issues before putting a system into production.
- **Diagnostics**: Identify and isolate issues affecting GPU functionality or performance.

See the [RVS documentation](https://rocm.docs.amd.com/projects/ROCmValidationSuite/en/latest/) and [GitHub repository](https://github.com/ROCm/ROCmValidationSuite) for installation instructions and available test modules.

## Formal Acceptance Testing

For production deployments, passing the quick sanity check is only the beginning. The [Customer Acceptance Guide](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/) provides a structured, two-phase validation methodology.

### Phase 1: Node (Single-System) Validation

Start with the page for your specific GPU model. Each GPU page walks you through the complete per-node acceptance sequence:

- **[MI355X](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/gpus/mi355x.html)**
- **[MI350X](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/gpus/mi350x.html)**
- **[MI325X](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/gpus/mi325x.html)**
- **[MI300X](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/gpus/mi300x.html)**

The GPU pages direct you through:

1. **[System Prerequisites](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/common/prerequisites.html)** — Firmware/BIOS alignment and OS tuning required before any testing
2. **[Health Checks](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/common/health-checks.html)** — Rapid validation of OS state, GPU visibility, PCIe links, and interconnect health
3. **[System Validation and Benchmarks](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/common/system-validation.html)** — Comprehensive validation using AMD GPU Field Health Check (AGFHC) and microbenchmarks (TransferBench, RCCL, rocBLAS, BabelStream)

### Phase 2: Cluster and Network Validation

After validating individual nodes, proceed with multi-node testing:

- NIC driver installation and network configuration
- RDMA benchmarking
- Multi-node RCCL and LLM workload validation

Full details are in the [Cluster & Network Validation](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/#cluster-network-validation) section of the acceptance guide.

## Framework Smoke Tests

Once the system is validated, a quick check that your target framework can see the GPUs is useful before moving on to workloads:

```bash
# PyTorch
python3 -c "import torch; print('GPU count:', torch.cuda.device_count())"

# TensorFlow
python3 -c "import tensorflow as tf; print('GPUs:', tf.config.list_physical_devices('GPU'))"
```

## Workload Benchmarking

After hardware and framework validation, benchmarking with real-world workloads confirms that end-to-end inference and training performance meets expectations.

[MAD (Model Automation and Dashboarding)](https://github.com/ROCm/MAD) provides a library of production-representative AI model recipes for AMD Instinct GPUs, covering inference and training across common frameworks and architectures:

- **LLM inference** with vLLM and SGLang (Llama, DeepSeek, Mistral, and others)
- **LLM training** with PyTorch, Megatron-LM, and JAX MaxText
- **Multimodal and vision** inference workloads

MAD handles Docker image builds, model downloads, and performance result collection, making it straightforward to get representative benchmark numbers without building a custom test harness from scratch. See the [MAD repository](https://github.com/ROCm/MAD) for available model blueprints and usage instructions.

## Additional Resources

- [AMD Instinct Customer Acceptance Guide](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/)
- [ROCm Validation Suite Documentation](https://rocm.docs.amd.com/projects/ROCmValidationSuite/en/latest/)
- [MAD (Model Automation and Dashboarding)](https://github.com/ROCm/MAD)
- [ROCm Examples Repository](https://github.com/ROCm/rocm-examples)
- [GPU Cluster Networking Guide](https://instinct.docs.amd.com/projects/gpu-cluster-networking/en/latest/)

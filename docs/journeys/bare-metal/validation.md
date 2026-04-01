# Validation

This page provides a high-level overview of validation procedures for AMD Instinct accelerators on bare metal. The goal is to confirm that ROCm is installed and your GPUs are visible before moving on to formal acceptance testing.

For comprehensive, production-grade validation — including BIOS prerequisites, health checks, benchmark baselines, and explicit pass/fail acceptance criteria — refer to the **[AMD Instinct Customer Acceptance Guide](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/)**.

## Quick Sanity Check

After completing [Installation](installation.md), run these commands to confirm ROCm can see your GPUs:

```bash
# Confirm ROCm installation and GPU detection
rocminfo

# Monitor GPU status, power, and temperature
amd-smi monitor
```

If `rocminfo` lists your GPUs and `amd-smi monitor` shows them in a healthy state, ROCm is installed correctly and you can proceed to formal validation.

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

## Formal Acceptance Testing

For production deployments, passing the quick sanity check is only the beginning. The [Customer Acceptance Guide](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/) provides a structured, two-phase validation methodology:

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

## Cluster Validation Suite (CVS)

Many of the node and cluster validation steps can be automated using the **Cluster Validation Suite (CVS)**, which verifies health and performance across multiple nodes without requiring extensive manual intervention.

- [CVS Documentation](https://rocm.docs.amd.com/projects/cvs/en/latest/)
- [CVS GitHub Repository](https://github.com/ROCm/cvs)

## Framework Smoke Tests

Once the system is validated, a quick check that your target framework can see the GPUs is useful before moving on to workloads:

```bash
# PyTorch
python3 -c "import torch; print('GPU count:', torch.cuda.device_count())"

# TensorFlow
python3 -c "import tensorflow as tf; print('GPUs:', tf.config.list_physical_devices('GPU'))"
```

## Additional Resources

- [AMD Instinct Customer Acceptance Guide](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/)
- [ROCm Validation Suite Documentation](https://rocm.docs.amd.com/projects/ROCmValidationSuite/en/latest/)
- [ROCm Examples Repository](https://github.com/ROCm/rocm-examples)
- [GPU Cluster Networking Guide](https://instinct.docs.amd.com/projects/gpu-cluster-networking/en/latest/)

# Environment Setup

## Configuring Your Bare Metal Environment

After installing the ROCm software stack, the next step is configuring your environment for reliable, high-performance operation. Bare metal deployments give you full control over every layer — from hardware configuration through the application stack — which means both more flexibility and more responsibility.

This page covers the key configuration areas at a high level. For detailed BIOS settings, OS tuning parameters, and kernel configuration, see the [System Prerequisites](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/common/prerequisites.html) and [System Optimization Guide](https://rocm.docs.amd.com/en/latest/how-to/system-optimization/index.html).

## Hardware Layer

Ensure your server BIOS/UEFI is correctly configured before tuning the OS or software stack. Key areas include:

- **PCIe configuration** — correct slot assignments and lane widths for your GPU configuration
- **NUMA topology** — memory interleaving and NUMA node settings appropriate for your workload
- **Power management** — disable low-power sleep states that interfere with sustained GPU performance
- **I/O virtualization** — IOMMU/SR-IOV settings if using containers or VMs

The AMD Instinct Customer Acceptance Guide's [System Prerequisites](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/common/prerequisites.html) page specifies the required BIOS settings and firmware versions for each supported GPU platform.

## Operating System Configuration

After BIOS configuration, key OS-level settings to review include:

- **Kernel parameters** (GRUB) — IOMMU, huge page, and PCIe settings; see the acceptance guide prerequisites page for specific parameters
- **Huge pages** — large memory pages can improve memory access patterns for GPU-intensive workloads
- **CPU governor** — set to `performance` mode for sustained throughput:

  ```bash
  echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
  ```

- **NUMA balancing** — typically disabled for GPU workloads:

  ```bash
  echo 0 | sudo tee /proc/sys/kernel/numa_balancing
  ```

For NUMA topology inspection and process binding, use `numactl --hardware` to understand your system layout before configuring workload placement.

## ROCm Environment Variables

After installation, ROCm binaries and libraries are in `/opt/rocm` by default. Ensure this is in your `PATH` and `LD_LIBRARY_PATH`, or add the following to your shell profile:

```bash
export ROCM_PATH=/opt/rocm
export PATH=$ROCM_PATH/bin:$PATH
export LD_LIBRARY_PATH=$ROCM_PATH/lib:$ROCM_PATH/lib64:$LD_LIBRARY_PATH
```

**GPU visibility** — for multi-GPU systems, control which GPUs are visible to an application:

```bash
# All GPUs (default)
export HIP_VISIBLE_DEVICES=0,1,2,3,4,5,6,7

# Subset of GPUs
export HIP_VISIBLE_DEVICES=0,2,4,6
```

## GPU Monitoring

Use `amd-smi` to monitor GPU status, power, and thermal state:

```bash
# Snapshot of all GPUs
amd-smi monitor

# Continuous monitoring (refreshes every second)
amd-smi monitor --watch --interval 1000

# GPU topology and interconnect links
amd-smi topology
```

## Container Environments

ROCm supports both Docker and Podman. To expose AMD GPUs inside a container, pass the GPU device nodes:

```bash
# Docker
docker run -it --rm \
  --device=/dev/kfd \
  --device=/dev/dri \
  --security-opt seccomp=unconfined \
  rocm/pytorch:latest \
  amd-smi monitor

# Podman (rootless)
podman run --rm --device /dev/kfd --device /dev/dri rocm/pytorch:latest amd-smi monitor
```

Pre-built ROCm container images for PyTorch, TensorFlow, and other frameworks are available on [Docker Hub under the `rocm` organization](https://hub.docker.com/u/rocm).

## Framework Setup

For PyTorch and TensorFlow with ROCm support, use the installation instructions in the [ROCm for AI Guide](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/index.html), which covers the correct index URLs and version compatibility for each ROCm release. Using ROCm-specific wheels rather than generic CUDA builds is important for correct GPU support.

## Multi-GPU Configuration

For systems with multiple Instinct GPUs:

- Review `amd-smi topology` to understand the Infinity Fabric interconnect layout before configuring distributed workloads
- Bind processes to NUMA-local GPUs and memory for best performance; use `numactl` for process binding
- For RCCL-based distributed training, see the [RCCL documentation](https://rocm.docs.amd.com/projects/rccl/en/latest/)
- For multi-node configurations, see the [GPU Cluster Networking Guide](https://instinct.docs.amd.com/projects/gpu-cluster-networking/en/latest/)

## Next Steps

With your environment configured, proceed to [Validation](validation.md) to confirm your GPUs are operating correctly before running production workloads.

## Additional Resources

- [ROCm System Optimization Guide](https://rocm.docs.amd.com/en/latest/how-to/system-optimization/index.html)
- [AMD Instinct Customer Acceptance Guide — System Prerequisites](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/common/prerequisites.html)
- [ROCm for AI Guide](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/index.html)
- [GPU Cluster Networking Guide](https://instinct.docs.amd.com/projects/gpu-cluster-networking/en/latest/)

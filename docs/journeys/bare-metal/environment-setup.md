# Environment Setup

:::{card}
:class-card: journey-progress
[Hardware Selection](hardware-selection.md) → [Installation](installation.md) → **[Environment Setup](environment-setup.md)** → [Validation](validation.md) → [Optimization](optimization.md)
:::

## Environment Setup for AMD Instinct™ GPUs on Bare Metal

## Configuring Your Bare Metal Environment

After installing the ROCm software stack, the next step is properly configuring your environment to unlock the full potential of your AMD Instinct GPUs. Unlike cloud environments where many configuration details are abstracted away, bare metal deployments give you complete control—and complete responsibility—for every aspect of your system's configuration.

This is one of bare metal's greatest advantages, allowing you to fine-tune every component for maximum performance. However, it also means you need to understand and configure several key areas to ensure optimal operation. Let's walk through the configuration steps that will set the foundation for reliable, high-performance GPU computing.

## Understanding Your Configuration Responsibilities

In a bare metal environment, you have full ownership of the entire stack, from hardware configuration to application deployment. This complete control enables maximum performance optimization but requires careful attention to several key areas.

### Hardware Layer Configuration

**System BIOS/UEFI Settings:**

- PCIe configuration and slot assignments
- NUMA topology and memory interleaving
- Power management and thermal controls
- I/O virtualization settings (IOMMU/SR-IOV)

**Key Actions:**

- Configure PCIe lanes for optimal GPU bandwidth
- Set appropriate NUMA policies for your workload
- Enable necessary virtualization features if using containers
- Optimize power delivery settings for sustained performance

### Operating System Configuration

**Kernel Configuration:**

- GPU driver integration and device permissions
- Memory management and huge page allocation
- Process scheduling and CPU affinity
- Network and storage I/O optimization

**System Services:**

- GPU monitoring and telemetry services
- Container runtime configuration (if applicable)
- Security policies and access controls
- Backup and recovery procedures

### Software Stack Management

**ROCm Environment:**

- Library paths and environment variables
- Runtime configuration and optimization flags
- Multi-GPU communication setup (if applicable)
- Framework integration and compatibility

**Development Environment:**

- Compiler toolchains and build systems
- Debugging and profiling tool configuration
- Version management for dependencies
- Code repository and artifact management

## ROCm Environment Configuration

Now let's dive into the specific ROCm environment configuration that forms the foundation of your GPU computing stack.

### Essential Environment Variables

Proper environment variable configuration ensures that ROCm components can interact seamlessly and that applications can locate necessary libraries and tools.

**Core ROCm Variables:**

```bash
# ROCm installation path (adjust if using custom installation location)
export ROCM_PATH=/opt/rocm

# HIP platform specification
export HIP_PLATFORM=amd

# Ensure ROCm binaries are in PATH
export PATH=$ROCM_PATH/bin:$PATH

# Configure library search paths
export LD_LIBRARY_PATH=$ROCM_PATH/lib:$ROCM_PATH/lib64:$LD_LIBRARY_PATH

# Python path for ROCm Python packages
export PYTHONPATH=$ROCM_PATH/lib/python3.10/site-packages:$PYTHONPATH
```

**GPU Visibility and Selection:**

For multi-GPU systems, you'll often need to control which GPUs are visible to specific applications:

```bash
# Make all GPUs visible (default behavior)
export HIP_VISIBLE_DEVICES=0,1,2,3,4,5,6,7

# Make only specific GPUs visible
export HIP_VISIBLE_DEVICES=0,2,4,6

# Hide all GPUs (useful for CPU-only testing)
export HIP_VISIBLE_DEVICES=""
```

**Performance and Debugging Variables:**

```bash
# Enable HIP runtime logging for debugging
export HIP_PRINT_ENV=1

# Control GPU memory allocation behavior
export HSA_ENABLE_SDMA=0  # Disable system DMA for debugging
export AMD_LOG_LEVEL=3    # Set logging verbosity

# Optimize for specific workload patterns
export AMD_DIRECT_DISPATCH=1  # Reduce kernel launch overhead
```

### Persistent Configuration

To ensure these settings persist across system reboots and user sessions, add them to appropriate configuration files:

**System-wide Configuration** (affects all users):

```bash
# Create ROCm environment file
sudo tee /etc/environment.d/rocm.conf << 'EOF'
ROCM_PATH=/opt/rocm
HIP_PLATFORM=amd
PATH=/opt/rocm/bin:$PATH
LD_LIBRARY_PATH=/opt/rocm/lib:/opt/rocm/lib64:$LD_LIBRARY_PATH
EOF
```

**User-specific Configuration:**

```bash
# Add to ~/.bashrc or ~/.profile
cat >> ~/.bashrc << 'EOF'
# ROCm Environment Configuration
export ROCM_PATH=/opt/rocm
export HIP_PLATFORM=amd
export PATH=$ROCM_PATH/bin:$PATH
export LD_LIBRARY_PATH=$ROCM_PATH/lib:$ROCM_PATH/lib64:$LD_LIBRARY_PATH

# GPU visibility (adjust based on your system)
export HIP_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
EOF
```

## System-Level Optimization

Beyond ROCm-specific configuration, several system-level optimizations can significantly impact GPU performance.

### Memory Configuration

**Huge Pages Setup:**

Large memory pages can improve memory access patterns for GPU-intensive workloads:

```bash
# Check current huge page configuration
cat /proc/meminfo | grep HugePages

# Allocate huge pages (adjust count based on your memory needs)
echo 1024 | sudo tee /proc/sys/vm/nr_hugepages

# Make huge pages persistent across reboots
echo 'vm.nr_hugepages=1024' | sudo tee -a /etc/sysctl.conf
```

**NUMA Configuration:**

For multi-socket systems with multiple GPUs, proper NUMA configuration is crucial:

```bash
# Check NUMA topology
numactl --hardware

# Example: bind processes to specific NUMA nodes
numactl --cpunodebind=0 --membind=0 your_gpu_application

# Set NUMA policy for optimal GPU memory access
echo 'kernel.numa_balancing=0' | sudo tee -a /etc/sysctl.conf
```

### Power and Thermal Management

**GPU Power Limits:**

Configure appropriate power limits for sustained performance:

```bash
# Check current power configuration
amd-smi monitor

# Set power limit (adjust based on your cooling capacity)
amd-smi metric -P 400  # Set 400W power limit

# Monitor thermal performance
amd-smi monitor --watch --interval 1000
```

**CPU Governor Settings:**

Ensure CPU scaling doesn't impact GPU performance:

```bash
# Set CPU governor to performance mode
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Make persistent across reboots
sudo systemctl enable cpufrequtils
echo 'GOVERNOR="performance"' | sudo tee /etc/default/cpufrequtils
```

## Container Environment Setup

Even in bare metal environments, containers provide valuable isolation and reproducibility benefits. Here's how to configure container support for your AMD Instinct GPUs.

### Docker Configuration

**Install AMD Container Toolkit:**

The AMD Container Toolkit simplifies GPU access from within containers:

```bash
# Add AMD repository
curl -fsSL https://repo.radeon.com/rocm/rocm.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/rocm.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/rocm.gpg] https://repo.radeon.com/amdgpu-install/5.7/ubuntu jammy main" | sudo tee /etc/apt/sources.list.d/amdgpu.list

# Install container toolkit
sudo apt update
sudo apt install amd-docker-toolkit

# Configure Docker daemon
sudo systemctl restart docker
```

**Container Runtime Testing:**

Verify that containers can access your GPUs:

```bash
# Test GPU access in container
docker run -it --rm \
  --device=/dev/kfd \
  --device=/dev/dri \
  --security-opt seccomp=unconfined \
  rocm/pytorch:latest \
  amd-smi monitor
```

### Podman Configuration

For environments preferring rootless container execution:

```bash
# Install Podman with GPU support
sudo apt install podman

# Configure GPU access for rootless containers
echo 'unqualified-search-registries = ["docker.io"]' | sudo tee /etc/containers/registries.conf

# Test rootless GPU access
podman run --rm --device /dev/kfd --device /dev/dri rocm/pytorch:latest amd-smi monitor
```

## Development Environment Setup

Configure your development environment for optimal GPU application development and debugging.

### Compiler and Build Tools

**ROCm Compiler Configuration:**

```bash
# Verify HIP compiler installation
hipcc --version

# Configure CMake for ROCm projects
export CMAKE_PREFIX_PATH=$ROCM_PATH:$CMAKE_PREFIX_PATH

# Set up ROCm-aware Python environment
pip install --user torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm5.7
```

**Build System Integration:**

For projects using CMake, create a ROCm toolchain file:

```cmake
# rocm-toolchain.cmake
set(CMAKE_HIP_COMPILER ${ROCM_PATH}/bin/hipcc)
set(CMAKE_HIP_RUNTIME "rocclr")
set(CMAKE_HIP_PLATFORM "amd")

# Add ROCm library paths
list(APPEND CMAKE_PREFIX_PATH ${ROCM_PATH})
```

### Debugging and Profiling Setup

**ROCm Debugging Tools:**

```bash
# Install additional debugging tools
sudo apt install rocm-debug-agent rocprofiler-dev

# Configure GDB for GPU debugging
echo 'set environment HIP_PLATFORM amd' >> ~/.gdbinit
echo 'set environment ROCM_PATH /opt/rocm' >> ~/.gdbinit
```

**Profiling Environment:**

```bash
# Set up profiling data collection
export ROCP_TOOL_LIB=$ROCM_PATH/lib/librocprofiler-tool.so
export ROCP_METRICS=$ROCM_PATH/lib/rocprofiler/metrics.xml

# Configure profiling output directory
mkdir -p ~/rocm-profiling-data
export ROCP_OUTPUT_DIR=~/rocm-profiling-data
```

## Framework Integration

Configure popular AI/ML frameworks for optimal performance with your AMD Instinct GPUs.

### PyTorch Configuration

**Installation and Setup:**

```bash
# Install PyTorch with ROCm support
pip3 install --user torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm5.7

# Verify installation
python3 -c "import torch; print(f'ROCm available: {torch.cuda.is_available()}'); print(f'Device count: {torch.cuda.device_count()}')"
```

**Performance Optimization:**

Create a PyTorch configuration script for consistent settings:

```python
# pytorch_rocm_config.py
import torch
import os

# Optimize memory allocation
torch.cuda.empty_cache()
torch.cuda.set_per_process_memory_fraction(0.9)

# Enable optimized kernels
torch.backends.cuda.matmul.allow_tf32 = True
torch.backends.cudnn.allow_tf32 = True

# Set optimal thread counts
torch.set_num_threads(os.cpu_count())

print("PyTorch ROCm configuration applied")
```

### TensorFlow Configuration

**Environment Variables:**

```bash
# TensorFlow ROCm optimization
export TF_ROCM_FUSION_ENABLE=1
export HSA_FORCE_FINE_GRAIN_PCIE=1
export TF_GPU_THREAD_MODE=gpu_private
export TF_GPU_THREAD_COUNT=1
```

**Memory Growth Configuration:**

```python
# tensorflow_rocm_config.py
import tensorflow as tf

# Configure GPU memory growth
gpus = tf.config.experimental.list_physical_devices('GPU')
if gpus:
    try:
        for gpu in gpus:
            tf.config.experimental.set_memory_growth(gpu, True)
    except RuntimeError as e:
        print(e)

print("TensorFlow ROCm configuration applied")
```

## Multi-GPU Configuration

For systems with multiple AMD Instinct GPUs, additional configuration ensures optimal multi-GPU performance.

### GPU Topology Understanding

**Analyze GPU Interconnect:**

```bash
# Check GPU topology and connections
amd-smi topology

# Verify peer-to-peer connectivity
amd-smi link

# Monitor inter-GPU bandwidth
rocm-bandwidth-test
```

**NUMA-Aware GPU Binding:**

```bash
# Create GPU affinity script
cat > gpu_affinity.sh << 'EOF'
#!/bin/bash
# Bind GPUs to optimal NUMA nodes
# Adjust based on your system topology

export CUDA_DEVICE_ORDER=PCI_BUS_ID
export HIP_VISIBLE_DEVICES=0,1,2,3,4,5,6,7

# Set NUMA policy for multi-GPU workloads
numactl --interleave=all "$@"
EOF

chmod +x gpu_affinity.sh
```

### Distributed Computing Setup

**MPI Configuration:**

```bash
# Install ROCm-aware MPI
sudo apt install openmpi-bin openmpi-common libopenmpi-dev

# Configure MPI for GPU-aware communication
export OMPI_MCA_pml=ucx
export OMPI_MCA_btl=^vader,tcp,openib,uct
```

## Next Steps

With your bare metal environment properly configured, you're ready to validate that everything is working correctly. The next section, [Validation](validation.md), will guide you through comprehensive testing procedures to ensure your AMD Instinct GPUs are performing optimally.

Remember that environment configuration is an iterative process. As you gain experience with your specific workloads and hardware configuration, you may want to revisit and fine-tune these settings for even better performance.

**Key Resources for Further Optimization:**

- [ROCm System Optimization Guide](https://rocm.docs.amd.com/en/latest/how-to/system-optimization/) - Comprehensive optimization strategies
- [AMD Instinct Performance Tuning](https://instinct.docs.amd.com/) - Hardware-specific optimization guides
- [ROCm Developer Tools](https://rocm.docs.amd.com/projects/rocprofiler/en/latest/) - Profiling and debugging resources

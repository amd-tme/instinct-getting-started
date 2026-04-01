# Environment Setup

## Environment Setup for AMD Instinct™ GPUs in Cloud

## Configuring Your Cloud Environment

Once you've selected your cloud provider, the next step is configuring your environment for optimal AMD Instinct GPU performance. Before diving into the technical setup, it's important to understand how responsibilities are divided in cloud environments.

In cloud computing, success depends on understanding what you're responsible for managing versus what your cloud provider handles automatically. This shared responsibility model varies slightly between providers, but the fundamental principles remain consistent across all major cloud platforms.

### Your Responsibilities (Customer)

**Application Layer:**

- Install and configure ROCm software stack
- Manage application dependencies and frameworks
- Optimize workload performance and resource utilization
- Configure application-level security and access controls

**Data Management:**

- Design and implement data pipelines
- Choose appropriate storage solutions for your workloads
- Implement data backup and disaster recovery strategies
- Ensure data compliance with your organization's requirements

**Key Resources for Your Responsibilities:**

- [ROCm Documentation](https://rocm.docs.amd.com/) - Complete software stack guidance
- Your cloud provider's AI/ML service documentation
- Framework-specific documentation (PyTorch, TensorFlow)

### Cloud Provider Responsibilities

**Infrastructure Layer:**

- Physical hardware maintenance and security
- Network infrastructure and connectivity
- Base operating system patches and updates
- Hypervisor and virtualization layer management

**Platform Services:**

- Managed storage services (object storage, block storage)
- Network security groups and load balancing
- Identity and access management systems
- Monitoring and logging infrastructure

### Shared Responsibilities

**Security:**

- **You manage:** Application security, data encryption, user access controls
- **Provider manages:** Infrastructure security, physical access, network isolation
- **Reference:** Check your cloud provider's shared responsibility model documentation

**Monitoring:**

- **You manage:** Application performance monitoring, custom metrics, alerting rules
- **Provider manages:** Infrastructure monitoring, service health, capacity management
- **Getting Started:** Use your cloud provider's native monitoring services (CloudWatch, Azure Monitor, etc.)

**Storage:**

- **You manage:** Data organization, backup strategies, access patterns optimization
- **Provider manages:** Storage durability, availability, infrastructure scaling
- **Guidance:** Review your provider's storage service options and pricing models

## ROCm Software Configuration

Now that you understand the responsibility boundaries, let's focus on the software configuration tasks that fall within your domain.

### Base Installation

Most cloud providers offer pre-configured virtual machine images with ROCm already installed, which significantly accelerates your setup process. However, understanding the core components ensures you can validate and optimize your configuration.

**Key Components:**

- **ROCm runtime**: Core platform for GPU compute
- **HIP libraries**: GPU programming interface
- **Math libraries**: rocBLAS, rocRAND, rocFFT, and others
- **AI frameworks**: PyTorch, TensorFlow with ROCm support

**Configuration Verification:**

After installation, verify your setup with these essential checks:

```bash
# Verify GPU detection
amd-smi monitor

# Check ROCm installation and version
amd-smi version

# Validate HIP environment
hipconfig --full
```

### Environment Variables

Proper environment variable configuration ensures ROCm components can locate and interact with each other correctly:

```bash
# ROCm installation path
export ROCM_PATH=/opt/rocm

# HIP platform specification
export HIP_PLATFORM=amd

# Library paths
export LD_LIBRARY_PATH=$ROCM_PATH/lib:$LD_LIBRARY_PATH
export PATH=$ROCM_PATH/bin:$PATH
```

These variables should typically be added to your shell profile (`.bashrc` or `.profile`) to persist across sessions.

## Container Environment Preparation

Containers provide consistent, reproducible environments that work reliably across different cloud providers and development stages.

### ROCm Docker Images

AMD provides pre-built Docker images that eliminate much of the installation complexity. These images come with ROCm and popular frameworks already configured and optimized.

**Available Base Images:**

- `rocm/pytorch:latest` - PyTorch with ROCm support
- `rocm/tensorflow:latest` - TensorFlow with ROCm support
- `rocm/rocm-terminal:latest` - Development environment
- `rocm/dev-ubuntu-22.04:latest` - Base development image

**Custom Container Creation:**

Building on these base images allows you to create specialized environments for your specific workloads:

```dockerfile
FROM rocm/pytorch:latest

# Install additional dependencies
RUN pip install transformers accelerate

# Set up workspace
WORKDIR /workspace
COPY requirements.txt .
RUN pip install -r requirements.txt

# Configure environment
ENV HIP_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
```

### Container Runtime Configuration

AMD now provides a Docker toolkit that significantly simplifies container usage by reducing the number of arguments needed to run ROCm containers. This toolkit streamlines the setup process compared to manual device mounting.

**With AMD Docker Toolkit:**

The AMD Docker toolkit handles device access and security configurations automatically. For detailed setup and usage instructions, see the [AMD Container Toolkit Quick Start Guide](https://instinct.docs.amd.com/projects/container-toolkit/en/latest/container-runtime/quick-start-guide.html).

**Manual Configuration (Alternative):**

If you prefer manual configuration or need custom setups, you can still run containers with explicit device access:

```bash
# Run container with GPU access
docker run -it --rm \
  --device=/dev/kfd \
  --device=/dev/dri \
  --group-add video \
  --ipc=host \
  --security-opt seccomp=unconfined \
  rocm/pytorch:latest
```

**Kubernetes Integration:**

AMD provides a comprehensive Kubernetes device plugin that enables automatic GPU resource management and scheduling. This plugin also includes a metrics exporter for monitoring GPU utilization in Kubernetes environments. For setup instructions, see the [AMD Kubernetes Device Plugin documentation](https://instinct.docs.amd.com/projects/k8s-device-plugin/en/latest/).

## Framework-Specific Setup

With ROCm properly configured, the next step is validating that your chosen AI/ML frameworks can successfully utilize the GPU resources.

### PyTorch with ROCm

PyTorch's ROCm integration uses the same CUDA-style API, making it straightforward to adapt existing code for AMD GPUs.

**Installation Verification:**

Start by confirming PyTorch can detect and access your AMD GPUs:

```python
import torch
print(f"ROCm available: {torch.cuda.is_available()}")
print(f"GPU count: {torch.cuda.device_count()}")
print(f"GPU name: {torch.cuda.get_device_name(0)}")
```

**Optimization Settings:**

These configuration options can improve performance for many workloads:

```python
# Enable optimized memory management
torch.backends.cuda.matmul.allow_tf32 = True
torch.backends.cudnn.allow_tf32 = True

# Configure memory allocation
torch.cuda.empty_cache()
torch.cuda.set_per_process_memory_fraction(0.9)
```

### TensorFlow with ROCm

TensorFlow requires specific environment variables to optimize its interaction with ROCm.

**Environment Configuration:**

Set these variables before launching TensorFlow applications:

```bash
# Configure TensorFlow for ROCm
export TF_FORCE_GPU_ALLOW_GROWTH=true
export TF_GPU_THREAD_MODE=gpu_private
```

**Runtime Verification:**

Verify TensorFlow's GPU detection and configuration:

```python
import tensorflow as tf
print("GPU Available: ", tf.config.list_physical_devices('GPU'))
print("GPU Details: ", tf.config.experimental.get_device_details(
    tf.config.list_physical_devices('GPU')[0]
))
```

## Environment Validation

Before deploying production workloads, comprehensive testing ensures your environment is properly configured and performing as expected.

### Hardware and Software Validation

**Basic Hardware Validation:**

AMD's primary system management interface tool provides essential hardware verification and monitoring capabilities:

```bash
# Display comprehensive GPU information
amd-smi static

# Run basic monitoring to verify GPU detection
amd-smi monitor
```

The `amd-smi` command is AMD's primary system management interface tool for ROCm validation. For complete usage details, see the [AMD SMI CLI documentation](https://rocm.docs.amd.com/projects/amdsmi/en/latest/how-to/amdsmi-cli-tool.html).

### ROCm Validation Suite (RVS)

The ROCm Validation Suite is a comprehensive testing framework designed to detect and troubleshoot common issues affecting AMD GPUs running in high-performance computing environments. RVS performs stress testing, power and thermal monitoring, and validates that your GPU hardware can handle sustained computational workloads.

For cloud environments, RVS is particularly valuable for validating that your instances are performing as expected and haven't been affected by virtualization overhead or thermal constraints.

```bash
# Run GPU stress test with default single GPU configuration
/opt/rocm/share/rocm-validation-suite/rvs -c gst_single.conf
```

The `gst_single.conf` test performs GPU stress testing to validate hardware stability and performance under load. For comprehensive documentation and additional test configurations, see the [ROCm Validation Suite documentation](https://rocm.docs.amd.com/projects/ROCmValidationSuite/en/latest/index.html).

**Software Stack Validation:**

Confirm your complete software stack functions correctly with a simple end-to-end test:

```python
# Validate complete software stack
import torch
import transformers

# Test basic operations
device = torch.device('cuda:0')
x = torch.randn(1000, 1000, device=device)
y = torch.mm(x, x.t())
print(f"Matrix multiplication successful: {y.shape}")
```

**Performance Benchmarking:**

Establish baseline performance metrics by running standard benchmarks like MLPerf or SPEC. Compare results against expected performance levels for your specific hardware configuration. This baseline becomes invaluable for identifying performance regressions or optimization opportunities later.

## Automation and Infrastructure as Code

As your GPU workloads scale, manual configuration becomes impractical. Infrastructure as Code (IaC) approaches ensure consistent, repeatable deployments across environments.

### Infrastructure Automation

Terraform and similar tools allow you to define your cloud infrastructure declaratively:

```hcl
# Example Terraform for cloud GPU instances
resource "cloud_instance" "gpu_cluster" {
  count         = var.instance_count
  instance_type = var.gpu_instance_type
  image_id      = var.rocm_optimized_image
  
  user_data = templatefile("${path.module}/setup.sh", {
    rocm_version = var.rocm_version
  })
  
  tags = {
    Purpose = "AMD-GPU-Workload"
    ROCm    = var.rocm_version
  }
}
```

### Configuration Management

Configuration management tools like Ansible, Chef, or Puppet help maintain consistent configurations across your fleet. Focus these tools on managing ROCm installation and updates, environment variable configuration, security policy enforcement, and monitoring agent deployment.

The key advantage of this approach is that your infrastructure becomes documented, version-controlled, and reproducible—essential qualities for production GPU workloads.

## Next Steps

With your environment configured, you're ready to:

1. [Provision GPU resources](../provisioning-overview/) for your workloads
2. Deploy and scale your applications using cloud-native tools
3. Optimize performance using ROCm profiling tools
4. Implement monitoring and cost optimization strategies

## Troubleshooting Common Issues

Even with careful setup, you may encounter common configuration challenges. Here are the most frequent issues and their solutions.

### GPU Detection Problems

If your applications can't detect AMD GPUs, the issue usually involves user permissions or ROCm installation completeness. Verify that your user account belongs to the `render` and `video` groups, check that ROCm installation completed successfully with all required components, and validate that your drivers are compatible with your ROCm version.

### Performance Issues

Performance problems often stem from resource constraints or configuration mismatches. Monitor memory utilization and bandwidth to identify bottlenecks, check for thermal throttling that might be limiting GPU performance, and validate network configuration for distributed workloads where inter-node communication affects overall performance.

### Container Issues

Container-related problems typically involve device access or version mismatches. Ensure proper device mounting with the correct `/dev/kfd` and `/dev/dri` devices, verify that security context permissions allow GPU access, and check that ROCm versions match between your host system and container images.

## Additional Resources

- [ROCm Installation Guide](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/)
- [Container Deployment Guide](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/how-to/docker.html)
- [Cloud Provider Specific Guides](../provider-selection/)
- [Performance Optimization Guide](../../bare-metal/performance-optimization/)

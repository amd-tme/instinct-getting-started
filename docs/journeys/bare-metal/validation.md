# Validation

This guide provides a high-level overview of validation procedures for AMD Instinct accelerators in a single-node environment. For detailed step-by-step instructions, refer to the linked official documentation.

## Basic System Validation

After completing the hardware installation and software setup, perform these basic validation steps to ensure your Instinct GPU is properly recognized and functioning.

### 1. Verify GPU Detection

First, confirm that your system properly detects the installed Instinct GPU(s):

```bash
# Check if GPU is detected by ROCm
amd-smi monitor
```

### 2. Run Hardware Diagnostics

For comprehensive hardware validation, use the ROCm Validation Suite (RVS):

```bash
# List available GPUs
/opt/rocm/bin/rvs -g

# Run a general system test
/opt/rocm/bin/rvs -c /opt/rocm/share/rocm-validation-suite/conf/<your_gpu_model>/gst_single.conf
```

RVS provides thorough testing through various test modules:

- GST (GPU Stress Test) - Validates GPU functionality under load
- GPUP (GPU Properties) - Shows detailed hardware information
- PBQT (P2P Bandwidth and Latency) - Tests peer-to-peer performance
- PEBB (PCIe Bandwidth) - Measures PCIe throughput
- PEQT (PCIe Qualification) - Verifies PCIe compliance

## Software Stack Validation

Verify that the ROCm software stack is properly installed and functioning.

### 1. Check ROCm Installation

```bash
# Verify ROCm version
/opt/rocm/bin/hipcc --version

# Check HIP environment
HIP_PLATFORM=amd /opt/rocm/bin/hipconfig --full
```

### 2. Run a Simple HIP Test Program

Create a simple test file to verify that your HIP environment is working correctly:

```bash
# Create a test directory
mkdir -p ~/hip_test && cd ~/hip_test

# Download a simple HIP example (or create from documentation)
git clone https://github.com/ROCm/rocm-examples.git
cd rocm-examples/HIP-Basic/hello_world

# Build and run the example
mkdir build && cd build
cmake ..
make
./hip_hello_world
```

This simple test confirms that:

- HIP compiler is working
- GPU is accessible for computation
- ROCm runtime is functioning

## Performance Validation

After confirming basic functionality, validate the performance of your Instinct GPU.

### 1. Memory Bandwidth Testing - FIX

Test the memory bandwidth using a benchmark like STREAM:

```bash
# Clone and build a HIP-compatible STREAM benchmark
git clone https://github.com/ROCm-Developer-Tools/HIP-Examples.git
cd HIP-Examples/cuda-stream
make
./stream
```

### 2. Compute Performance Testing - FIX

Validate computational performance:

```bash
# Run a matrix multiplication benchmark
cd ~/HIP-Examples/HIP-Examples-Applications/MatrixMultiplication
make
./matrixmul
```

## Framework-Specific Validation - ADD INSTALL STEPS/LINS

If you plan to use specific frameworks, verify their compatibility with your Instinct GPU.

### Deep Learning Frameworks

```bash
# For PyTorch
python3 -c "import torch; print('GPU available:', torch.cuda.is_available()); print('Device count:', torch.cuda.device_count())"

# For TensorFlow
python3 -c "import tensorflow as tf; print('GPU available:', tf.config.list_physical_devices('GPU'))"
```

### HPC Libraries - FIX

Test common HPC libraries:

```bash
# Test rocBLAS (if installed)
cd /opt/rocm/rocblas/bin
./rocblas-bench -f gemm -r f32_r --transposeA N --transposeB N -m 1024 -n 1024 -k 1024
```

## Troubleshooting Common Issues

If you encounter issues during validation:

### 1. Verify User Permissions

```bash
# Check if user is in required groups
groups | grep -E 'render|video'

# Add user to groups if needed
sudo usermod -a -G render,video $USER
```

### 2. Check ROCm Environment

```bash
# Verify environment variables
echo $PATH | grep rocm
echo $LD_LIBRARY_PATH | grep rocm
```

### 3. Examine System Logs

```bash
# Check for GPU-related messages
dmesg | grep -i amdgpu
```

## Additional Resources

- [ROCm Validation Suite Documentation](https://rocm.docs.amd.com/projects/ROCmValidationSuite/en/latest/)
- [ROCm Examples Repository](https://github.com/ROCm/rocm-examples)

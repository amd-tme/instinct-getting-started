# Installation

This guide provides a high-level overview of the installation process for AMD Instinct accelerators. For detailed, step-by-step instructions, please refer to the [official ROCm documentation](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/index.html).

## Prerequisites

Before beginning installation, ensure your system meets the following requirements:

### System Requirements

- **Supported Operating Systems**:
  - Ubuntu 20.04, 22.04, or 24.04
  - Red Hat Enterprise Linux (RHEL) 8.x or 9.x
  - SUSE Linux Enterprise Server (SLES) 15.x
  
- **Kernel Requirements**: Check your kernel version with `uname -srmv` and ensure it matches the requirements in the [ROCm system requirements documentation](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/reference/system-requirements.html).

### Pre-Installation Steps

**Verify System Compatibility**:

```bash
uname -m && cat /etc/*release
uname -srmv
```

**Ensure User Group Membership**:

Add your user to the necessary groups for GPU access:

```bash
sudo usermod -a -G render,video $LOGNAME
```

**Install Required Packages**:
Depending on your distribution, install prerequisite packages:

For Ubuntu:

```bash
sudo apt install python3-setuptools python3-wheel
```

For RHEL:

```bash
sudo dnf install python3-setuptools python3-wheel
```

## Installation Methods

ROCm offers multiple installation approaches. Choose the one that best fits your needs:

### 1. Quick Start Method (Recommended for New Users)

The quickest way to install ROCm is using the AMDGPU installer:

**Download and Install the AMDGPU Installer**:

For Ubuntu (adjust version as needed):

```bash
wget https://repo.radeon.com/amdgpu-install/latest/ubuntu/jammy/amdgpu-install_latest_all.deb
sudo apt install ./amdgpu-install_latest_all.deb
sudo apt update
```

**Install ROCm**:

```bash
sudo apt install rocm
```

**Reboot Your System**:

 ```bash
 sudo reboot
 ```

For detailed quick start instructions for your specific OS, refer to the [ROCm Quick Start Guide](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/install/quick-start.html).

### 2. Package Manager Method (Advanced)

For more control over the installation process, you can use your distribution's package manager directly:

**Add GPG Key and Repositories**:
   Set up the necessary repositories for your specific distribution.

**Install Kernel Driver**:

 ```bash
 sudo apt install amdgpu-dkms    # For Ubuntu
 sudo dnf install amdgpu-dkms    # For RHEL
 ```

**Install ROCm Packages**:

 ```bash
 sudo apt install rocm    # For Ubuntu
 sudo dnf install rocm    # For RHEL
 ```

For detailed instructions, refer to the [ROCm Detailed Installation Guide](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/install/index.html).

### 3. Alternative Installation Methods

ROCm also offers:

- **Multi-version Installation**: For running multiple ROCm versions side-by-side
- **Offline Installation**: For systems without internet access
- **Runfile Installation**: For systems without a package manager

See [ROCm Installation Overview](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/install/install-overview.html) for more information.

## Post-Installation Verification

After installation, verify your setup:

**Verify ROCm Installation**:

```bash
/opt/rocm/bin/rocminfo
```

**Check GPU Detection**:

```bash
/opt/rocm/bin/amd-smi monitor
```

## Additional Resources

- [ROCm Documentation Home](https://rocm.docs.amd.com/)

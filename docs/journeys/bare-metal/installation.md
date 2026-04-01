# Installation

This page provides a high-level overview of the ROCm installation process for AMD Instinct accelerators on bare metal. For detailed step-by-step instructions, refer to the [official ROCm documentation](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/index.html).

## Before You Install: System Prerequisites

ROCm installation assumes your server is already correctly configured at the hardware and OS level. If you are preparing a new system — or validating an existing one for production — review the system prerequisites before proceeding:

- **[System Prerequisites](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/common/prerequisites.html)** (AMD Instinct Customer Acceptance Guide) — covers supported OS versions, required firmware and BIOS settings, GRUB kernel parameters, and foundational OS tuning. Getting these right before installing ROCm avoids difficult-to-diagnose issues later.

## Supported Operating Systems

- Ubuntu 22.04, 24.04
- Red Hat Enterprise Linux (RHEL) 8.x or 9.x
- SUSE Linux Enterprise Server (SLES) 15.x

Verify the exact kernel and OS version requirements for your ROCm release in the [ROCm system requirements documentation](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/reference/system-requirements.html).

## Pre-Installation Steps

**Verify OS and architecture:**

```bash
uname -m && cat /etc/*release
uname -srmv
```

**Ensure user group membership** (required for GPU device access):

```bash
sudo usermod -a -G render,video $LOGNAME
# Log out and back in for group changes to take effect
```

**Install prerequisite packages:**

For Ubuntu:

```bash
sudo apt install python3-setuptools python3-wheel
```

For RHEL:

```bash
sudo dnf install python3-setuptools python3-wheel
```

## Installation Methods

ROCm offers multiple installation approaches. The AMDGPU installer is recommended for most users.

### Recommended: AMDGPU Installer

The `amdgpu-install` script handles driver and ROCm package installation in a single step.

**Ubuntu:**

```bash
sudo apt update
wget https://repo.radeon.com/amdgpu-install/latest/ubuntu/jammy/amdgpu-install_latest_all.deb
sudo apt install ./amdgpu-install_latest_all.deb
sudo apt update
sudo amdgpu-install --usecase=rocm
```

**RHEL:**

```bash
sudo dnf install https://repo.radeon.com/amdgpu-install/latest/rhel/$(. /etc/os-release; echo $VERSION_ID)/amdgpu-install*.rpm
sudo amdgpu-install --usecase=rocm
```

After installation, reboot your system:

```bash
sudo reboot
```

For the full quick-start guide, see [ROCm Quick Start](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/install/quick-start.html).

### Package Manager Method

For more control over the installation, you can add AMD repositories and install packages directly with your distribution's package manager. See the [ROCm Detailed Installation Guide](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/install/index.html).

### Alternative Methods

ROCm also supports multi-version installations, offline installations, and runfile-based installation for environments without a package manager. See the [ROCm Installation Overview](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/install/install-overview.html).

## Post-Installation Verification

After rebooting, run a quick check to confirm ROCm and your GPUs are visible:

```bash
# Full ROCm system report including GPU detection
/opt/rocm/bin/rocminfo

# GPU status monitoring
/opt/rocm/bin/amd-smi monitor
```

If your GPUs appear in both outputs, proceed to [Validation](validation.md) for more thorough testing.

## Additional Resources

- [ROCm Documentation Home](https://rocm.docs.amd.com/)
- [ROCm Installation on Linux](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/)
- [AMD Instinct Customer Acceptance Guide — System Prerequisites](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/common/prerequisites.html)

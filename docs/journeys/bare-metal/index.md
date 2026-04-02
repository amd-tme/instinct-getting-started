# Overview

## Getting Started with Direct Hardware Deployment

The Bare Metal journey provides a path for deploying AMD Instinct accelerators directly on your hardware infrastructure. Whether you're setting up a development workstation, building an AI inference server, or constructing a high-performance computing cluster, this guide walks you through the essential steps from hardware selection to performance optimization.

For production deployments, the **[AMD Instinct Customer Acceptance Guide](https://instinct.docs.amd.com/projects/system-acceptance/en/latest/)** provides comprehensive validation workflows and acceptance criteria for MI300X through MI355X platforms.

## When to Choose Bare Metal Deployment

The Bare Metal journey is ideal for users who:

- Need complete control over their hardware and software stack
- Require maximum performance with optimized configurations
- Have specific infrastructure requirements or constraints
- Want to integrate AMD Instinct accelerators into existing systems
- Are building specialized HPC or AI infrastructure

If you're looking for a more managed deployment option with reduced setup complexity, consider exploring our [Cloud Deployment Journey](../cloud/index.md) instead.

Let's begin your journey with [Hardware Selection](hardware-selection/).

### [1. Hardware Selection](hardware-selection/)

Review the current AMD Instinct GPU lineup — from MI300X through MI355X — and understand key selection criteria including memory capacity, supported precision formats, and platform requirements. Links to per-GPU specifications and the Customer Acceptance Guide are provided for deeper technical detail.

### [2. Installation and Setup](installation/)

Install the ROCm software stack using the recommended AMDGPU installer. This section also points you to the system prerequisites you should complete — BIOS settings, firmware alignment, and OS configuration — before installing ROCm.

### [3. Environment Setup](environment-setup/)

Configure your environment for reliable GPU operation: kernel parameters, ROCm environment variables, GPU monitoring, container access, and multi-GPU topology. Pointers to the ROCm System Optimization Guide are included for deeper configuration guidance.

### [4. Validation and Testing](validation/)

Confirm your system is operating correctly with a quick sanity check, then move on to the formal per-GPU acceptance workflow using AMD GPU Field Health Check (AGFHC) and the Cluster Validation Suite (CVS). Links to per-GPU pages in the Customer Acceptance Guide are provided.

### [5. Performance Optimization](optimization/)

Understand the key levers for GPU performance: system-level BIOS and OS tuning, ROCm profiling tools (ROCm Compute Profiler, rocprofv3), memory optimization strategies, and framework-specific tuning for AI and HPC workloads.

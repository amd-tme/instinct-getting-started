# Overview

:::{card}
:class-card: journey-progress
[Hardware Selection](hardware-selection.md) → [Installation](installation.md) → [Environment Setup](environment-setup.md) → [Validation](validation.md) → [Optimization](optimization.md)
:::

## Getting Started with Direct Hardware Deployment

The Bare Metal journey provides a comprehensive path for deploying AMD Instinct accelerators directly on your hardware infrastructure. Whether you're setting up a development workstation, building an AI inference server, or constructing a high-performance computing cluster, this guide will walk you through the essential steps from hardware selection to performance optimization.

## When to Choose Bare Metal Deployment

The Bare Metal journey is ideal for users who:

- Need complete control over their hardware and software stack
- Require maximum performance with optimized configurations
- Have specific infrastructure requirements or constraints
- Want to integrate AMD Instinct accelerators into existing systems
- Are building specialized HPC or AI infrastructure

If you're looking for a more managed deployment option with reduced setup complexity, consider exploring our [Cloud Deployment Journey](../cloud-journey/) instead.

Let's begin your journey with [Hardware Selection](hardware-selection/).

## Your Journey Path

![Bare Metal Journey Path](../../_static/images/bare_metal.svg)

### [1. Hardware Selection](hardware-selection/)

Begin your journey by selecting the right AMD Instinct GPU for your specific workload requirements. This section guides you through the available Instinct product families, helping you understand key considerations like memory capacity, computational capabilities, and infrastructure requirements. Whether you're focused on AI training, inference, or scientific computing, you'll learn how to choose the optimal hardware configuration.

### [2. Installation and Setup](installation/)

Once you've selected your hardware, this section walks you through the process of installing the ROCm software stack and configuring your system. You'll learn about different installation approaches, from quick-start methods to advanced configuration options. By the end of this section, you'll have your AMD Instinct GPU properly installed and ready for environment configuration.

### [3. Environment Setup](environment-setup/)

After installing the ROCm software stack, proper environment configuration is essential for optimal GPU performance. This section guides you through configuring environment variables, system-level optimizations, container environments, and framework integration. You'll learn how to set up your development environment and configure multi-GPU systems for maximum performance.

### [4. Validation and Testing](validation/)

Before running production workloads, it's essential to verify that your system is functioning correctly. This section covers basic system validation, software stack verification, and performance testing. You'll learn how to use various diagnostic tools to confirm your Instinct GPU is operating as expected and delivering the anticipated performance.

### [5. Performance Optimization](optimization/)

The final step in your journey focuses on maximizing the performance of your AMD Instinct accelerators. This section introduces profiling tools and optimization techniques for both system-level and application-specific tuning. You'll discover how to identify bottlenecks and implement targeted optimizations to achieve peak performance for your specific workloads.

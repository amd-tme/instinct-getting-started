# Implementing Journey Line Documentation in Sphinx for AMD Instinct GPUs

## Overview

Based on my research, here are the key recommendations for implementing a "journey line" approach in your AMD Instinct GPU documentation using Sphinx, Read the Docs, and rocm-docs-core. This approach will create clear guided paths for both bare metal and cloud deployment scenarios.

## Current ROCm Documentation Structure

The ROCm documentation uses several key components:

- **Sphinx** as the documentation generator
- **Sphinx Book Theme** as the base theme with customization
- **Sphinx Design** for grids, cards, and synchronized tabs
- **Sphinx External TOC** for navigation using YAML-based TOC files
- **MyST** (Markedly Structured Text) for Markdown support

This setup provides a solid foundation for implementing journey-based documentation.

## Key Recommendations

### 1. Leverage Sphinx External TOC for Journey Navigation

The existing `_toc.yml.in` file system used by ROCm docs can be extended to create dedicated journeys:

```yaml
# _toc.yml.in
root: index
subtrees:
  - caption: "Getting Started Journeys"
    entries:
      - file: journeys/index
        subtrees:
          - caption: "Bare Metal Journey"
            entries:
              - file: journeys/bare-metal/overview
              - file: journeys/bare-metal/step1-hardware-selection
              - file: journeys/bare-metal/step2-installation
              - file: journeys/bare-metal/step3-validation
              # Additional steps
          - caption: "Cloud Journey"
            entries:
              - file: journeys/cloud/overview
              - file: journeys/cloud/step1-provider-selection
              - file: journeys/cloud/step2-provisioning
              - file: journeys/cloud/step3-environment-setup
              # Additional steps
```

This approach maintains the existing navigation structure while adding clear journey paths.

### 2. Use Sphinx Design Cards for Journey Entry Points

The Sphinx Design extension (already used in ROCm docs) provides cards that work well for journey entry points on a landing page:

```markdown
# Getting Started with AMD Instinct GPUs

Choose your journey:

::::{grid} 1 1 2 2
:gutter: 3

:::{grid-item-card} Bare Metal Deployment
:link: journeys/bare-metal/overview
:link-type: doc
:img-top: _static/images/bare-metal-icon.png
:class-card: journey-card

Deploy AMD Instinct GPUs in your data center or on-premises environment for maximum performance and control.

^^^
**Ideal for:**
* Enterprise AI infrastructure
* High-performance computing clusters
* Production inference environments
* Specialized research computing
:::

:::{grid-item-card} Cloud Deployment
:link: journeys/cloud/overview
:link-type: doc
:img-top: _static/images/cloud-icon.png
:class-card: journey-card

Deploy AMD Instinct GPUs in cloud environments for flexibility, scalability, and reduced infrastructure management.

^^^
**Ideal for:**
* Rapid prototyping and experimentation
* Variable workload demands
* Distributed teams and collaborative projects
* Hybrid cloud/on-premises environments
:::
::::
```

### 3. Implement Progressive Disclosure with Tabbed Content and Expandable Sections

For complex topics, use tabbed content and expandable sections to implement progressive disclosure:

``````markdown
# Installing ROCm Software Stack

:::{tab-set}
::: {tab-item} Quick Install
Basic installation steps for getting started quickly:

```bash
sudo apt update
sudo apt install rocm-dev
```
:::

::: {tab-item} Custom Installation
Advanced options for customized installations:

```bash
# Additional installation options
sudo apt install rocm-dev rocm-libs rocm-utils
```
:::

::: {tab-item} Troubleshooting
Solutions for common installation issues:

1. Check system compatibility
2. Verify kernel version
3. Check for conflicting packages
:::
:::

:::{dropdown} Advanced Configuration Options
:icon: gear
:animate: fade-in

Detailed configuration options for optimizing your installation:

...configuration details...
:::
``````

### 4. Create Visual Progress Indicators

Implement a progress bar or step indicator at the top of each journey page to show users where they are in the process:

```markdown
:::{card}
:class-card: journey-progress

**Bare Metal Journey: Step 2 of 5**
[Hardware Selection] → **[Installation]** → [Validation] → [Development Setup] → [Optimization]
:::
```

### 5. Custom CSS for Journey Styling

Add custom CSS to enhance the journey experience:

```css
/* _static/css/journey.css */
.journey-card {
    transition: transform 0.3s;
    border-left: 5px solid #e74c3c;
}

.journey-card:hover {
    transform: translateY(-5px);
}

.journey-progress {
    background-color: #f8f9fa;
    border-left: 5px solid #3498db;
    margin-bottom: 2rem;
}

/* Different colors for different journey paths */
.bare-metal-step {
    border-left: 5px solid #e74c3c;
}

.cloud-step {
    border-left: 5px solid #3498db;
}
```

Add to your `conf.py`:

```python
html_static_path = ['_static']
html_css_files = ['css/journey.css']
```

### 6. Implement Interactive Learning Checks

Add interactive elements to help users validate their understanding:

```markdown
:::{dropdown} Knowledge Check
:icon: question
:class-body: knowledge-check

**Q: What is the minimum recommended system memory for running LLM inference workloads?**

<details>
<summary>Click to see answer</summary>

64GB is the minimum recommended memory for moderate LLM inference workloads. For large models, 128GB or more is recommended.
</details>
:::
```

### 7. Create a Cross-Journey Navigation System

Add a cross-journey navigation component at key points where paths might intersect:

```markdown
:::{card} Alternative Path
:class-card: journey-crossover

**Coming from Cloud?**

If you've already set up in the cloud and want to transition to bare metal, check out our [Cloud to Bare Metal Migration Guide](../cloud/migration.md).
:::
```

## Implementation Plan

1. **Create Journey Structure**: Set up the directory structure and TOC configuration
2. **Design Landing Page**: Create the main entry point with journey cards
3. **Develop Templates**: Create templates for journey steps to ensure consistency
4. **Implement First Path**: Start with one complete path (e.g., Bare Metal)
5. **Add Cross-References**: Implement cross-references between related content
6. **Enhance with Visuals**: Add diagrams, icons, and progress indicators
7. **Test User Experience**: Ensure the journey flows smoothly and is intuitive

## Example PR for rocm-docs-core

To enhance rocm-docs-core with journey support, consider a PR that adds:

1. **Journey Templates**: Pre-configured templates for journey steps
2. **CSS Components**: Styling for journey elements
3. **Sphinx Extensions**: Custom extensions for progress tracking

Here's a simplified example of what a PR might include:

```text
rocm-docs-core/
└── src/
    └── rocm_docs_core/
        ├── templates/
        │   ├── journey_landing.rst_t
        │   ├── journey_step.rst_t
        │   └── journey_complete.rst_t
        ├── static/
        │   └── css/
        │       └── journey.css
        └── extensions/
            └── journey_tracking.py
```

## Benefits of This Approach

1. **Maintains Compatibility**: Works with existing rocm-docs-core structure
2. **Scalable**: Can be expanded to include more journeys as needed
3. **Responsive**: Works well on different screen sizes
4. **Progressive**: Implements progressive disclosure principles
5. **Visual**: Uses visual elements to enhance understanding
6. **Interactive**: Includes interactive elements to engage users

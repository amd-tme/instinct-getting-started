# AMD Instinct Getting Started Guide

This documentation provides step-by-step guidance for getting started with AMD Instinct accelerators. Whether you're deploying on bare metal hardware or in the cloud, our journey-based approach will help you:

- Select the right AMD Instinct GPU for your workload
- Install and configure the ROCm software stack
- Set up your development environment
- Validate your installation and optimize performance

## Quick Start

Choose your deployment path:

- **[Bare Metal Journey](docs/journeys/bare-metal/)** - Deploy directly on your hardware for maximum performance and control
- **[Cloud Journey](docs/journeys/cloud/)** - Deploy in cloud environments for flexibility and scalability
- **[Software Ecosystem](docs/ecosystem/)** - Understand the full AMD Instinct software stack and how the pieces fit together

## What You'll Learn

### Software Ecosystem

- AMD components: ROCm Core SDK, GPU drivers, and Enterprise AI Suite
- Open source AI frameworks, inference engines, and training tools
- Third-party infrastructure (orchestration, monitoring, storage)
- [Example architectures](docs/ecosystem/reference-architectures/) showing how the stack composes for real use cases

### Bare Metal Deployment

- Hardware selection and system requirements
- ROCm installation and configuration
- Environment setup and multi-GPU configuration
- Performance validation and optimization techniques

### Cloud Deployment

- Cloud provider selection and comparison
- Instance provisioning and configuration
- Environment setup in cloud environments
- Integration with cloud-native services

## Prerequisites

- Basic familiarity with Linux command line
- Understanding of GPU computing concepts
- Administrative access to target deployment environment

## Getting Help

- **Documentation**: Full documentation is available at [your-docs-site-url]
- **Community**: Join the ROCm community for support and discussions
- **Issues**: Report documentation issues via GitHub Issues

## Contributing

We welcome contributions to improve this documentation. Please see our contributing guidelines for more information.

## Documentation Build Guide

This guide is for contributors who want to build or check the docs locally. The docs use [rocm-docs-core](https://github.com/ROCm/rocm-docs-core) as their base. A `Makefile` wraps all common tasks — run `make help` for a full target listing.

### Setup

Create and activate a Python virtual environment (recommended):

```bash
python3 -m venv .venv/docs
source .venv/docs/bin/activate      # Linux/macOS
# source .venv/docs/Scripts/activate  # Git Bash on Windows
# .venv\docs\Scripts\activate         # Command Prompt on Windows
```

Install required packages:

```bash
pip install -r docs/sphinx/requirements.txt
```

### Build

| Command | Output |
|---|---|
| `make html` | HTML site → `docs/_build/html/` |
| `make htmlzip` | HTML + zip archive → `docs/_build/htmlzip/` |
| `make pdf` | PDF via LaTeX + latexmk → `docs/_build/latex/` |
| `make epub` | EPUB → `docs/_build/epub/` |
| `make docx` | DOCX via pandoc → `docs/_build/docx/` |
| `make all` | All of the above |

Open `docs/_build/html/index.html` in a browser to preview, or serve locally:

```bash
python3 -m http.server -d docs/_build/html/
```

Then visit <http://localhost:8000>.

To treat Sphinx warnings as errors (CI-style):

```bash
make html SPHINXOPTS="-W --keep-going"
```

### Lint and Spellcheck

| Command | What it does |
|---|---|
| `make lint` | Run `markdownlint` against all `docs/**/*.md` files |
| `make lint-fix` | Auto-fix markdownlint issues where possible |
| `make spellcheck` | Run `pyspelling` using `.spellcheck.yaml` |
| `make linkcheck` | Check all external links for validity |

### Clean

```bash
make clean
```

Removes the `docs/_build/` directory.

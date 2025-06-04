# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Guidelines

### Types of Changes
- **Added** for new features
- **Changed** for changes in existing functionality
- **Deprecated** for soon-to-be removed features
- **Removed** for now removed features
- **Fixed** for any bug fixes
- **Security** for vulnerability fixes

### Contributing to the Changelog
- Keep an "Unreleased" section at the top for upcoming changes
- Add new entries under the appropriate type of change
- Include links to issues/PRs when applicable
- Write entries from the user's perspective
- Use present tense ("Add feature" not "Added feature")

---

## [Unreleased]

### Added
- Comprehensive cloud provider support in table of contents with dedicated subsections
- Cloud service responsibility model documentation explaining customer vs provider responsibilities
- AMD Docker Toolkit integration for simplified container deployment
- ROCm Validation Suite (RVS) dedicated section with stress testing guidance
- Kubernetes device plugin documentation with metrics exporter information
- Bare metal environment setup guide with comprehensive system configuration coverage
- Multi-GPU configuration guidance for bare metal deployments
- Container environment setup instructions for Docker and Podman on bare metal
- Framework integration guides for PyTorch and TensorFlow optimization on bare metal
- System-level optimization guidance including BIOS, NUMA, and power management configuration

### Changed
- Updated all examples to use `amd-smi` as the primary SMI and ROCm validation tool
- Improved document flow and readability by expanding bullet points into explanatory paragraphs
- Enhanced environment setup guide with better transitions between sections
- Reorganized cloud environment setup to lead with responsibility model
- Updated container runtime configuration to highlight AMD's simplified toolkit approach
- Expanded bare metal journey to include dedicated environment setup step between installation and validation
- Updated bare metal journey progression flow in all related documentation files

### Fixed
- Corrected misspelling in tensorwave documentation filename (reaadme.md → readme.md)
- Added missing hotaisle cloud provider documentation and table of contents entry

---

## [1.0.0] - 2025-06-03

### Added
- Initial release of AMD Instinct Getting Started documentation
- Cloud provider journey documentation
- Bare metal journey documentation
- Sphinx-based documentation system with custom theming
- Table of contents structure for organized navigation

### Documentation Structure
- Cloud journey: provider selection, provisioning, environment setup
- Bare metal journey: hardware selection, installation, validation, optimization
- Provider-specific guides for major cloud platforms
- Cross-references between related topics

---

## Links
- [Documentation Site](./docs/)
- [Cloud Journey](./docs/journeys/cloud/)
- [Bare Metal Journey](./docs/journeys/bare-metal/)

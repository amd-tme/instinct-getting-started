# Provider selection

## Choosing the Right Cloud Provider

The cloud ecosystem for AMD Instinct accelerators is rapidly expanding, offering diverse options from major hyperscalers to specialized GPU cloud providers. This guide helps you navigate the available choices and select the optimal provider for your specific workload requirements.

## Major Cloud Providers

### Microsoft Azure

Azure was the first major cloud provider to integrate AMD Instinct MI300X accelerators and offers enterprise-grade infrastructure with global reach.

**Key Features:**

- **ND MI300X v5 instances**: Optimized VM configurations with 8x MI300X accelerators
- **Global availability**: Multiple regions with planned expansion
- **Enterprise integration**: Seamless integration with Azure services and Microsoft ecosystem
- **Managed services**: Support for AKS (Azure Kubernetes Service) and other managed platforms

[Learn more about Azure deployment →](azure/)

### Oracle Cloud Infrastructure (OCI)

OCI offers some of the largest AMD GPU deployments with supercluster configurations supporting massive scale-out workloads.

**Key Features:**

- **Supercluster support**: Up to 16,384 MI300X GPUs in single fabric
- **Bare metal instances**: Direct hardware access with minimal virtualization overhead
- **High-performance networking**: Ultra-low latency interconnects for distributed training

[Learn more about OCI deployment →](oracle/)

## Specialized GPU Cloud Providers

### Hot Aisle

Hot Aisle is a specialized provider of high-performance bare metal compute solutions focused exclusively on AMD Instinct accelerators.

**Key Features:**

- **Deep AMD Expertise**: Specialized knowledge of ROCm and AMD software stack and extensive knowledge of Instinct architecture
- **Custom Architectures**: Tailored solutions for specific workload requirements
- **Future-Proof Designs**: Built for long-term scalability and performance growth

[Learn more about OCI deployment →](hotaisle/)

### Nscale

Nscale provides on-demand high-performance computing with advanced bare metal solutions based on AMD Instinct accelerators.

**Key Features:**

- **Bare metal focus**: Direct hardware access for maximum performance
- **Flexible configurations**: Various instance types and scaling options
- **Developer-friendly**: Easy provisioning and management interfaces
- **AMD specialization**: Deep expertise in AMD hardware optimization

[Learn more about Nscale deployment →](nscale/)

### TensorWave

TensorWave is building the world's largest AMD GPU clusters with a focus on AI-optimized infrastructure and services.

**Key Features:**

- **AMD-focused platform**: Specialized expertise in AMD Instinct deployments
- **Gigawatt-scale clusters**: Planning massive deployments of MI300X, MI325X, and MI350X
- **AI-optimized services**: Purpose-built for machine learning and AI workloads
- **Competitive pricing**: Often more cost-effective than major cloud providers

[Learn more about TensorWave deployment →](tensorwave/)

### Vultr

Vultr offers AMD Instinct MI300X GPUs for AI and ML workloads, designed to handle compute-intensive tasks efficiently.

**Key Features:**

- **GPUs Available**: AMD Instinct MI300X and MI325X accelerators
- **Deployment Options**: Available as either virtual machines or bare metal
- **Use Cases**: Ideal for AI/ML, deep learning, and high-performance computing

[Learn more about Vultr deployment →](vultr/)

### IBM Cloud

IBM Cloud is adding AMD Instinct MI300X GPUs to its platform in 2025, expanding enterprise options.

**Expected Features:**

- **Enterprise focus**: Integration with IBM's enterprise services and Watson AI
- **Hybrid cloud**: Strong hybrid and multi-cloud capabilities
- **Industry solutions**: Vertical-specific AI and analytics solutions

[Learn more about IBM Cloud →](ibmcloud/)

## Selection Criteria

### Performance Requirements

#### Memory-Intensive Workloads

- AMD Instinct GPUs offer superior memory capacity (192GB-256GB per GPU)
- Ideal for large language models and memory-bound applications
- Consider providers offering the latest MI325X with 256GB HBM3E

#### Compute-Intensive Applications

- Evaluate FP8, FP16, and FP32 performance specifications
- Consider mixed-precision capabilities for AI workloads
- Look for providers with optimized ROCm software stacks

#### Scale Requirements

- Single-node: All providers offer good single-node options
- Multi-node: OCI and TensorWave excel at large-scale deployments
- Global reach: Azure offers the broadest geographic coverage

### Cost Considerations

#### Pricing Models

- **On-demand**: Pay-per-hour for flexible workloads
- **Reserved instances**: Discounted rates for committed usage
- **Spot pricing**: Significant savings for interruptible workloads
- **Custom pricing**: Negotiate enterprise rates for large deployments

#### Total Cost of Ownership

- Consider data transfer costs for large datasets
- Evaluate storage costs for model artifacts and training data
- Factor in support and professional services costs
- Account for any required complementary services

## Migration Considerations

### Moving from Other GPU Platforms

- **CUDA to ROCm**: Consider migration complexity for existing CUDA code
- **Performance validation**: Test critical workloads before full migration
- **Training requirements**: Plan for team training on AMD tools and optimization

### Multi-Cloud Strategy

- **Vendor diversification**: Reduce dependency on single cloud provider
- **Cost optimization**: Leverage different providers for different workload types
- **Risk mitigation**: Ensure business continuity across multiple platforms

## Next Steps

1. **Assess your requirements** using the criteria above
2. **Review detailed provider guides** for your shortlisted options
3. **Test pilot workloads** with your preferred providers
4. **Negotiate pricing** for production deployments
5. **Plan deployment strategy** following our provisioning guides

## Additional Resources

- [AMD Cloud Partner Directory](https://www.amd.com/en/partner/cloud-partners)

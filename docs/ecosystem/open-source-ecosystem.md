# Open Source Ecosystem

Last reviewed: 2026-03-31

These components are developed by the open source community with AMD
contributing optimizations, CI/CD validation, and upstream support. They run on
ROCm without vendor lock-in.

[ROCm for AI](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/index.html) |
[AI Inference Frameworks](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/inference/index.html) |
[Developer Hub](https://www.amd.com/en/developer/resources/rocm-hub/dev-ai.html)

## AI frameworks

| Component | Role | ROCm integration |
|-----------|------|------------------|
| [PyTorch](https://pytorch.org/) | Primary training and inference framework | [Native ROCm support via HIP backend](https://rocm.docs.amd.com/en/latest/compatibility/ml-compatibility/pytorch-compatibility.html) |
| [TensorFlow](https://www.tensorflow.org/) | Training and inference framework | [ROCm-enabled builds available](https://rocm.docs.amd.com/en/latest/compatibility/ml-compatibility/tensorflow-compatibility.html) |
| [JAX](https://github.com/jax-ml/jax) | Functional ML framework | [ROCm support via OpenXLA](https://rocm.docs.amd.com/en/latest/compatibility/ml-compatibility/jax-compatibility.html) |
| [ONNX Runtime](https://onnxruntime.ai/) | Cross-platform inference | ROCm execution provider |

## LLM inference engines

| Component | Role | Notes |
|-----------|------|-------|
| [vLLM](https://docs.vllm.ai/) | High-throughput LLM serving | PagedAttention, continuous batching; validated on MI300X/MI325X — [ROCm guide](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/inference/benchmark-docker/vllm.html) |
| [SGLang](https://sgl-project.github.io/) | Efficient LLM/VLM serving | RadixAttention, optimized for AMD GPUs — [ROCm guide](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/inference/benchmark-docker/sglang.html) |
| [Triton Inference Server](https://github.com/triton-inference-server/server) | Multi-framework model serving | Supports concurrent model execution |
| [TGI (Text Generation Inference)](https://huggingface.co/docs/text-generation-inference/) | Hugging Face inference server | ROCm-compatible containers available — [ROCm guide](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/inference/llm-inference-frameworks.html) |
| [llama.cpp](https://github.com/ggerganov/llama.cpp) | Lightweight CPU/GPU inference | hipBLAS backend for AMD GPUs |

## Training and optimization

| Component | Role | ROCm docs |
|-----------|------|-----------|
| [DeepSpeed](https://www.deepspeed.ai/) | Distributed training (ZeRO, pipeline parallelism) | — |
| [Megatron-LM](https://github.com/NVIDIA/Megatron-LM) | Large-scale model training | [ROCm guide](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/training/benchmark-docker/megatron-lm.html) |
| [torchtitan](https://github.com/pytorch/torchtitan) | PyTorch-native large model training | — |
| [bitsandbytes](https://github.com/bitsandbytes-foundation/bitsandbytes) | 8-bit/4-bit quantization | [Quantization guide](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/inference-optimization/model-quantization.html) |
| [Hugging Face Transformers](https://huggingface.co/docs/transformers/) | Model hub, tokenizers, training utilities | [Running HF models on ROCm](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/inference/hugging-face-models.html) |
| [Hugging Face PEFT](https://huggingface.co/docs/peft/) | Parameter-efficient fine-tuning (LoRA, QLoRA) | [Fine-tuning guide](https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/fine-tuning/single-gpu-fine-tuning-and-inference.html) |

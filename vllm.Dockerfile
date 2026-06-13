FROM vllm/vllm-openai:v0.21.0

# Create user with UID 1000
RUN useradd -u 1000 -m -s /bin/bash vllmuser

# Create and set ownership for all necessary cache directories
RUN mkdir -p /home/vllmuser/.cache/huggingface \
             /home/vllmuser/.cache/vllm \
             /home/vllmuser/.vllm \
    && chown -R vllmuser:vllmuser /home/vllmuser/.cache /home/vllmuser/.vllm

# Ensure the root-level cache (used by some internal tools) is also writable
RUN mkdir -p /root/.cache/huggingface && chown -R vllmuser:vllmuser /root/.cache

# Switch to non-root user
USER vllmuser

# Set home explicitly
ENV HOME=/home/vllmuser

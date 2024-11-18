#!/usr/bin/env bash


# Install Fooocus if it is not already installed
if [ ! -d "/srv/bin/Fooocus" ]; then    
    echo "Cloning Fooocus repository ..."   
    cd /srv/bin
    git clone https://github.com/lllyasviel/Fooocus.git
    cd /srv/bin/Fooocus
    rm docker*
    rm rm Dockerfile  \  
    pip install --no-cache-dir -r requirements_versions.txt -r requirements_docker.txt
    sed -i '36s/default="127.0.0.1"/default="0.0.0.0"/' ldm_patched/modules/args_parser.py
    pip install onnxruntime-gpu

fi

# Download the additional files if they don't exist
if [ ! -f "/usr/local/lib/python3.10/dist-packages/gradio/frpc_linux_amd64_v0.2" ]; then
    echo "Downloading Gradio FRPC..."
    curl -fsL -o /usr/local/lib/python3.10/dist-packages/gradio/frpc_linux_amd64_v0.2 \
        https://cdn-media.huggingface.co/frpc-gradio-0.2/frpc_linux_amd64
    chmod +x /usr/local/lib/python3.10/dist-packages/gradio/frpc_linux_amd64_v0.2
fi

cd /srv/bin/Fooocus

python entry_with_update.py --always-low-vram --preset anime




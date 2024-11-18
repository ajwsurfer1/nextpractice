FROM nvidia/cuda:12.2.2-runtime-ubuntu22.04
#  update this to use the Nvidia software setup on your machine

# Set up environment variables
ENV PYTHONUNBUFFERED=1
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility

# Install required dependencies (for example Python, pip)
RUN apt-get update && apt-get install -y \
    python3-pip curl git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3.10 /usr/bin/python

WORKDIR /srv


# Copy the bash run script to the container
COPY run.sh /srv/run.sh
RUN chmod +x /srv/run.sh

# Expose the default port
EXPOSE 7865

# Install and run Fooocus using the run.sh CMD
CMD ["/srv/run.sh"]


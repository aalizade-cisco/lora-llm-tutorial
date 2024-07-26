# Base image
FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3.8 \
    python3-pip \
    git \
    wget \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set the environment variable for Anaconda
ENV PATH=/home/cisco/anaconda3/bin:$PATH

# Add a non-root user
RUN useradd -ms /bin/bash dockeruser

# Add the GAI Deployment Toolkit files
COPY . /workspace
WORKDIR /workspace

# Copy the requirements.txt and entrypoint.sh files
COPY requirements.txt /workspace/
COPY entrypoint.sh /workspace/entrypoint.sh

# Ensure the entrypoint script is executable
RUN chmod +x /workspace/entrypoint.sh

# Set permissions for the non-root user
RUN chown -R dockeruser:dockeruser /workspace

# Switch to the non-root user
USER dockeruser

# Set the entrypoint
ENTRYPOINT ["/workspace/entrypoint.sh"]

# Define the default command
CMD ["/bin/bash"]

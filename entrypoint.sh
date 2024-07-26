#!/bin/bash
# Create and activate conda environment
if [ ! -d "/home/cisco/anaconda3/envs/py38_test" ]; then
    /home/cisco/anaconda3/bin/conda create -n py38_test python=3.8 -y
fi

source /home/cisco/anaconda3/bin/activate py38_test

# Install Python packages if not already installed
pip install --user -r /workspace/requirements.txt

# Execute the provided command (default to bash)
exec "$@"

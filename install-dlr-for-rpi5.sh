#!/bin/sh
# id:				install-dlr-for-rpi5.sh
# author:			nicolas david - nicolas.david@anamor.ph
#
## version history:
# ----------------------------------------------------------------------------
#			v1.0	nicolas@	Initial Version
#
## purpose:
# ----------------------------------------------------------------------------
# This script will install pre-requisites and build DLR from source for
# Raspberry Pi 5 devices.
# 
## variables:
# ----------------------------------------------------------------------------
# updating & upgrading packages
sudo apt update && sudo apt upgrade -y
# fix PATH
export PATH=$PATH:/home/$(whoami)/.local/bin
# installing pip
sudo apt install git python3-pip python3-distutils build-essential cmake curl ca-certificates -y
# install additional packages
pip install numpy pillow tensorflow matplotlib --break-system-packages
# DLR
# 1. Getting DLR Sources
git clone --recursive https://github.com/neo-ai/neo-ai-dlr
cd neo-ai-dlr
# 2. Building DLR
mkdir build
cd build
cmake ..
# Use Raspberry pi's 4 cores to compile sources in parallel
make -j4
# 3. Installing DLR
cd ../python
python setup.py install
# 4. Testing DLR
cd ../tests/python/integration/
python load_and_run_tvm_model.py
python load_and_run_treelite_model.py
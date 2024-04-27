#!/usr/bin/env bash

set -e

echo "Installing nvtop ..."
sudo add-apt-repository -y ppa:flexiondotorg/nvtop
sudo apt update -y &&
    sudo apt install -y nvtop

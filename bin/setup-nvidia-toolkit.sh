#!/usr/bin/env bash

# https://docs.nvidia.com/cuda/cuda-installation-guide-linux/

set -e

cd "$(dirname "${0}")"

echo "Showing NVIDIA GPUs ..."
lspci | grep -i nvidia

echo "Showing linux distro ..."
uname -m && cat /etc/*release

echo "Checking for GCC ..."
gcc --version

echo "Showing kernel version ..."
uname -r

echo "Installing linux headers ..."
sudo apt-get update -y
sudo apt-get install -y linux-headers-$(uname -r)
sudo apt-key del 7fa2af80

distro="ubuntu$(lsb_release -rs | tr -d '.')"
echo "Found distro: $distro"
arch="$(uname -m)"
echo "Found arch: $arch"

echo "Installing CUDA toolkit ..."
wget https://developer.download.nvidia.com/compute/cuda/repos/$distro/$arch/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update -y
sudo apt-get install -y cuda-toolkit
sudo apt-get install -y nvidia-gds
sudo apt install -y \
    nvidia-driver-545 \
    nvidia-dkms-545
rm cuda-keyring_1.1-1_all.deb

echo 'set -x PATH /usr/local/cuda/bin $PATH' >>~/.config/fish/config.fish
echo 'set -x LD_LIBRARY_PATH /usr/local/cuda/lib64 $LD_LIBRARY_PATH' >>~/.config/fish/config.fish

echo "Installing cudnn ..."
sudo apt-get install -y \
    libcudnn8 \
    libcudnn8-dev \
    libcudnn8-samples

./setup-gpu-tools.sh

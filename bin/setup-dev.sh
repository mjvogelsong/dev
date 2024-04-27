#/usr/bin/env bash

set -e

cd "$(dirname "${0}")"

export DEBIAN_FRONTEND=noninteractive

mkdir -p ~/.config/fish && touch ~/.config/fish/config.fish

echo "Updating system ..."
sudo apt update && sudo apt upgrade -y

echo "Installing dev basics ..."
sudo apt install -y \
    tmux \
    curl \
    git

echo "Installing python stuff ..."
./setup-python.sh

echo "Installing fish shell ..."
if ! type fish >/dev/null 2>&1; then
    sudo apt-add-repository -y ppa:fish-shell/release-3 &&
        sudo apt update &&
        sudo apt install -y -qq fish
fi
fish --version

echo "Setting up fish shell ..."
./setup-fish.sh

echo "Setting up workplace ..."
mkdir -p ~/workplace

echo "Setting up vim ..."
echo "syntax on" >>~/.vimrc
echo "colorscheme desert" >>~/.vimrc

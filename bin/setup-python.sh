#!/usr/bin/env bash

# Exit on errors
set -e

# Versions
PYTHON_VERSION="3.11.9"
POETRY_VERSION="1.8.2"

# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
echo "Installing dependencies for python ..."
sudo apt update -y &&
    sudo apt install -y \
        build-essential \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev curl \
        libncursesw5-dev \
        xz-utils \
        tk-dev \
        libxml2-dev \
        libxmlsec1-dev \
        libffi-dev \
        liblzma-dev

# https://github.com/pyenv/pyenv?tab=readme-ov-file#automatic-installer
echo "Installing pyenv ..."
if ! command -v pyenv &>/dev/null; then
    if [ -d "$HOME/.pyenv" ]; then
        echo "Removing existing pyenv installation..."
        rm -rf $HOME/.pyenv
    fi
    curl https://pyenv.run | bash
fi

if ! grep -q '# Managing Python' ~/.config/fish/config.fish; then
    echo '# Managing Python' >>~/.config/fish/config.fish
    echo 'set -x PYENV_ROOT $HOME/.pyenv' >>~/.config/fish/config.fish
    echo 'contains $PYENV_ROOT/bin $PATH; or set -x PATH $PYENV_ROOT/bin $PATH' >>~/.config/fish/config.fish
    echo 'pyenv init - | source' >>~/.config/fish/config.fish
fi

# Enable pyenv
export PYENV_ROOT="$HOME/.pyenv"
if [[ ! $PATH == *$PYENV_ROOT/bin* ]]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
fi
eval "$(pyenv init -)"

pyenv --version
pyenv update
echo "Available python versions:"
pyenv versions

if ! pyenv versions | grep -q $PYTHON_VERSION; then
    echo "Installing python $PYTHON_VERSION ..."
    pyenv install $PYTHON_VERSION
fi
pyenv global $PYTHON_VERSION
pyenv local $PYTHON_VERSION
python --version

echo "Installing pipx ..."
if ! command -v pipx &>/dev/null; then
    python -m pip install --upgrade pip
    python -m pip install --user pipx
    python -m pipx ensurepath
    if ! command -v pipx &>/dev/null; then
        export PATH="$HOME/.local/bin:$PATH"
    fi
fi
pipx --version

# https://pipx.pypa.io/stable/
echo "Installing poetry ..."
pipx install poetry==$POETRY_VERSION
poetry --version
poetry config virtualenvs.in-project true

# https://github.com/aristocratos/bpytop
echo "Installing bpytop ..."
pipx install bpytop

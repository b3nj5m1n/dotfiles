#!/usr/bin/env sh

plugin_dir="/home/$USER/.local/share/nvim/site/pack/packer/start"

packer_dir="$plugin_dir/packer.nvim"
if [ -d "$packer_dir" ]; then
    echo "Packer seems to be installed, skipping."
else
    echo "Installing packer..."
    git clone https://github.com/wbthomason/packer.nvim "$packer_dir"
fi

aniseed_dir="$plugin_dir/aniseed"
if [ -d "$aniseed_dir" ]; then
    echo "Aniseed seems to be installed, skipping."
else
    echo "Installing aniseed..."
    git clone https://github.com/Olical/aniseed "$aniseed_dir"
fi

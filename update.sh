#!/bin/bash

# Get args in an array
args=("$@")

# Display help
match="-h"
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then    
    echo '-h            Display help'
    echo '-p            Install/Update packages'
    echo '--nerd-fonts  Install nerd fonts'
    exit 0
fi


# Store current dir to go back to later
DOTFILES_DIR=$PWD

# Ensure github directory exists in documents dir
mkdir -p ~/Documents/Github
# Cd into github dir
cd ~/Documents/Github

# Only do this if argument -p is given
match="-p"
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then    
    # Package installation
    if hash apt 2>/dev/null; then
        # Using apt

        # Essential
        apt install --yes sudo
        apt install --yes git

        # Dev
        apt install --yes vim
        apt install --yes neovim
    elif hash pacman 2>/dev/null; then
        # Using pacman

        # Essential
        pacman -S --noconfirm sudo
        pacman -S --noconfirm git
        pacman -S --noconfirm makepkg
        if hash yay 2>/dev/null; then
            mkdir -p ~/Documents/Github
            git clone https://aur.archlinux.org/yay.git
            cd yay
            makepkg -si
            mkdir -p ~/Documents/Github
        fi

        # Dev
        pacman -S --noconfirm vim
        pacman -S --noconfirm neovim
    fi
fi

# Needs not to be run as root
if [ ! "$EUID" -ne 0 ]
  then echo "The next part of this script requires you to run without sudo to copy to the correct dirs."
  exit
fi

# Update .files
cd "$DOTFILES_DIR"
# Update .bashrc
cp -f -p -v ./bash/.bashrc ~/
# Update konsole
cp -f -p -v -r ./konsole/* ~/.local/share/konsole/
# Update .vimrc (vim)
cp -f -p -v ./vim/.vimrc ~/
# Update .init.vim (neovim) (And make sure the dir exists)
mkdir -p ~/.config/nvim/
cp -f -p -v ./vim/init.vim ~/.config/nvim/init.vim

# Make sure vim plug is installed for vim
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
# Make sure vim plug is installed for neovim
if [ ! -f  ~/.local/share/nvim/site/autoload/plug.vim ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

match="--nerd-fonts"
# Only do this if argument --nerd-fonts is supplied
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then    
    # Install Nerd Font
    # Go back to Github dir
    cd ~/Documents/Github
    # Clone nerd font repo, this might take a while
    git clone --depth 1 "https://github.com/ryanoasis/nerd-fonts.git"
    # Move to nerd-fonts dir
    cd ~/Documents/Github/nerd-fonts/
    # Install Ubuntu and Ubuntu Mono fonts
    ./install.sh UbuntuMono
fi

# Go back to Github dir
cd ~/Documents/Github

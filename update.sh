#!/bin/bash

# Get args in an array
args=("$@")

# Display help
match="-h"
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then    
    echo '-u            Update all config files'
    echo '-h            Display help'
    echo '-p            Install/Update packages'
    echo '--yay         Install yay'
    echo '--ycp         Install You Complete Me'
    echo '--nerd-fonts  Install nerd fonts'
    exit 0
fi


# Store current dir to go back to later
DOTFILES_DIR=$PWD

# Ensure github directory exists in documents dir
mkdir -p ~/Documents/Github
# Cd into github dir
cd ~/Documents/Github

# Only do this if argument --yay is given
match="--yay"
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then    
    if ! hash yay 2>/dev/null; then
        mkdir -p ~/Documents/Github
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si
        mkdir -p ~/Documents/Github
    fi
fi

# Only do this if argument -p is given
match="-p"
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then    
    # Package installation
    if hash apt 2>/dev/null; then
        # Using apt

        # Essential
        apt install --yes sudo
        apt install --yes git
        apt install --yes python
        apt install --yes python3
        apt install --yes make
        apt install --yes cmake
        apt install --yes curl
        apt install --yes wget

        # Dev
        apt install --yes vim
        apt install --yes neovim
        apt install --yes python3-pip
        apt install --yes python-pip
    elif hash pacman 2>/dev/null; then
        # Using pacman

        # Update
        pacman -Syy
        # Essential
        pacman -S --noconfirm --needed sudo
        pacman -S --noconfirm --needed git
        pacman -S --noconfirm --needed makepkg
        pacman -S --noconfirm --needed curl
        pacman -S --noconfirm --needed wget
        pacman -S --noconfirm --needed python
        pacman -S --noconfirm --needed python2
        pacman -S --noconfirm --needed make
        pacman -S --noconfirm --needed cmake
        pacman -S --noconfirm --needed binutils
        pacman -S --noconfirm --needed gcc
        pacman -S --noconfirm --needed pkg-config
        pacman -S --noconfirm --needed fakeroot

        # Dev
        pacman -S --noconfirm vim
        pacman -S --noconfirm neovim
        pacman -S --noconfirm --needed python2-pip
        pacman -S --noconfirm --needed python-pip

        # Upgrade all packs
        pacman -Syu
    fi
    # Use pip to install neovim to enable python support
    pip install --no-cache neovim
    pip3 install --no-cache neovim
fi



match="-u"
# Only do this if argument --nerd-fonts is supplied
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then    
    # Needs not to be run as root
    if [ ! "$EUID" -ne 0 ]
    then echo "The next part of this script requires you to run without sudo to copy to the correct dirs."
        exit
    fi

    # Update .files
    cd "$DOTFILES_DIR"
    # Update .bashrc
    cp -f -p -v ./bash/.bashrc ~/
    # Update i3 config file
    cp -f -p -v ./i3/config ~/.config/i3
    # Update konsole
    cp -f -p -v -r ./konsole/* ~/.local/share/konsole/
    # Update .vimrc (vim)
    cp -f -p -v ./vim/.vimrc ~/
    # Copy .vimrc to init.vim (Use the same file for both vim and nvim
    cp -f -p -v ./vim/.vimrc ./vim/init.vim
    # Update init.vim (neovim) (And make sure the dir exists)
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

    # Update wallpapers
    mkdir -p ~/.wallpapers/
    cp -u -f -p -v ./wallpapers/* ~/.wallpapers/
fi

match="--ycp"
# Only do this if argument --ycp is supplied
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then    
    # Make sure YouCompleteMe is installed
    python ~/.vim/plugged/YouCompleteMe/install.py
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

#!/bin/bash

# Get args in an array
args=("$@")

# Display help
match="-h"
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then    
    echo 'This script helps me sync my linux installs'
    echo ''
    echo ''
    figlet -f slant "Currently at $(git rev-list --count HEAD) commits" | lolcat
    echo ''
    echo ''
    echo '-u            Update all config files'
    echo '-h            Display help'
    echo '-p            Install/Update packages'
    echo '--pp          Install/Update non essential packages'
    echo '--yay         Install yay'
    echo '--lightdm     Install lightdm'
    echo '--i3          Install i3 gaps and picom'
    echo '--ycp         Install You Complete Me'
    echo '--nerd-fonts  Install nerd fonts'
    exit 0
fi


# Store current dir to go back to later
DOTFILES_DIR=$PWD
# Get dir of script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# Get the user dir
USER=/home/$(echo $DIR | cut -d/ -f3)
echo $USER

# Ensure root
if [ "$EUID" -ne 0 ]
then echo "Please run this script as root"
    exit
fi

# Ensure github directory exists in documents dir
mkdir -p $USER/Documents/Github
# Cd into github dir
cd $USER/Documents/Github

# Only do this if argument --yay is given
match="--yay"
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then    
    if ! hash yay 2>/dev/null; then
        mkdir -p $USER/Documents/Github
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si
        mkdir -p $USER/Documents/Github
    fi
fi

# Only do this if argument -p is given
match="-p"
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then    
    # Package installation
    if hash apt 2>/dev/null; then
        # Using apt
        apt-get update -y
        apt-get upgrade -y
        # Essential
        apt install --yes sudo
        apt install --yes git
        apt install --yes python
        apt install --yes python3
        apt install --yes make
        apt install --yes cmake
        apt install --yes curl
        apt install --yes wget
        apt install --yes autoconf
        apt install --yes automake
        apt install --yes ninja-build

        # Dev
        apt install --yes vim
        apt install --yes neovim
        apt install --yes python3-pip
        apt install --yes python-pip
        apt install --yes cargo

        # Other
        apt install --yes vlc
        apt install --yes libreoffice
        apt install --yes ffmpeg
        apt install --yes playerctl
        apt install --yes amixer
        apt install --yes cmus
        apt install --yes polybar
        apt install --yes imagemagick
        apt install --yes xdotool

        # Only do this if argument --pp is given
        match="--pp"
        if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then    
            apt install --yes deepin-calculator
            apt install --yes mc
            apt install --yes vifm
            apt install --yes cmatrix
            apt install --yes figlet
            apt install --yes lolcat
            apt install --yes tty-clock
            apt insatll --yes libaa-bin
            apt install --yes bb
            # Install cli-visualizer
            cd $USER/Documents/Github
            git clone "https://github.com/dpayne/cli-visualizer.git"
            cd cli-visualizer
            ./install.sh
            cargo install viu
        fi

        # Only do this if argument --lightdm is given
        match="--lightdm"
        if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then    
            apt install --yes lightdm
            apt install --yes lightdm-gtk-greeter
        fi

        # Only do this if argument --i3 is given
        match="--i3"
        if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then    
            add-apt-repository ppa:regolith-linux/stable -y
            apt-get update
            apt install --yes libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev xutils-dev libxcb-shape0-dev autoconf
            apt install --yes libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev  libpcre2-dev  libevdev-dev uthash-dev libev-dev libx11-xcb-dev
            # apt install --yes i3
            apt install --yes i3-gaps-wm i3-gaps-session
            apt install --yes i3-gaps
            # Install i3 util
            apt install --yes i3bar
            apt install --yes i3blocks
            apt install --yes i3lock
            apt install --yes dmenu
            apt install --yes rofi
            apt install --yes feh
            # Install picom
            cd /tmp/
            git clone "https://github.com/yshui/picom.git" 
            cd picom
            meson --buildtype=release . build
            ninja -C build install
        fi


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
        pacman -S --noconfirm --needed autoconf
        pacman -S --noconfirm --needed automake
        pacman -S --noconfirm --needed ninja

        # Dev
        pacman -S --noconfirm vim
        pacman -S --noconfirm neovim
        pacman -S --noconfirm --needed python2-pip
        pacman -S --noconfirm --needed python-pip
        pacman -S --noconfirm --needed xclip

        # Other
        pacman -S --noconfirm --needed vlc
        pacman -S --noconfirm --needed libreoffice-still
        pacman -S --noconfirm --needed ffmpeg
        pacman -S --noconfirm --needed playerctl
        pacman -S --noconfirm --needed alsa-utils
        pacman -S --noconfirm --needed cmus
        pacman -S --noconfirm --needed alacritty
        pacman -S --noconfirm --needed youtube-dl


        match="--lightdm"
        # Only do this if argument --lightdm is supplied
        if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then
            pacman -S --noconfirm --needed lightdm
            pacman -S --noconfirm --needed lightdm-gtk-greeter
            pacman -S --noconfirm --needed lightdm-webkit2-greeter
        fi

        match="--pp"
        # Only do this if argument --pp is supplied
        if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then    
            pacman -S --noconfirm --needed deepin-calculator
            pacman -S --noconfirm --needed mc
            pacman -S --noconfirm --needed vifm
            pacman -s --noconfirm --needed cmatrix
            pacman -S --noconfirm --needed figlet
            pacman -S --noconfirm --needed lolcat
            yay -S cli-visualizer
            yay -S no-more-secrets-git
        fi

        match="--i3"
        # Only do this if argument --i3 is supplied
        if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then    
            pacman -S --noconfirm --needed i3-gaps
            pacman -S --noconfirm --needed i3blocks
            pacman -S --noconfirm --needed i3status
            pacman -S --noconfirm --needed i3lock
            pacman -S --noconfirm --needed dmenu
            pacman -S --noconfirm --needed rofi
            pacman -S --noconfirm --needed feh
            pacman -S --noconfirm --needed picom
        fi

        # Upgrade all packs
        pacman -Syu
    fi
    # Use pip to install neovim to enable python support
    pip install --no-cache neovim
    pip3 install --no-cache neovim
fi


match="--lightdm"
# Only do this if argument --lightdm is supplied
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then
    systemctl disable sddm
    systemctl disable gdm
    systemctl enable lightdm
fi



match="-u"
# Only do this if argument --nerd-fonts is supplied
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then    
    # Update .files
    cd "$DOTFILES_DIR"
    # Update .bashrc
    cp -f -p -v ./bash/.bashrc $USER/
    # Update lightdm config files
    cp -r -r -f -p -v ./lightdm/* /etc/lightdm/
    # Update i3 config file
    cp -f -p -v ./i3/config $USER/.config/i3
    # Update gtk 2 & 4 config files
    cp -f -p -v ./gtk/.gtkrc-2.0 $USER/
    cp -f -p -v ./gtk/settings.ini $USER/.config/gtk-3.0/
    # Update gtk themes
    cp -r -u -f -p -v ./.themes/* $USER/.themes/
    # Update picom config file
    cp -f -p -v ./picom/picom.conf $USER/.config/
    # Update alacritty
    mkdir -p $USER/.config/alacritty/
    cp -f -p -v -r ./alacritty/alacritty.yml $USER/.config/alacritty/
    # Update konsole
    cp -f -p -v -r ./konsole/* $USER/.local/share/konsole/
    # Update .vimrc (vim)
    cp -f -p -v ./vim/.vimrc $USER/
    # Copy .vimrc to init.vim (Use the same file for both vim and nvim
    cp -f -p -v ./vim/.vimrc $USER/.config/nvim/init.vim
    # Copy vim airline theme
    cp -f -p -v ./vim/pinky_airline.vim $USER/.vim/plugged/vim-airline-themes/autoload/airline/themes/
    # Copy icons
    cp -r -u -f -p -v ./icons/* $USER/.local/share/icons/
    # Update init.vim (neovim) (And make sure the dir exists)
    mkdir -p $USER/.config/nvim/
    cp -f -p -v ./vim/init.vim $USER/.config/nvim/init.vim
    # Update polybar
    mkdir -p $USER/.config/polybar/
    cp -r -u -f -p -v ./polybar/* $USER/.config/polybar/
    # Update polybar script
    cp -f -p -v ./scripts/polybar.sh $USER/.config/polybar/
    # Update polybar scripts
    mkdir $USER/.config/polybar/scripts/
    cp -a -u -f -v ./scripts/polybar/* $USER/.config/polybar/scripts/
    # Update cmus config
    cp -f -p -v ./cmus/* $USER/.config/cmus/
    # Update cli-visualizer config
    cp -r -u -f -p -v ./cli-visualizer/* $USER/.config/vis/

    # Update i3 lock script
    cp -f -p -v ./scripts/lock.sh $USER/
    # Update anki config
    if [ -d /usr/local/share/anki/bin/aqt_data/web/ ]; then
        cp -r -u -f -p -v ./anki/bin/aqt_data/web/* /usr/local/share/anki/bin/aqt_data/web/
    fi
    if [ -d /usr/share/aqt_data/web/ ]; then
        cp -r -u -f -p -v ./anki/bin/aqt_data/web/* /usr/share/aqt_data/web/
    fi
    # Update anki addons
    cp -r -u -f -p -v ./Anki2/* $USER/.local/share/Anki2/


    # Make sure vim plug is installed for vim
    if [ ! -f $USER/.vim/autoload/plug.vim ]; then
        curl -fLo $USER/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
    # Make sure vim plug is installed for neovim
    if [ ! -f  $USER/.local/share/nvim/site/autoload/plug.vim ]; then
        curl -fLo $USER/.local/share/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    # Update wallpapers
    mkdir -p /usr/share/wallpapers
    cp -r -u -f -p -v ./wallpapers/* /usr/share/wallpapers
    # Update lock pic
    cp -u -f -p -v ./assets/lock.png $USER/
fi

match="--ycp"
# Only do this if argument --ycp is supplied
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then    
    # Make sure YouCompleteMe is installed
    python $USER/.vim/plugged/YouCompleteMe/install.py
fi

match="--nerd-fonts"
# Only do this if argument --nerd-fonts is supplied
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then    
    # Install Nerd Font
    # Go back to Github dir
    cd $USER/Documents/Github
    # Clone nerd font repo, this might take a while
    git clone --depth 1 "https://github.com/ryanoasis/nerd-fonts.git"
    # Move to nerd-fonts dir
    cd $USER/Documents/Github/nerd-fonts/
    # Install Ubuntu and Ubuntu Mono fonts
    ./install.sh UbuntuMono
fi

# Go back to Github dir
cd $USER/Documents/Github

#!/bin/bash

# Get args in array
args=("$@")

# Get user dir
USER=/home/$(echo $DIR | cut -d/ -f3)

######################## Packages ########################
declare -A pac0=(
    [apt]='sudo'
    [pacman]='sudo'
    [tag]='essential'
)
declare -A pac1=(
    [apt]='git'
    [pacman]='git'
    [tag]='essential'
)
declare -A pac2=(
    [pacman]='makepkg'
    [tag]='essential'
)
declare -A pac3=(
    [apt]='curl'
    [pacman]='curl'
    [tag]='essential'
)
declare -A pac4=(
    [apt]='wget'
    [pacman]='wget'
    [tag]='essential'
)
declare -A pac5=(
    [apt]='python'
    [pacman]='python2'
    [tag]='essential'
)
declare -A pac6=(
    [apt]='python3'
    [pacman]='python'
    [tag]='essential'
)
declare -A pac7=(
    [apt]='make'
    [pacman]='make'
    [tag]='essential'
)
declare -A pac8=(
    [apt]='cmake'
    [pacman]='cmake'
    [tag]='essential'
)
declare -A pac9=(
    [pacman]='binutils'
    [tag]='essential'
)
declare -A pac10=(
    [pacman]='gcc'
    [tag]='essential'
)
declare -A pac11=(
    [pacman]='pkg-config'
    [tag]='essential'
)
declare -A pac12=(
    [pacman]='fakeroot'
    [tag]='essential'
)
declare -A pac13=(
    [apt]='autoconf'
    [pacman]='autoconf'
    [tag]='essential'
)
declare -A pac14=(
    [apt]='automake'
    [pacman]='automake'
    [tag]='essential'
)
declare -A pac15=(
    [apt]='ninja-build'
    [pacman]='ninja'
    [tag]='essential'
)
declare -A pac16=(
    [apt]='fish'
    [pacman]='fish'
    [tag]='essential'
)
declare -A pac17=(
    [apt]='vim'
    [pacman]='vim'
    [tag]='dev'
)
declare -A pac18=(
    [apt]='neovim'
    [pacman]='neovim'
    [tag]='dev'
)
declare -A pac19=(
    [apt]='python3-pip'
    [pacman]='python-pip'
    [tag]='dev'
)
declare -A pac20=(
    [apt]='python-pip'
    [pacman]='python2-pip'
    [tag]='dev'
)
declare -A pac21=(
    [apt]='xclip'
    [pacman]='xclip'
    [tag]='dev'
)
declare -A pac22=(
    [apt]='cargo'
    [pacman]='cargo'
    [tag]='dev'
)
declare -A pac23=(
    [apt]='vlc'
    [pacman]='vlc'
    [tag]='other'
)
declare -A pac24=(
    [apt]='libreoffice'
    [pacman]='libreoffice-still'
    [tag]='other'
)
declare -A pac25=(
    [apt]='ffmpeg'
    [pacman]='ffmpeg'
    [tag]='other'
)
declare -A pac26=(
    [apt]='playerctl'
    [pacman]='playerctl'
    [tag]='other'
)
declare -A pac27=(
    [apt]='amixer'
    [pacman]='alsa-utils'
    [tag]='other'
)
declare -A pac28=(
    [apt]='cmus'
    [pacman]='cmus'
    [tag]='other'
)
declare -A pac29=(
    [apt]='alacritty'
    [pacman]='alacritty'
    [tag]='other'
)
declare -A pac30=(
    [apt]='youtube-dl'
    [pacman]='youtube-dl'
    [tag]='other'
)
declare -A pac31=(
    [yay]='polybar'
    [tag]='other'
)
declare -A pac32=(
    [apt]='imagemagick'
    [pacman]='imagemagick'
    [tag]='other'
)
declare -A pac33=(
    [apt]='xdotool'
    [pacman]='xdotool'
    [tag]='other'
)
declare -A pac34=(
    [apt]='deepin-calculator'
    [pacman]='deepin-calculator'
    [tag]='fluff'
)
declare -A pac35=(
    [apt]='mc'
    [pacman]='mc'
    [tag]='fluff'
)
declare -A pac36=(
    [apt]='vifm'
    [pacman]='vifm'
    [tag]='fluff'
)
declare -A pac37=(
    [apt]='cmatrix'
    [pacman]='cmatrix'
    [tag]='fluff'
)
declare -A pac38=(
    [apt]='figlet'
    [pacman]='figlet'
    [tag]='fluff'
)
declare -A pac39=(
    [apt]='lolcat'
    [pacman]='lolcat'
    [tag]='fluff'
)
declare -A pac40=(
    [apt]='tty-clock'
    [yay]='tty-clock'
    [tag]='fluff'
)
declare -A pac41=(
    [apt]='libaa-bin'
    [tag]='fluff'
)
declare -A pac42=(
    [apt]='bb'
    [tag]='fluff'
)
declare -A pac43=(
    [apt]='lightdm'
    [pacman]='lightdm'
    [tag]='lightdm'
)
declare -A pac44=(
    [apt]='lightdm-webkit2-greeter'
    [pacman]='lightdm-webkit2-greeter'
    [tag]='lightdm'
)
declare -A pac45=(
    [apt]='lightdm-gtk-greeter'
    [pacman]='lightdm-gtk-greeter'
    [tag]='lightdm'
)
declare -A pac46=(
    [apt]='i3-gaps'
    [pacman]='i3-gaps'
    [tag]='i3'
)
declare -A pac47=(
    [apt]='i3-gaps-wm'
    [pacman]=''
    [tag]='i3'
)
declare -A pac48=(
    [apt]='i3-gaps-session'
    [pacman]=''
    [tag]='i3'
)
declare -A pac49=(
    [apt]='i3blocks'
    [pacman]=''
    [tag]='i3'
)
declare -A pac50=(
    [apt]='i3lock'
    [pacman]=''
    [tag]='i3'
)
declare -A pac51=(
    [apt]='dmenu'
    [pacman]='dmenu'
    [tag]='i3'
)
declare -A pac52=(
    [apt]='rofi'
    [pacman]='rofi'
    [tag]='i3'
)
declare -A pac53=(
    [apt]='feh'
    [pacman]='feh'
    [tag]='i3'
)
declare -A pac54=(
    [pacman]='picom'
    [tag]='i3'
)
declare -A pac55=(
    [apt]='libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-util0-dev libxcb-icccm4-dev libxcb-xfixes0-dev libxcb-shape0-dev libyajl-dev libstartup-notification0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-glx0-dev libxkbcommon-dev libxkbcommon-x11-dev libpixman-1-dev libdbus-1-dev libconfig-dev xutils-dev libxcb-shape0-dev autocon flibgl1-mesa-dev  libpcre2-dev  libevdev-dev uthash-dev libev-dev libx11-xcb-dev'
    [pacman]='placeholder'
    [tag]='i3'
)
declare -A pac56=(
    [pip]='neovim'
    [pip3]='neovim'
    [tag]='dev'
)
declare -A pac57=(
    [apt]='tmux'
    [pacman]='tmux'
    [tag]='dev'
)
declare -A pac58=(
    [yay]='cli-visualizer'
    [tag]='fluff'
)
declare -A pac57=(
    [apt]='lxqt-notificationd'
    [pacman]=''
    [tag]='i3'
)
declare -A pac58=(
    [apt]='syncthing'
    [pacman]='syncthing'
    [tag]='i3'
)
declare -A pac59=(
    [apt]='dunst'
    [pacman]=''
    [tag]='i3'
)
declare -A pac60=(
    [apt]='ruby-dev'
    [pacman]=''
    [tag]='vim'
)
declare -A pac61=(
    [gem]='neovim'
    [tag]='vim'
)
declare -A pac62=(
    [npm]='neovim'
    [tag]='vim'
)
declare -A pac63=(
    [apt]='sxhkd'
    [tag]='essential'
)
declare -A pac64=(
    [apt]='ranger'
    [tag]='essential'
)


######################## Codes ########################

RED='\033[0;31m'
GREEN='\033[0;32m'
PURPLE='\033[1;35m'
YELLOW='\033[0;33m'
GRAY='\033[0;90m'
REVERSE='\033[7m'
RESET='\033[0m'


######################## Auto Install ########################
# Get installed package manager
pacmgr=""
suffix=""
if hash apt 2>/dev/null; then
    pacmgr="apt"
    suffix=" install --yes "
elif hash pacman 2>/dev/null; then
    pacmgr="pacman"
    suffix=" -S --noconfirm --needed "
fi

declare -n pac
for pac in ${!pac@}; do
    printf "${RESET}${YELLOW}Installing/Updating ${PURPLE}${REVERSE}${pac[$pacmgr]}${RESET}${YELLOW} using package manager $pacmgr"
    printf "${RESET}\n${GRAY}"
    $pacmgr$suffix${pac[$pacmgr]}
    if [ $? -eq 0 ]; then
        printf "${GREEN} OK"
    else
        printf "${RED} ERROR"
    fi
    printf "\n"
done


# ######################## Manual Install ########################

match="--yay"
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then
    # Yay
    mkdir -p $USER/Documents/Github
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    mkdir -p $USER/Documents/Github
fi
match="--picom"
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then
    # picom
    cd /tmp/
    git clone "https://github.com/yshui/picom.git"
    cd picom
    meson --buildtype=release . build
    ninja -C build install
fi
match="--omf"
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then
    # Oh My Fish
    curl -L https://get.oh-my.fish | fish
fi
match="--cli-visualizer"
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then
    # cli-visualizer
    cd $USER/Documents/Github
    git clone "https://github.com/dpayne/cli-visualizer.git"
    cd cli-visualizer
    ./install.sh
    cargo install viu
fi
match="--vim-plug"
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then
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
fi


######################### Configs ########################

match="--set-fish"
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then
    chsh -s /usr/bin/fish
fi



#!/bin/bash

# This script copys my dotfiles into the bay directory while creating the correct directory structure

# DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# USER=/home/$(echo $DIR | cut -d/ -f3)
USER="/home/b3nj4m1n"

declare -A loc1=(
    [name]="lightdm"
    [local]="/home/b3nj4m1n/dotfiles/files/lightdm/*"
    [remote]="/etc/lightdm/"
)
declare -A loc2=(
    [name]="gtk2"
    [local]="/home/b3nj4m1n/dotfiles/files/gtk/.gtkrc-2.0"
    [remote]="$USER/"
)
declare -A loc3=(
    [name]="gtk3"
    [local]="/home/b3nj4m1n/dotfiles/files/gtk/settings.ini"
    [remote]="$USER/.config/gtk-3.0/"
)
declare -A loc5=(
    [name]="picom"
    [local]="/home/b3nj4m1n/dotfiles/files/picom/picom.conf"
    [remote]="$USER/.config/"
)
declare -A loc7=(
    [name]="alacritty"
    [local]="/home/b3nj4m1n/dotfiles/files/alacritty/alacritty.yml"
    [remote]="$USER/.config/alacritty/"
)
declare -A loc10=(
    [name]="neovim config"
    [local]="/home/b3nj4m1n/dotfiles/files/nvim/*"
    [remote]="$USER/.config/nvim/"
)
declare -A loc11=(
    [name]="pinky vim airline theme"
    [local]="/home/b3nj4m1n/dotfiles/files/vim/pinky_airline.vim"
    [remote]="$USER/.config/nvim/autoload/plugged/vim-airline-themes/autoload/airline/themes/"
)
declare -A loc15=(
    [name]="cmus"
    [local]="/home/b3nj4m1n/dotfiles/files/cmus/*"
    [remote]="$USER/.config/cmus/"
)
declare -A loc16=(
    [name]="cli-visualizer"
    [local]="/home/b3nj4m1n/dotfiles/files/cli-visualizer/*"
    [remote]="$USER/.config/vis/"
)
declare -A loc25=(
    [name]="Hotkey daemon"
    [local]="/home/b3nj4m1n/dotfiles/files/sxhkd/*"
    [remote]="$USER/.config/sxhkd/"
)
declare -A loc28=(
    [name]="bspwm config"
    [local]="/home/b3nj4m1n/dotfiles/files/bspwm/*"
    [remote]="$USER/.config/bspwm/"
)
declare -A loc29=(
    [name]="dunst config"
    [local]="/home/b3nj4m1n/dotfiles/files/dunst/*"
    [remote]="$USER/.config/dunst/"
)
declare -A loc30=(
    [name]="zsh config"
    [local]="/home/b3nj4m1n/dotfiles/files/zsh/.zshrc"
    [remote]="$USER/"
)
declare -A loc31=(
    [name]="more zsh config"
    [local]="/home/b3nj4m1n/dotfiles/files/zsh/*"
    [remote]="$USER/.config/zsh/"
)
declare -A loc32=(
    [name]="ranger config"
    [local]="/home/b3nj4m1n/dotfiles/files/ranger/*"
    [remote]="$USER/.config/ranger/"
)
declare -A loc33=(
    [name]="betterlockscreen"
    [local]="/home/b3nj4m1n/dotfiles/files/betterlockscreen/*"
    [remote]="$USER/.config/"
)
declare -A loc34=(
    [name]="scripts"
    [local]="/home/b3nj4m1n/dotfiles/scripts/*.sh"
    [remote]="/usr/bin/scripts/"
)
declare -A loc35=(
    [name]="etc profile"
    [local]="/home/b3nj4m1n/dotfiles/files/etc/profile"
    [remote]="/etc/"
)
declare -A loc35=(
    [name]="font config"
    [local]="/home/b3nj4m1n/dotfiles/files/fontconfig/fonts.conf"
    [remote]="/home/b3nj4m1n/.config/fontconfig/"
)
declare -A loc36=(
    [name]="tmux"
    [local]="/home/b3nj4m1n/dotfiles/files/tmux/.tmux.conf"
    [remote]="/home/b3nj4m1n/"
)
declare -A loc37=(
    [name]="lemonblocks"
    [local]="/home/b3nj4m1n/dotfiles/files/lemonblocks/config.txt"
    [remote]="/home/b3nj4m1n/.config/lemonblocks/"
)
declare -A loc38=(
    [name]="lemonblocks scripts"
    [local]="/home/b3nj4m1n/dotfiles/scripts/lemonblocks/*"
    [remote]="/usr/bin/lbscripts/"
)
declare -A loc39=(
    [name]="anki aqt web"
    [local]="/home/b3nj4m1n/dotfiles/files/anki/*"
    [remote]="/usr/share/aqt_data/web/"
)
declare -A loc40=(
    [name]="anki addons"
    [local]="/home/b3nj4m1n/dotfiles/files/anki-addons/*"
    [remote]="/home/b3nj4m1n/.local/share/Anki2/addons21/"
)
declare -A loc41=(
    [name]="rofi config"
    [local]="/home/b3nj4m1n/dotfiles/files/rofi/*"
    [remote]="$USER/.config/rofi/"
)
declare -A loc42=(
    [name]="zathura config"
    [local]="/home/b3nj4m1n/dotfiles/files/zathura/*"
    [remote]="$USER/.config/zathura/"
)
declare -A loc43=(
    [name]="polybar config"
    [local]="/home/b3nj4m1n/dotfiles/files/polybar/*"
    [remote]="$USER/.config/polybar/"
)
declare -A loc44=(
    [name]="polybar scripts"
    [local]="/home/b3nj4m1n/dotfiles/scripts/polybar/*"
    [remote]="/usr/bin/polyscripts/"
)
declare -A loc45=(
    [name]="script assets"
    [local]="/home/b3nj4m1n/dotfiles/scripts/assets/*"
    [remote]="/usr/bin/scripts/assets/"
)

RED='\033[0;31m'
GREEN='\033[0;32m'
PURPLE='\033[1;35m'
REVERSE='\033[7m'
RESET='\033[0m'

declare -n loc
for loc in ${!loc@}; do
    printf "${PURPLE} Transfering ${REVERSE}${loc[name]}${RESET}"
    sudo -u b3nj4m1n -g users mkdir -p ./bay/root${loc[remote]}
    cp -f -u -r -p ${loc[local]} ./bay/root${loc[remote]}
    cp -r --attributes-only --preserve=mode ${loc[local]} ./bay/root${loc[remote]}
    if [ $? -eq 0 ]; then
        printf "${GREEN} OK"
    else
        printf "${RED} ERROR"
    fi
    printf "\n"
done

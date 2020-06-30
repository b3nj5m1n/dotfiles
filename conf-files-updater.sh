#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
USER=/home/$(echo $DIR | cut -d/ -f3)

declare -A loc1=(
    [name]="lightdm"
    [local]="./files/lightdm/*"
    [remote]="/etc/lightdm/"
)
declare -A loc2=(
    [name]="gtk2"
    [local]="./files/gtk/.gtkrc-2.0"
    [remote]="$USER/"
)
declare -A loc3=(
    [name]="gtk3"
    [local]="./files/gtk/settings.ini"
    [remote]="$USER/.config/gtk-3.0/"
)
declare -A loc5=(
    [name]="picom"
    [local]="./files/picom/picom.conf"
    [remote]="$USER/.config/"
)
declare -A loc7=(
    [name]="alacritty"
    [local]="./files/alacritty/alacritty.yml"
    [remote]="$USER/.config/alacritty/"
)
declare -A loc10=(
    [name]="neovim config"
    [local]="./files/nvim/*"
    [remote]="$USER/.config/nvim/"
)
declare -A loc11=(
    [name]="pinky vim airline theme"
    [local]="./files/vim/pinky_airline.vim"
    [remote]="$USER/.config/nvim/autoload/plugged/vim-airline-themes/autoload/airline/themes/"
)
declare -A loc15=(
    [name]="cmus"
    [local]="./files/cmus/*"
    [remote]="$USER/.config/cmus/"
)
declare -A loc16=(
    [name]="cli-visualizer"
    [local]="./files/cli-visualizer/*"
    [remote]="$USER/.config/vis/"
)
declare -A loc25=(
    [name]="Hotkey daemon"
    [local]="./files/sxhkd/*"
    [remote]="$USER/.config/sxhkd/"
)
declare -A loc28=(
    [name]="bspwm config"
    [local]="./files/bspwm/*"
    [remote]="$USER/.config/bspwm/"
)
declare -A loc29=(
    [name]="dunst config"
    [local]="./files/dunst/*"
    [remote]="$USER/.config/dunst/"
)
declare -A loc30=(
    [name]="zsh config"
    [local]="./files/zsh/.zshrc"
    [remote]="$USER/"
)
declare -A loc31=(
    [name]="more zsh config"
    [local]="./files/zsh/*"
    [remote]="$USER/.config/zsh/"
)
declare -A loc32=(
    [name]="ranger config"
    [local]="./files/ranger/*"
    [remote]="$USER/.config/ranger/"
)
declare -A loc33=(
    [name]="betterlockscreen"
    [local]="./files/betterlockscreen/*"
    [remote]="$USER/.config/"
)
declare -A loc34=(
    [name]="scripts"
    [local]="./scripts/*.sh"
    [remote]="/usr/bin/scripts/"
)

RED='\033[0;31m'
GREEN='\033[0;32m'
PURPLE='\033[1;35m'
REVERSE='\033[7m'
RESET='\033[0m'

declare -n loc
for loc in ${!loc@}; do
    printf "${PURPLE} Transfering ${REVERSE}${loc[name]}${RESET}"
    mkdir -p ${loc[remote]}
    cp -f -u -r -p ${loc[local]} ${loc[remote]}
    if [ $? -eq 0 ]; then
        printf "${GREEN} OK"
    else
        printf "${RED} ERROR"
    fi
    printf "\n"
done

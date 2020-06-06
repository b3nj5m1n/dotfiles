#!/bin/bash


# Daemons & stuff
~/wally.sh -r -t nature
picom &
dunst &
sxhkd &
dwmblocks &

# Programms
firefox --class="init_firefox" &
alacritty --class "cmus" -e "cmus" &
discord &
anki &
thunderbird --class "init_thunderbird" &
# keeweb &
syncthing

# ~/.config/polybar/polybar.sh

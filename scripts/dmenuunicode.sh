#!/bin/bash

# Opens a menu with a list of unicode emojis, the selection will be copied to clipboard or typed directly
# Taken from here: https://github.com/LukeSmithxyz/voidrice

# Get user selection via dmenu from emoji file.
chosen=$(cut -d ';' -f1 ./assets/emoji.txt | dmenu -i -l 10 -fn "UbuntuMono Nerd Font Mono" -nf "#ff0066" | sed "s/ .*//")

# Exit if none chosen.
[ -z "$chosen" ] && exit

# If you run this command with an argument, it will automatically insert the
# character. Otherwise, show a message that the emoji has been copied.
if [ -n "$1" ]; then
	xdotool type "$chosen"
else
	echo "$chosen" | tr -d '\n' | xclip -selection clipboard
	notify-send "'$chosen' copied to clipboard." &
fi
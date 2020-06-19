#!/bin/sh

# My scratchpad implementation for having multiple programs as a scratchpad
# Call this script with one argument, this has to be both the classname & the command to run in the terminal

classname=$1

# Alacritty dimensions
d="226 60"
p="50 60"

id=$(xdotool search --classname "$classname")
if [ -z "$id" ]; then
    alacritty --class "$classname" --dimensions $d --position $p -e "$classname" &
    # Wait for process to open, then get the window id
    sleep 1
    id=$(xdotool search --classname "$classname")
    bspc node "$id" -t floating
    bspc node "$id" --flag sticky
fi
# Send window to current desktop
bspc node "$id" -d $(bspc query -D -d focused)
bspc node "$id" --flag hidden -f

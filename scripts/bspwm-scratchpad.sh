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
fi

bspc node "$id" --flag hidden -f
bspc node "$id" --flag sticky
bspc node "$id" -t floating


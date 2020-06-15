#!/bin/bash

german="german"
dvorak="dvorak"
pdvorak="programmer dvorak"
english="english"

selection=$(printf "$german\n$dvorak\n$pdvorak\n$english" | dmenu -c)

# Remove all custom mappings
setxkbmap -option

if [[ "$selection" = "$german" ]]; then
    setxkbmap de
elif [[ "$selection" = "$dvorak" ]]; then
    setxkbmap gb dvorak
elif [[ "$selection" = "$pdvorak" ]]; then
    setxkbmap -layout us -variant dvp -option compose:102 -option numpad:shift3 -option kpdl:semi -option keypad:atm -option caps:shift
    xmodmap -e "keycode 94=0x007c"
elif [[ "$selection" = "$english" ]]; then
    setxkbmap gb
fi

# Send notification
notify-send -a "keyboard-layout-switcher" "Layout Switcher" "Switched keyboard layout to <i>$selection</i>"
# Send signal to lemonblocks
pkill lemonblocks -8 &

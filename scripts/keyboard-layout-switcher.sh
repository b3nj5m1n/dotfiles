#!/bin/bash

selection=$(printf "german\ndvorak\nprogrammer dvorak\nenglish" | dmenu -c)

# Remove all custom mappings
setxkbmap -option

if [[ "$selection" = "german" ]]; then
    setxkbmap de
elif [[ "$selection" = "dvorak" ]]; then
    setxkbmap gb dvorak
elif [[ "$selection" = "programmer dvorak" ]]; then
    setxkbmap -layout us -variant dvp -option compose:102 -option numpad:shift3 -option kpdl:semi -option keypad:atm -option caps:shift
    xmodmap -e "keycode 94=0x007c"
elif [[ "$selection" = "english" ]]; then
    setxkbmap gb
fi

pkill -RTMIN+2 dwmblocks

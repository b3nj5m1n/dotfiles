#!/usr/bin/env sh

german="german"
dvorak="dvorak"
pdvorak="programmer dvorak"
english="english"

if [ "$XDG_CURRENT_DESKTOP" = "sway" ]; then
    notify-send -a "keyboard-layout-switcher" "Layout Switcher" "Disabled on sway"
    exit
fi
notify-send -a "keyboard-layout-switcher" "Layout Switcher" "Switched keyboard layout to <i>$selection</i>"

selection=$(printf '%s\n%s\n%s\n%s' "$german" "$dvorak" "$pdvorak" "$english" | rofi -dmenu --prompt="Layout" --hide-scroll --insensitive)

# Remove all custom mappings
setxkbmap -option

if [ "$selection" = "$german" ]; then
    setxkbmap de
elif [ "$selection" = "$dvorak" ]; then
    setxkbmap gb dvorak
elif [ "$selection" = "$pdvorak" ]; then
    setxkbmap -layout us -variant dvp -option compose:102 -option numpad:shift3 -option kpdl:semi -option keypad:atm -option caps:shift
    xmodmap -e "keycode 94=0x007c"
elif [ "$selection" = "$english" ]; then
    setxkbmap gb
fi

# Send notification
notify-send -a "keyboard-layout-switcher" "Layout Switcher" "Switched keyboard layout to <i>$selection</i>"
# Send signal to lemonblocks
pkill lemonblocks -8 &

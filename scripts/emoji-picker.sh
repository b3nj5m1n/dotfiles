#!/usr/bin/env sh

# Opens a menu with a list of unicode emojis, the selection will be copied to clipboard or typed directly
# Taken from here: https://github.com/LukeSmithxyz/voidrice

if [ "$(loginctl show-session "$(awk '/tty/ {print $1}' <(loginctl))" -p Type | awk -F= '{print $2}')" = "wayland" ]; then
    notify-send  "emoji picker" "Use bemoji" &
    exit
fi

# Get user selection via rofi -dmenu from emoji file.
# chosen=$(cut -d ';' -f1 ./assets/emoji.txt | rofi -dmenu -i -l 10 -fn "UbuntuMono Nerd Font Mono" -nf "#ff0066" | sed "s/ .*//")
chosen=$(cut -d ';' -f1 /bin/scripts/assets/emoji.txt | rofi -dmenu -p "> " -fn "Twemoji" | sed "s/ .*//")

# Exit if none chosen.
[ -z "$chosen" ] && exit

notify-send  "emoji picker" "'$chosen' copied to clipboard." &

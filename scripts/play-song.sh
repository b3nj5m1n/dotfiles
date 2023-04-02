#!/usr/bin/env sh

# This script displays a rofi -dmenu with all mp3 files from a folder, upon selection the song will be played in cmus

# Dir to search for music in
dirname="/mnt/Vault/music/"

cd "$dirname" || exit
selection=$(find . -name "*.mp3" | rofi -dmenu -i -F)

[ -z "$selection" ] && exit

mpc clear
mpc add "$(echo "$selection" | sed 's/\.\///g')"
mpc play


# Send notification
songname=$(echo "$selection" | rev | cut -d '/' -f 1 | rev)
notify-send -a "play-song" "Play song" "Now playing song <i>$songname</i>"

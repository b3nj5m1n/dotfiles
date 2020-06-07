#!/bin/bash

# This script displays a dmenu with all mp3 files from a folder, upon selection the song will be played in cmus

# Dir to search for music in
dirname="/mnt/Vault/music/"

cd "$dirname"
selection=$(find -name "*.mp3" | dmenu -i -F)

[ -z "$selection" ] && exit

cmus-remote -f "$selection"

# Send notification
songname=$(echo "$selection" | rev | cut -d '/' -f 1 | rev)
notify-send -a "play-song" "Play song" "Now playing song <i>$songname</i>"

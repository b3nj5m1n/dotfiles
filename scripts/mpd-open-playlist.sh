#!/usr/bin/env sh

# This script shows a list of playlists in a given directory, clears the current playlist in mpd and adds all songs from the selected playlist

dir="/mnt/Vault/music/"

selection=$(find "$dir" -maxdepth 1 -name "*.m3u*" | rofi -dmenu -i -matching fuzzy)

mpc clear

sed "s|./|mpc add \"|" "$selection" | sed "s|$|\"|" | bash


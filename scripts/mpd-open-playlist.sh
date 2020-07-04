#!/bin/bash

# This script shows a list of playlists in a given directory, clears the current playlist in mpd and adds all songs from the selected playlist

dir="/mnt/Vault/music/"

selection=$(find "$dir" -maxdepth 1 -name "*.m3u" | dmenu)

mpc clear

cat "$selection" | sed "s|./|mpc add \"|" | sed "s|$|\"|" | bash

#!/bin/bash

# This script deletes all playlists in cmus and reimports all m3u files from music dir

# DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# USER=/home/$(echo $DIR | cut -d/ -f3)
USER="/home/b3nj4m1n"

# Dir to search for m3u files
dirname="/mnt/Vault/music"

# Close cmus
killall cmus
sleep 1
# Remove all playlists from cmus config dir
rm -f $USER/.config/cmus/playlists/*
sleep 1
# Restart cmus
alacritty --class cmus -e "cmus" &
sleep 1

# Import mp3s
cmus-remote -C "add $dirname"
# Import all m3u files
for filename in $dirname/*.m3u; do
    cmus-remote -C "pl-import $filename"
done

# Switch to playlist view
cmus-remote -C "view 3"

# Send notification
notify-send -a "reimport-playlists-cmus.sh" "Reimport Playlists" "Reimport of cmus playlists completet"

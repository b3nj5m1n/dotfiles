#!/bin/bash

# This script deletes all playlists in cmus and reimports all m3u files from music dir

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
USER=/home/$(echo $DIR | cut -d/ -f3)

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

# Import all m3u files
for filename in $dirname/*.m3u; do
    cmus-remote -C "pl-import $filename"
done

# Switch to playlist view
cmus-remote -C "view 3"

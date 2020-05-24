#!/bin/bash

# This script displays a dmenu with all mp3 files from a folder, upon selection the song will be played in cmus

# Dir to search for music in
dirname="/mnt/Vault/music/"

cd "$dirname"
selection=$(find -name "*.mp3" | dmenu -i -F)
echo $selection
cmus-remote -f "$filename$selection"

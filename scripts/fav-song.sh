#!/usr/bin/env sh

# This script grabs the track currently played by cmus and puts the filename into a playlist file
# The menu displayed will contain every file in the specified dir starting with a.
# Typing any name will automatically save to a new filename (Full path needs to be typed)

# Directory to search for m3u files
dirname="/mnt/Vault/music"
# Filter for finding playlist files
filter="a.*.m3u"

# Get selection
files=$(find $dirname -maxdepth 1 -name $filter)
# File to write to
filename=$(printf "$files" | rofi -dmenu -c)

[ -z "$filename" ] && exit

# Get relative path to song and write it to the file
# songname=$(cmus-remote -Q 2>/dev/null | sed "s/file \/mnt\/Vault\/music/./;t;d")
songname=$(mpc -f "%file%" current | sed 's/^/\.\//g')
printf "%s\n" "$songname" >> $filename

# Display notification
filename=$(echo "$filename" | rev | cut -d '/' -f 1 | rev)
songname=$(echo "$songname" | rev | cut -d '/' -f 1 | rev)
notify-send -a "fav-song" "Save song" "Song <i>$songname</i> to <i>$filename</i> successfully"

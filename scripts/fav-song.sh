#!/bin/bash

# This script grabs the track currently played by cmus and puts the filename into a playlist file
# To reload all playlists an external script needs to be used at a later time (Cmus needs to be closed)

# Get args in array
args=("$@")

# Playlist to which the song will be written if no args are given
filename="/mnt/Vault/music/a.favs.m3u"

# Chill playlist
match="--chill"
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then
    filename="/mnt/Vault/music/a.chill.m3u"
fi
# Metal playlist
match="--metal"
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then
    filename="/mnt/Vault/music/a.metal.m3u"
fi

# Get relative path to song and write it to the file
cmus-remote -Q 2>/dev/null | sed "s/file \/mnt\/Vault\/music/./;t;d" >> $filename

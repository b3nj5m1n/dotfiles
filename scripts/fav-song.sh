#!/bin/bash

# This script grabs the track currently played by cmus and puts the filename into a playlist file
# To reload all playlists an external script needs to be used at a later time (Cmus needs to be closed)

# Playlist to which the song will be written
filename="/mnt/Vault/music/favs.m3u"

# Get relative path to song and write it to the file
cmus-remote -Q 2>/dev/null | sed "s/file \/mnt\/Vault\/music/./;t;d" >> $filename

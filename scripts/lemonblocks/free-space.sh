#!/bin/bash

# Displays the free disk space, can be toggled on and off

printf "%%{F-}"

FILE=/tmp/displayfreespace
if [[ -f "$FILE" ]]; then
    # Display free space
    diskusage=$(df -h | grep /dev/sd | awk '{ print $1 " " $4 }' | tr '\n' ' ')

    printf "%%{A1:rm /tmp/displayfreespace; pkill lemonblocks -7:}$diskusage%%{A1}"
else
    printf "%%{A1:touch /tmp/displayfreespace; pkill lemonblocks -7:}du%%{A1}"
fi

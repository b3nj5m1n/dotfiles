#!/bin/bash

printf "%%{F-}"

mode="$(cat /tmp/datemode 2>/dev/null)"

if [[ "$mode" == "0" ]]; then
    printf "%s" "%{A1:echo 1 > /tmp/datemode; pkill lemonblocks -12:}"
    date=$(date "+%H:%M")
elif [[ "$mode" == "1" ]]; then
    printf "%s" "%{A1:echo 2 > /tmp/datemode; pkill lemonblocks -12:}"
    date=$(date "+%d/%m/%y")
else
    printf "%s" "%{A1:echo 0 > /tmp/datemode; pkill lemonblocks -12:}"
    date=$(date "+%d/%m/%y %H:%M")
fi

printf "$date"

printf "%s" "%{A1}"

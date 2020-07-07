#!/bin/bash

# Displays the uptime

printf "%%{F-}"

FILE=/tmp/verboseuptime
if [[ -f "$FILE" ]]; then
    printf "%%{A1:rm /tmp/verboseuptime; pkill lemonblocks -11:}uptime: $(uptime -p | sed 's/up //g')%%{A1}"
else
    printf "%%{A1:touch /tmp/verboseuptime; pkill lemonblocks -11:}$(uptime -p | sed 's/up //g')%%{A1}"
fi

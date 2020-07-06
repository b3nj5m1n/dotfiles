#!/bin/bash

# Displays the uptime

printf "%%{F-}"

FILE=/tmp/verboseuptime
if [[ -f "$FILE" ]]; then
    printf "%%{A1:rm /tmp/verboseuptime; pkill lemonblocks -11:}uptime: $(uptime | cut -d ' ' -f 5 | tr ',' ' ')%%{A1}"
else
    printf "%%{A1:touch /tmp/verboseuptime; pkill lemonblocks -11:}$(uptime | cut -d ' ' -f 5 | tr ',' ' ')%%{A1}"
fi

#!/bin/bash

# Displays the load average

printf "%%{F-}"

FILE=/tmp/verboseloadaverage
if [[ -f "$FILE" ]]; then
    printf "%%{A1:rm /tmp/verboseloadaverage; pkill lemonblocks -10:}$(uptime | grep -ioe "load average: [[:digit:]]*.[[:digit:]]*")%%{A1}"
else
    printf "%%{A1:touch /tmp/verboseloadaverage; pkill lemonblocks -10:}$(uptime | grep -ioe "load average: [[:digit:]]*.[[:digit:]]*" | sed 's/load average: //g')%%{A1}"
fi

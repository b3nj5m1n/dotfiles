#!/bin/bash

# Displays the uptime

FILE=/tmp/verboseuptime
if [[ -f "$FILE" ]]; then
    printf "uptime: $(uptime -p | sed 's/up //g')"
else
    printf "$(uptime -p | sed 's/up //g' | sed -r 's|([[:digit:]]+) ([[:alpha:]])[[:alpha:]]*|\1\2|g')"
fi

#!/bin/bash

# Polybar script for getting the current song from cmus

# Call cmus-remote -Q to get available information about the current song
info=$(cmus-remote -Q 2>/dev/null)
# Store the return value to check if cmus is running
retval=$?

if [ $retval -ne 0 ]; then
    # If the return value is not 0, then echo nothing, since cmus is not running
    echo 
    exit
else
    # Cmus is running, so find out if it's playing or paused and echo the corresponding glyph
    if grep -q "status playing"  <<< "$info"
    then 
        printf "  ";
    else
        printf "  ";
        exit
    fi
fi

# Parse the info to get the current playing song in a {Artist} - {Title} format
song=$(echo "$info" | sed -r "s/tag \w+\s//;t;d" | awk 'BEGIN{ RS = "" ; FS = "\\n" }{print $1" - "$3}')

# Parse the info to get the progress in %
total=$(echo "$info" | sed -r "s/duration //;t;d")
progr=$(echo "$info" | sed -r "s/position //;t;d")
perc=$(awk -v n="$total" -v m="$progr" 'BEGIN{ print int(( m/n )*100) }')
chrlen=${#song}
perc_chr=$(awk -v n="$chrlen" -v m="$perc" 'BEGIN{ print int( n*(m/100)) }')

# What to put at the beginning of the string
# b="\e[31m"
b="^c#ff0066^"
# What to put in the middle of the string
# m="\e[0m"
m="^d^"
# What to put at the end of the string
# e="\e[0m"
e=""

song="$b"${song:0:$perc_chr}"$m"${song:$perc_chr:$chrlen}"$e"
printf "$song"

printf "\n"

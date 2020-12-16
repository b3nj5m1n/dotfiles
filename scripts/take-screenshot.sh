#!/bin/bash
mkdir -p ~/Pictures/screenshots/
slop=$(slop -f "%g") || exit 1
read -r G < <(echo $slop)

filename=~/Pictures/screenshots/$(date "+%d-%m-%y_%S-%M-%H").png

import -window root -crop $G "$filename"

# Send notification, keep track of whether or not it has been clicked
ACTION=$(dunstify --action "default,Reply" "Screenshot was saved to <i>$filename</i>")
# It has been clicked, display the image
if [ "$ACTION" -eq 2 ]; then
    xdg-open "$filename"
fi

# Send notification
# notify-send -a "take-screenshot" "Screenshot" "Screenshot was saved to <i>$filename</i>"

#!/usr/bin/env sh

# Rofi program launcher

MAP="/home/b3nj4m1n/.config/wofi/map.csv"

cut -d ',' -f 1 "$MAP" \
    | wofi --dmenu -p "Util " \
    | head -n 1 \
    | xargs -I --no-run-if-empty grep "{}" "$MAP" \
    | cut -d ',' -f 2 \
    | head -n 1 \
    | xargs -I --no-run-if-empty /usr/bin/env sh -c "{}"

exit 0

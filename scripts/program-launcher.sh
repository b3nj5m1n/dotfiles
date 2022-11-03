#!/usr/bin/env sh

# Rofi program launcher

MAP="/home/b3nj4m1n/.config/rofi/map.csv"

cat "$MAP" \
    | cut -d ',' -f 1 \
    | rofi -dmenu -i -p "Util " \
    | head -n 1 \
    | xargs -i --no-run-if-empty grep "{}" "$MAP" \
    | cut -d ',' -f 2 \
    | head -n 1 \
    | xargs -i --no-run-if-empty /bin/bash -c "{}"

exit 0

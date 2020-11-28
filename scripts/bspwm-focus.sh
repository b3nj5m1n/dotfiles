#!/bin/bash

LOCKFILE="/tmp/bspwm-focus"

bottom_padding=$(bspc config bottom_padding)
window_gap=$(bspc config window_gap)
gapless_monocle=$(bspc config gapless_monocle)
border_width=$(bspc config border_width)

if [ -f "$LOCKFILE" ] ; then
    while read -r v1 v2 v3 v4; do
        bspc config bottom_padding "$v1"
        bspc config window_gap "$v2"
        bspc config gapless_monocle "$v3"
        bspc config border_width "$v4"
    done < "$LOCKFILE"
    rm "$LOCKFILE"
else
    printf "%s\n%s\n%s\n%s\n" "$bottom_padding" "$window_gap" "$gapless_monocle" "$border_width" > "$LOCKFILE"
        bspc config bottom_padding 0
        bspc config window_gap 0
        bspc config gapless_monocle true
        bspc config border_width 0
    touch "$LOCKFILE"
fi

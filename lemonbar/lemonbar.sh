#!/bin/bash

######################### Config #########################

# Basic panel config
PANEL_HEIGHT=24
PANEL_WIDTH=1920
PANEL_HORIZONTAL_OFFSET=0
PANEL_VERTICAL_OFFSET=0
PANEL_FONT="UbuntuMono Nerd Font 12"
PANEL_FIFO=/tmp/panel-fifo
PANEL_WM_NAME=bspwm_panel

# Color definitions
COLOR_DEFAULT_FG="#f5f5f5"
COLOR_DEFAULT_BG="#171517"

######################### Building Blocks #########################

# Colors
# First argument should be color in #rrggbb format, put return value in front of module
get_foreground () {
    printf "%%{F%s}" "$1"
}
get_background () {
    printf "%%{B%s}" "$1"
}
get_line () {
    printf "%%{U%s}" "$1"
}

# Alignment
# Put return value in front of module
get_right_aligned () {
    printf "%%{r}"
}
get_left_aligned () {
    printf "%%{l}"
}
get_center_aligned () {
    printf "%%{c}"
}

# Commands
# First argument should be the command to run, second argument should be the module, return value is the module
get_click () {
    printf "%%{A:%s:}%s%%{A}" "$1" "$2"
}
get_scroll_up () {
    printf "%%{A4:%s:}%s%%{A}" "$1" "$2"
}
get_scroll_down () {
    printf "%%{A5:%s:}%s%%{A}" "$1" "$2"
}

######################### Cmus Module #########################

MOD_cmus="\
    $(get_foreground "#ff0066")\
    $(get_background "#171517")\
    $(./lemonbar/cmus.sh)"
MOD_cmus=$(get_scroll_up "cmus-remote -n" "$MOD_cmus")
echo $MOD_cmus

######################### Bar #########################

BAR="$MOD_cmus"

######################### Set Bar #########################

for i in {1..5}
do
    echo "$BAR" | lemonbar -a 12 \
        -g "$PANEL_WIDTH"x"$PANEL_HEIGHT"+"$PANEL_HORIZONTAL_OFFSET"+"$PANEL_VERTICAL_OFFSET" \
        -f "$PANEL_FONT" -F "$COLOR_DEFAULT_FG" -B "$COLOR_DEFAULT_BG" -n "$PANEL_WM_NAME" | bash &
done


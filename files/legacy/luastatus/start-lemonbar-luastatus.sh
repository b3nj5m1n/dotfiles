#!/bin/bash

CLICKABLE_AREAS=30
PANEL_WIDTH=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f 1)
PANEL_HEIGHT=25
PANEL_HORIZONTAL_OFFSET=0
PANEL_VERTICAL_OFFSET=25
PANEL_FONT="UbuntuMono Nerd Font Mono:size=12"
PANEL_ICON_FONT="Twemoji:size=12"
COLOR_DEFAULT_FG="#f5f5f5"
COLOR_DEFAULT_BG="#00171517"
UNDERLINE_HEIGHT=3
# No compositor effects
PANEL_WM_NAME="LEMONBAR"
# Compositor effects
# PANEL_WM_NAME="lemonbar"

# Start lemonbar

luastatus-lemonbar-launcher -p -a"$CLICKABLE_AREAS" \
    -p -g"$PANEL_WIDTH"x"$PANEL_HEIGHT"+"$PANEL_HORIZONTAL_OFFSET"+"$PANEL_VERTICAL_OFFSET" \
    -p -f"$PANEL_FONT" -p -f"$PANEL_ICON_FONT" -p -F"$COLOR_DEFAULT_FG" -p -B"$COLOR_DEFAULT_BG" \
    -p -u"$UNDERLINE_HEIGHT" -p -n"$PANEL_WM_NAME" -- -Bseparator=' ' \
    left.lua bspwm.lua mpd.lua \
    center.lua title.lua \
    right.lua alsa.lua xkb.lua clock.lua

#!/bin/bash

CURRENT_WALLPAPER="/usr/share/wallpapers/custom/moonRising.png"
WALLPAPER="/home/b3nj4m1n/.config/wallpaper.png"

# Copy the wallpaper to its appropriate location
cp "$CURRENT_WALLPAPER" "$WALLPAPER"
# Apply effect to wallpaper (Shift hue, i.e. change color)
convert "$WALLPAPER" -modulate 100,100,$((0 + $RANDOM % 200)) "$WALLPAPER"
# Set the new wallpaper
feh --no-fehbg --bg-scale "$WALLPAPER"

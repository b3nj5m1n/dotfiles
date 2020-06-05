#!/bin/bash
mkdir -p ~/Pictures/screenshots/
slop=$(slop -f "%g") || exit 1
read -r G < <(echo $slop)
import -window root -crop $G ~/Pictures/screenshots/$(date "+%d-%m-%y_%S-%M-%H").png

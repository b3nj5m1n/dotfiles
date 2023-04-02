#!/usr/bin/env sh

cat ~/.config/sxhkd/* | awk '/^[a-z]/ && last {print $0,"\t",last} {last=""} /^#/{last=$0}' | column -t -s '	' | rofi -dmenu -i

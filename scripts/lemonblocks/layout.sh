#!/usr/bin/env sh

printf "%%{F-}"

layout=$(setxkbmap -query | grep layout | awk '{print $2}')

printf "%%{A1:/usr/bin/scripts/keyboard-layout-switcher.sh &:}$layout%%{A1}"

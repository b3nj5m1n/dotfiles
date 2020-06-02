#!/bin/bash

# Draw a floating URxvt
# Inspired by u/f0x52

# Draw a rectangle using slop then read the geometry value
read -r X Y W H < <(slop -f "%x %y %w %h" -b 4 -t 0 -q)

# Depends on font width & height
(( W /= 7 ))
(( H /= 15 ))

# Create a variable to be used for URxvt flag option
d="${W} ${H}"
p="${X} ${Y}"

# Remove current URxvt rules
bspc rule -r Alacritty

# Draw with floating rule
bspc rule -a Alacritty -o state=floating follow=on focus=on
alacritty --dimensions $d --position $p &

# Restore the rule
bspc rule -a Alacritty desktop='^1' follow=on focus=on

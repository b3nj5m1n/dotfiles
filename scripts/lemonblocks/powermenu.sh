#!/bin/bash

printf "%%{F-}"

FILE=/tmp/coloredpowermenu
if [[ ! -f "$FILE" ]]; then
    echo -e "%c1-hex\n%c2-hex\n%c3-hex\n%c4-hex\n%c5-hex\n%c6-hex\n" > /tmp/coloredpowermenu;
fi

colors="$(cat /tmp/coloredpowermenu)"
lines="$(echo "$colors" | wc -l)"

touch /tmp/powermenuoffset

printf "%%{A1:echo 1 >> /tmp/powermenuoffset; pkill lemonblocks -3:}"
i=$(cat /tmp/powermenuoffset | wc -l)
grep -o . <<< "$(hostname)" | while read letter; do
color="%{F$(sed "$(($(($i % $lines)) + 1))q;d" /tmp/coloredpowermenu)}"
printf "%s%s" $color $letter
i=$(($i + 1))
done
printf "%%{A1}"

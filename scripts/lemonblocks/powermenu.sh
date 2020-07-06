#!/bin/bash

printf "%%{F-}"

FILE=/tmp/coloredpowermenu
if [[ ! -f "$FILE" ]]; then
    echo -e "#ff0066\n#00ff66\n#c6c62a\n#c6c62a\n#8649e1\n#33ffff" > /tmp/coloredpowermenu;
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

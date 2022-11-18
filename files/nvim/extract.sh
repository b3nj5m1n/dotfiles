#!/usr/bin/env sh

in_code_block=false

printf "" > ./build/config.fnl

while read -r line; do
    if [ "${line#*'@code'}" != "$line" ]; then
        in_code_block=true
    elif [ "${line#*'@end'}" != "$line" ]; then
        in_code_block=false
    elif $in_code_block; then
        printf "%s\n" "$line" >> ./build/config.fnl
    fi
done < ./config.norg

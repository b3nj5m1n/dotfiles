#!/bin/bash

# Wrapper around bitwarden cli to handle sessions

# Item id of item to retrieve password from; To get the item id initially use this command:
# bw list items --search "searchterm" --session "$(gpg --decrypt /tmp/bitwardentoken)" --pretty
ID=$1

# File storing the encrypted session key
FILE=/var/tmp/bitwardentoken

while [ True ]
do
    # Test if session exists
    if [ -f "$FILE" ]; then
        # Session exists, try to get password
        result=$(bw get password "$ID" --session "$(gpg --decrypt $FILE)" --nointeraction --raw)
        if [ $? -eq 0 ]; then
            echo $result
            exit 0
        else
            rm "$FILE"
        fi
    else 
        bitwardenpw=$(zenity --password --title=Authentication)
        KEY=$(bw unlock "$bitwardenpw" --nointeraction --raw)
        if [ $? -eq 0 ]; then
            echo $KEY | gpg --encrypt -r "9F7D2083BB220CEEB720E068309D4C8689849C5B" > "$FILE"
        fi
    fi
done






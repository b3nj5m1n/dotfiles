#!/bin/bash

# Wrapper around bitwarden cli to handle sessions

export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u $USER)/bus;
export DISPLAY=:0;
export HOME="/home/b3nj4m1n/"
export USER="b3nj4m1n"

# Item id of item to retrieve password from; To get the item id initially use this command:
# bw list items --search "searchterm" --session "$(gpg --decrypt /tmp/bitwardentoken)" --pretty
ID=$1

# File storing the encrypted session key
FILE=/var/tmp/bitwardentoken

# Counter to keep track of failed attempts
COUNTER=0

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
        bitwardenpw=$(zenity --password --title=Authentication --text='Please enter your bitwarden master password.')
        KEY=$(bw unlock "$bitwardenpw" --nointeraction --raw)
        if [ $? -eq 0 ]; then
            echo $KEY | XDG_RUNTIME_DIR=/run/user/$(id -u) gpg --encrypt -r "$DFGPGPROFILE" > "$FILE"
        else
            COUNTER=$((COUNTER+1))
            if [ "$COUNTER" -gt "1" ]
            then
                exit
            fi
            sleep 10
        fi
    fi
done






#!/bin/bash
PASSWORD=$1
for filename in ../encrypted_configs/*; do
    if [[ ! $filename == *.gpg ]]    
    then
        echo "Encrypting $filename"
        gpg --pinentry-mode=loopback --yes --passphrase  "$PASSWORD" -c "$filename"
        rm "$filename"
    fi
done

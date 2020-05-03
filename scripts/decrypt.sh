#!/bin/bash
PASSWORD=$1
mkdir /tmp/decrypted_configs/
for filename in ../encrypted_configs/*.gpg; do
    echo "Decrypting $filename to ${filename%.gpg}"
    gpg --pinentry-mode=loopback --yes --passphrase  "$PASSWORD" -d -o ${filename%.gpg} "$filename"
    mv ${filename%.gpg} /tmp/decrypted_configs
done

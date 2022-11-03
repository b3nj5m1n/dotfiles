#!/usr/bin/env sh

# Directory used for terminfo entrys
DIR="/usr/share/terminfo"
export TERMINFO="$DIR"

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Compile all terminfo files in this directory
/usr/bin/env find "." -name '*.terminfo' -exec tic -o "$DIR" -x {} \;

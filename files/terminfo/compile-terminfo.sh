#!/bin/bash

# Directory used for terminfo entrys
export TERMINFO="/usr/share/terminfo"

# Compile all terminfo files in this directory
/usr/bin/find "." -name '*.terminfo' -exec tic -x {} \;

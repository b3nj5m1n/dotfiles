#!/bin/bash

# Make sure cht.sh exists
# CHTSH_BIN=/usr/bin/cht.sh
# if [ ! -f "$CHTSH_BIN" ]; then
#     # Test for root
#     if [[ "$EUID" = 0 ]]; then
#         # Download client
#         curl https://cht.sh/:cht.sh > "$CHTSH_BIN"
#         # Make client executable
#         chmod +x "$CHTSH_BIN"
#         # Download source files
#         cht.sh --standalone-install
#     else
#         echo "Run as root to install cht.sh"
#     fi
# fi


tmux display-popup -E -w 75% -h 90% "cht.sh --shell -n"

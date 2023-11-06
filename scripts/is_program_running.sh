#!/usr/bin/env sh

unalias -a

if pgrep "$1" > /dev/null; then
    echo "running"
else
    echo "not running"
fi

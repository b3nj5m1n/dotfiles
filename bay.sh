#!/bin/bash

# This script automatically executes all 3 bay scripts

rm -rf /home/b3nj4m1n/dotfiles/bay/*

./scripts/load-bay.sh
./scripts/process-bay.sh
./scripts/unload-bay.sh

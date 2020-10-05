#!/bin/bash

# This script copys all the files from the bay folder to their destinations on the real filesystem

cp -a /home/b3nj4m1n/dotfiles/bay/root/* /
cp -r --attributes-only --preserve=mode /home/b3nj4m1n/dotfiles/bay/root/* /

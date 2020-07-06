#!/bin/bash

volume="$(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master) | sed 's/%//g')"

printf "[$volume%%]"

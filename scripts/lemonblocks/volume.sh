#!/bin/bash

volume="$(amixer sget Master | grep -io "[[[:digit:]]*%]" | head -n 1)"

printf "%s" "$volume"

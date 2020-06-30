#!/bin/bash

# This script processess the files in the bay dir by replacing placeholders with values

ph_file="/home/b3nj4m1n/dotfiles/placeholders/pinky.json"

# Get a count of how many placeholders there are
ph_count=$(jq '.placeholders[].placeholder' "$ph_file" | wc -l)

# Loop over placeholders in the file
for i in $(seq 0 $(($ph_count - 1)))
do
    # Get the placeholder
    ph=$(jq -r ".placeholders[$i].placeholder" "$ph_file")
    # Get a count of how many suffixes there are
    suffix_count=$(jq ".placeholders[$i].suffixes | length" "$ph_file")
    # Loop over suffixes
    for j in $(seq 0 $(($suffix_count - 1)))
    do
        # Get the suffix
        suffix=$(jq -r ".placeholders[$i].suffixes[$j].suffix" "$ph_file")
        # Get the value
        value=$(jq -r ".placeholders[$i].suffixes[$j].value" "$ph_file")
        echo "$ph-$suffix $value"
    done
done

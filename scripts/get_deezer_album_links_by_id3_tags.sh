#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash fd exiftool curl

# Create a loop over each 2-level deep directory
fd . --min-depth 2 --max-depth 2 --type directory | while read -r dir; do
  echo "Checking dir: $dir"

  # For every mp3 file in this directory, get the ISRC code
  fd . --extension mp3 "$dir" | while read -r file; do
    echo "Checking file: $file"

    # Get the ISRC code
    ISRC=$(exiftool -ISRC "$file" | awk -F' ' '{print $NF}')

    json_file="$dir/$ISRC.json"

    if [ ! -f "$json_file" ]; then
    # Use curl to make a get request to the Deezer API to get the information about the track using the ISRC code
    JSON=$(curl -s "https://api.deezer.com/2.0/track/isrc:$ISRC")

    # Check if curl command failed
    if [ $? -eq 0 ]; then
        # Store the result in a json file with the filename "$ISRC.json"
        echo "$JSON" > "$json_file"
      else
        echo "Curl command failed for file: $file"
        exit 1  # Exit the script with an error code
      fi
    else
      echo "JSON file already exists for ISRC: $ISRC"
    fi

    # # Use curl to make a get request to the Deezer API to get the information about the track using the ISRC code
    # JSON=$(curl -s "https://api.deezer.com/2.0/track/isrc:$ISRC")

    # # Store the result in a json file with the filename "$ISRC.json"
    # echo "$JSON" > "$dir/$ISRC.json"
  done

  values=()
  # fd . --extension json "$dir" | while read -r file; do
  #   link=$(jq -r '.album.link' "$file")
  #   if [ -n "$link" ]; then
  #       values+=("$link")
  #   fi
  # done
  while IFS= read -r -d $'\0' file; do
    link=$(jq -r '.album.link' "$file")
    if [ -n "$link" ]; then
        values+=("$link")
    fi
  done < <(fd . --extension json "$dir" -0)
  first_value="${values[0]}"
  same_values=true

  for value in "${values[@]}"; do
      if [ "$value" != "$first_value" ]; then
          same_values=false
          break
      fi
  done

  if [ "$same_values" ]; then
    echo "$first_value" > "$dir/link.txt"
  fi
  echo "Same links: $same_values"
done


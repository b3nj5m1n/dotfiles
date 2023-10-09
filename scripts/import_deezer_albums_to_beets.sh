#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash fd beets parallel
#
# music_dir="/mnt/wolfpack/music_to_import/"; fd . "$music_dir" --min-depth 2 --max-depth 2 --type directory | while read -r dir; do
#   if [ -f "$dir/link.txt" ]; then
#       url=$(cat "$dir/link.txt")
#       echo "importing $dir ($url)"
#       beet import -q -m "$dir" --search-id "$url"
#   fi
# done

music_dir="/mnt/wolfpack/music_to_import/"

# Define a function to process each directory in parallel
process_directory() {
  dir="$1"
  if [ -f "$dir/link.txt" ]; then
    url=$(cat "$dir/link.txt")
    echo "importing $dir ($url)"
    beet import -q -m "$dir" --search-id "$url"
  fi
}

export -f process_directory  # Export the function for use with parallel

# Find directories and process them in parallel
fd . "$music_dir" --min-depth 2 --max-depth 2 --type directory | \
  parallel -j 12 process_directory {}


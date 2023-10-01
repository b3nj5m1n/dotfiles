#! /usr/bin/env nix-shell
#! nix-shell -i dash -p dash findutils ffmpeg-full

# This will loop over all files in the music dir, find files with a high bitrate
# and convert them down to a more reasonable bitrate. Credit: https://askubuntu.com/a/536891

music_dir="/mnt/wolfpack/music/"

cd "$music_dir" || exit
find . -name '*.mp3' -exec sh -c 'ffprobe -show_streams -select_streams a:0 "$0" | grep -F "bit_rate=320000" && ffmpeg -y -i "$0" -c:a libmp3lame -b:a 128k /tmp/temp.mp3 && mv /tmp/temp.mp3 "$0"' '{}' \;

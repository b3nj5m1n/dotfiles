#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash gum

# Downloads youtube music favorites into navidrome compatible file structure
# and saves m3u of playlist
# After running: su, then
# rsync -rauL --info=progress2 . /var/lib/navidrome/music
# then do full scan in navidrome web interface

BASE_DIRECTORY="."
PlAYLIST_FILE="favs.m3u"

echo "#EXTM3U" > "$PlAYLIST_FILE"

start_spinner() {
    gum spin --spinner "$2" --title "Downloading $1..." sleep 1000 &
    SPIN_PID=$!
}

stop_spinner() {
    kill "$SPIN_PID"
}

yt-dlp "https://music.youtube.com/playlist?list=LM" \
    --cookies-from-browser firefox \
    -j --flat-playlist \
    --parse-metadata "album:%(album)s" \
    --parse-metadata "artist:%(artist)s" \
    | while IFS= read -r line; do
        song_url=$(echo "$line" | jq -r '.url')
        title=$(echo "$line" | jq -r '.title')
        start_spinner "$title" "globe"
        yt-dlp "$song_url" \
            --extract-audio --audio-format mp3 \
            --cookies-from-browser firefox \
            --output "$BASE_DIRECTORY/%(artist)s/%(album)s/%(track_number)s %(title)s.mp3" \
            --download-archive archive.txt \
            --add-metadata \
            --embed-thumbnail \
            --parse-metadata "album:%(album)s" \
            --parse-metadata "artist:%(artist)s" \
            --quiet

        filename=$(fd "$title" -F -e "mp3")
        echo "$BASE_DIRECTORY/$filename" >> "$PlAYLIST_FILE"
        stop_spinner
done


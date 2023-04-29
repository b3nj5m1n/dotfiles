#! /usr/bin/env nix-shell
#! nix-shell -i bash -p python310 python310Packages.deemix

# Uses deemix to download from deezer

# Temporary directory for storing config files
OPERAION_DIR="/tmp/download-deezer/"
# Music directory
DEST_DIR="/mnt/wolfpack/music"
# Url to download
URL="$1"

# Make sure OPERAION_DIR doesn't already exist, then create and enter it
rm -rf "$OPERAION_DIR"
mkdir "$OPERAION_DIR"
cd "$OPERAION_DIR" || exit

# Create necessary config files
mkdir "config"
touch "./config/config.json"

# Config Template
read -r -d '' CONFIG << EOM
{
  "downloadLocation": "$DEST_DIR",
  "tracknameTemplate": "%mainartists% - %title%",
  "albumTracknameTemplate": "%artists% - %tracknumber% - %title%",
  "playlistTracknameTemplate": "%position% - %artist% - %title%",
  "createPlaylistFolder": false,
  "playlistNameTemplate": "%playlist%",
  "createArtistFolder": true,
  "artistNameTemplate": "%artist%",
  "createAlbumFolder": true,
  "albumNameTemplate": "%album%",
  "createCDFolder": false,
  "createStructurePlaylist": true,
  "createSingleFolder": false,
  "padTracks": true,
  "paddingSize": "0",
  "illegalCharacterReplacer": "_",
  "queueConcurrency": 3,
  "maxBitrate": "3",
  "fallbackBitrate": true,
  "fallbackSearch": false,
  "logErrors": true,
  "logSearched": false,
  "saveDownloadQueue": false,
  "overwriteFile": "n",
  "createM3U8File": true,
  "playlistFilenameTemplate": "%title%",
  "syncedLyrics": false,
  "embeddedArtworkSize": 800,
  "embeddedArtworkPNG": false,
  "localArtworkSize": 1400,
  "localArtworkFormat": "jpg",
  "saveArtwork": true,
  "coverImageTemplate": "cover",
  "saveArtworkArtist": true,
  "artistImageTemplate": "folder",
  "jpegImageQuality": 80,
  "dateFormat": "Y-M-D",
  "albumVariousArtists": true,
  "removeAlbumVersion": false,
  "removeDuplicateArtists": false,
  "tagsLanguage": "",
  "featuredToTitle": "0",
  "titleCasing": "nothing",
  "artistCasing": "nothing",
  "executeCommand": "",
  "tags": {
    "title": true,
    "artist": true,
    "album": true,
    "cover": true,
    "trackNumber": true,
    "trackTotal": true,
    "discNumber": true,
    "discTotal": true,
    "albumArtist": true,
    "genre": true,
    "year": true,
    "date": true,
    "explicit": true,
    "isrc": true,
    "length": true,
    "barcode": true,
    "bpm": true,
    "replayGain": true,
    "label": true,
    "lyrics": true,
    "syncedLyrics": false,
    "copyright": true,
    "composer": true,
    "involvedPeople": true,
    "source": true,
    "savePlaylistAsCompilation": false,
    "useNullSeparator": false,
    "saveID3v1": true,
    "multiArtistSeparator": "default",
    "singleAlbumArtist": false,
    "coverDescriptionUTF8": false
  }
}
EOM
echo "$CONFIG" > "./config/config.json"

# Call deemix
python -m deemix --portable --path "$DEST_DIR" "$URL"

# Move the playlist file, if it exists
# if test -f "$DEST_DIR/playlist.m3u8"; then
#     PLAYLIST_DEST="$DEST_DIR$(echo "$URL" | rev | awk -F'/' '{ print $1 }' | rev).m3u8"
#     /bin/sed 's/^/.\//' "$DEST_DIR/playlist.m3u8" > "$PLAYLIST_DEST"
#     rm "$DEST_DIR/playlist.m3u8"
# fi

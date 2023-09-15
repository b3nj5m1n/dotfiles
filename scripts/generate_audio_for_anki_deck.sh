#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash piper-tts parallel

anki_deck="$1"
line_count=$(wc -l < "$anki_deck")
count_total=$((line_count - 6))
declare -x count_total

echo "0" > "/tmp/anki_audio_progress"

read_progress() {
    read -r progress < "/tmp/anki_audio_progress"
}
export -f read_progress

increase_progress() {
    read_progress
    progress=$((progress + 1))
    echo "$progress" > "/tmp/anki_audio_progress"
}
export -f increase_progress

audios="$HOME/.local/share/Anki2/User 1/collection.media/"
cd "$audios" || exit

echo ""

process_line() {
    read_progress
    line="$1"
    # 7 is the index of the column that audio will be generated for
    sentence=$(echo "$line" | awk -F "\t" '{print $7}')
    sha=$(echo "$sentence" | sha256sum | awk -F " " '{print $1}')
    if [ -f "$sha.wav" ]; then
        echo -e "$progress/$count_total \e[32m$sentence\e[0m"
        increase_progress
    else
        echo -e "$progress/$count_total \e[31m$sentence\e[0m"
        tts --model_name  tts_models/en/multi-dataset/tortoise-v2 \
            --text "$sentence" \
            --out_path "$sha.wav" \
            --progress_bar True \
            --voice_dir /tmp/tortoise-tts/tortoise/voices \
            --speaker_idx "lj" > /dev/null 2> /dev/null
        increase_progress
    fi
}

export -f process_line

tail -n+7 "$anki_deck" | parallel --line-buffer -j 3 process_line

# TODO
# Once finished, rewrite the CSV to include the new audio

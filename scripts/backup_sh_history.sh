#!/usr/bin/env sh

BACKUP_FILE="$1"
BACKUP_DIR="$(dirname "$BACKUP_FILE")"
ATUIN_FILE="$HOME/.local/share/atuin/history.db"

SILENT="$2"

cd "$BACKUP_DIR" || exit
git pull

NEW="$(
while read -d $'\x1E' -r row; do
    printf "%q\n" "$row"
done < <(sqlite3 -batch -noheader -ascii "$ATUIN_FILE" 'SELECT * FROM history;')
)"

CURRENT=$(cat "$BACKUP_FILE")

printf "%s\n%s" "$NEW" "$CURRENT" | sort | uniq > "$BACKUP_FILE"

"$HOME"/.local/share/bin/auto_commit.sh "$BACKUP_DIR" "$SILENT"

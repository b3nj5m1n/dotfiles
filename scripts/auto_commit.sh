#!/usr/bin/env sh
# shellcheck disable=SC2015

# Automatically commit all changes in the given git repository and push

REPO_DIR="$1"
SILENT="$2"

NAME="Commitbot"
EMAIL=""

# ----- ----- ----- Do not change anything below this line ----- ----- ----- #

unalias -a

fuckup() {
    echo "runnign test"
    cd "$REPO_DIR" || exit 1
    echo "$PWD"
    if git rev-parse --verify -q REBASE_HEAD >/dev/null 2>&1 \
        || git rev-parse --verify -q MERGE_HEAD >/dev/null 2>&1 \
        || [ "$(cd "$REPO_DIR" && git diff --name-only --diff-filter=U --relative | head -c1 | wc -c)" -ne 0 ] \
        ; then
        XDG_RUNTIME_DIR=/run/user/$(id -u) notify-send -u "critical" --wait "Something's gone very wrong: $REPO_DIR"&
        exit 1
    fi
}
fuckup

notify() {
    if [ "$SILENT" != true ]; then
        if command -v termux-setup-storage; then  
            termux-notification -c "$1"
        else
            XDG_RUNTIME_DIR=/run/user/$(id -u) notify-send "$1"
        fi
    fi
}

GIT_COMMITTER_NAME="$NAME"
GIT_COMMITTER_EMAIL="$EMAIL"

AUTHOR="$NAME <$EMAIL>"

read -r -d '' MESSAGE << EOM
$(date -u +"%a %d %b %Y %H:%M") [auto commit]

$(date +%s)
EOM

eval "$(keychain --dir "$HOME/.cache/keychain" --eval --quiet "{{ ssh_key_name }}")"

cd "$REPO_DIR" && git pull || notify "Failed pulling $REPO_DIR"
if [ "$(git status --porcelain)" ]; then
    cd "$REPO_DIR" && git add --all || notify "Failed staging changes in $REPO_DIR"
    cd "$REPO_DIR" && git -c user.name="$GIT_COMMITTER_NAME" -c user.email="$GIT_COMMITTER_EMAIL" commit --no-gpg-sign --author "$AUTHOR" -m "$MESSAGE" || notify "Failed committing changes in $REPO_DIR"
    cd "$REPO_DIR" && printf "%s\n" "$SSH_PW" | git push || notify "Failed pushing changes in $REPO_DIR"
fi
fuckup

notify "Done updating changes in $REPO_DIR"

date +%s > "/tmp/sync-status-$(echo "$REPO_DIR" | sha256sum | cut -d' ' --fields=1)"

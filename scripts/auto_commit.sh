#!/bin/bash

# Automatically commit all changes in the given git repository and push

REPO_DIR="$1"
SILENT="$2"

NAME="Commitbot"
EMAIL=""

# ----- ----- ----- Do not change anything below this line ----- ----- ----- #

unalias -a

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

eval $(keychain --dir "$HOME/.cache/keychain" --eval --quiet "{{ ssh_key_name }}")

cd "$REPO_DIR" && git pull || notify "Failed pulling $REPO_DIR"
if [[ $(git status --porcelain) ]]; then
    cd "$REPO_DIR" && git add --all || notify "Failed staging changes in $REPO_DIR"
    cd "$REPO_DIR" && git -c user.name="$GIT_COMMITTER_NAME" -c user.email="$GIT_COMMITTER_EMAIL" commit --no-gpg-sign --author "$AUTHOR" -m "$MESSAGE" || notify "Failed committing changes in $REPO_DIR"
    cd "$REPO_DIR" && printf "$SSH_PW\n" | git push || notify "Failed pushing changes in $REPO_DIR"
fi

notify "Done updating changes in $REPO_DIR"

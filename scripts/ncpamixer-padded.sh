#!/usr/bin/env sh

UUID="$(uuidgen)"

tmux new -s "$UUID" -d -c "/bin/ncpamixer"
tmux rename-window -t "$UUID" "PulseAudio Controll"
tmux send-keys -t "$UUID" "ncpamixer && tmux kill-window -t \"$UUID\"" C-m
tmux split-window -t "$UUID" -h ""
tmux resize-pane -t "$UUID" -x 1
tmux last-pane -t "$UUID"
tmux split-window -t "$UUID" -hb ""
tmux resize-pane -t "$UUID" -x 1
tmux last-pane -t "$UUID"

alacritty --working-directory "$HOME" --title "PulseAudio Controll" --command tmux attach -t "$UUID"

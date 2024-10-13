#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash gum

export YDOTOOL_SOCKET="/tmp/.ydotool_socket"
export SWAYSOCK="/run/user/1000/sway-ipc.1000.25003.sock"


# # Initialize a variable to store the PID of the running command
# command_pid=""

# # Listen to workspace events and toggle the command
# while true; do
#     command_pid=$(swaymsg -t subscribe '[ "workspace" ]' | while read -r line; do
#     if [ -z "$command_pid" ]; then
#       # If command_pid is empty, start the command and store its PID
#       ydotool click --repeat 100 --next-delay 25 0xC0 &
#       printf "%s" $!
#     else
#       # If command_pid is not empty, kill the command and reset command_pid
#       kill -9 "$command_pid"
#       printf ""
#     fi
#     break
#   done &)
# done


ydotool click --repeat 1 --next-delay 25 0xC0 &

sleep 1

ydotool click --repeat 100000000000 --next-delay 25 0xC0 &

trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT
swaymsg -t subscribe '[ "workspace" ]' | while read -r line; do
    exit
done

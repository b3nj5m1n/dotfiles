# Open a program and move it to a desktop

# First argument: Name of the program
programName="$1"
# Second argument: Desktop
desktopNumber="$2"

# Create oneshot rule
bspc rule -a $programName -o desktop=^$desktopNumber

# Start the program
$programName &

# # Get the pid of the program
# pid="$!"

# while [ -z "$wids" ]; do
#     # Get the associated window ids
#     wids=$(xdotool search --pid "$pid")
#     sleep 1
# done
# echo $wids


# while IFS= read -r line; do
#     bspc node "$line" -d ^"$desktopNumber"
# done <<< "$wids"


#!/usr/bin/env sh

### Query bpswm for desktop ids
# Query bspwm for all desktops
all=$(bspc query -D)
# Query bspwm for all desktops that have something on them
occupied=$(bspc query -D -d .occupied)
# Query bspwm for the current desktop
current=$(bspc query -D -d .focused)

### Color definitions
# Default background color
cdBACKGROUND=""
# Default foreground color
cdFOREGROUND="%fg-hex"
# Default underline color
cdFG=""
# Occupied underline color
coFG="%scd-hex"
# Focused underline color
cfFG="%prm-hex"

### Other variables
# Padding will be applied to both sides
padding=" "

# This variable will contain the output of the command
result=""
# Add default background color
result="$result%%{B$cdBACKGROUND}"
# Add default foreground color
result="$result%%{F$cdFOREGROUND}"
# Set command on scroll-up
result="$result%%{A4:bspc desktop -f prev; pkill lemonblocks -4:}"
# Set command on scroll-down
result="$result%%{A5:bspc desktop -f next; pkill lemonblocks -4:}"

# Loop over all lines (Desktop id's) of the all variable
while IFS= read -r line; do

    # Get the name of the current desktop
    name=$(bspc query -d "$line" -D --names)

    # The foreground for the current desktop
    fg="%%{F$cdFG}"

    # Check if the current desktop is occupied
    # if [[ "$occupied" == *"$(bspc query -d "$line" -D)"* ]];
    if [[ "$occupied" == *"$line"* ]];
    then
        # The desktop is occupied, use occupied underline color
        fg="%%{F$coFG}"
    fi

    # Check if the current desktop is focused
    if [[ "$current" == *"$line"* ]];
    then
        # The desktop is focused, use focused underline color
        fg="%%{F$cfFG}"
    fi


    # Add click event
    result="$result%%{A1:bspc desktop -f $name; pkill lemonblocks -4:}"

    # Add fg color
    result="$result$fg"

    # Add padding
    result="$result$padding"

    # Add the name to the ouput
    result="$result$name"

    # Add padding
    result="$result$padding"

    # Close click event
    result="$result%%{A1}"

done <<< "$all"

# Disable command on scroll-up
result="$result%%{A4}"
# Disable command on scroll-down
result="$result%%{A5}"

printf "$result"

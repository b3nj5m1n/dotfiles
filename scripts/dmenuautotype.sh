#!/bin/bash

# This script opens up dmenu and lists available passwords, the selection will then be autotyped

# Path to database file
filename="/home/b3nj4m1n/keeweb/b3n4m1n.kdbx"

# Get the master password to the database
password=$(rofi -dmenu -password  -p "Enter Master Password: " -l 0)
# Get all entrys from the database
entrys=$(echo "$password" | keepassxc-cli locate "$filename" "")
if [ $? -eq 0 ]; then
    echo OK
else
    echo FAIL
fi
# Let the user select one of the entrys
selection=$(echo "$entrys" | tail -n +2 | rofi -dmenu -p "> " )
# Get all the data of that entry
result=$(echo "$password" | keepassxc-cli show "$filename" "$selection")

# Username
un=$(echo "$result" | sed -n 's/UserName: //p')
# Password
pw=$(echo "$result" | sed -n 's/Password: //p')

# echo Username: $un
# echo Password: $pw

# Type Username
xdotool type --delay 100 "$un"
xdotool key Tab
xdotool type --delay 100 "$pw"
xdotool key Return


# echo "$result"

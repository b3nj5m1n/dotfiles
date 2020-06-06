#!/bin/bash

# This script opens up dmenu and lists available passwords, the selection will then be autotyped

# Id of active window
active_id=sdotool getactivewindow

# Path to database file
filename="/home/b3nj4m1n/keeweb/b3n4m1n.kdbx"

### There is no session password
if [ ! -f /tmp/inconspicuous.txt ]; then
    # Get the master password to the database
    password=$(dmenu -P -p "Enter Master Password: ")
    # Get all entrys from the database
    entrys=$(echo "$password" | keepassxc-cli locate "$filename" "")
    # If the command was successful (The master password is correct)
    if [ $? -eq 0 ]; then
        ### Ask for a password for the current session
        s_password=$(dmenu -P -p "Enter Session Password: ")
        ### Encrypt master password using session password
        e_password=$(echo "$password" | openssl enc -aes-128-cbc -a -pbkdf2 -iter 1000000 -salt -pass pass:"$s_password")
        ### Store encrypted master password
        echo "$e_password" > /tmp/inconspicuous.txt
        notify-send -a "CliPass" "New Session initialized" "A new session was initialized and your master password was saved encrypted by the session password. The session will be valid for as long as the file exists. (Until /tmp/ is cleared)"
    else
        exit
    fi
### There is a session password
else
    ### Ask for the password for the current session
    s_password=$(dmenu -P -p "Enter Session Password: ")
    ### Decrypt master password using session password
    password=$(cat /tmp/inconspicuous.txt | openssl enc -aes-128-cbc -d -a -pbkdf2 -iter 1000000 -salt -pass pass:"$s_password")
    # Get all entrys from the database
    entrys=$(echo "$password" | keepassxc-cli locate "$filename" "")
    # If the command was successful
    if [ $? -eq 0 ]; then

        # Let the user select one of the entrys
        selection=$(echo "$entrys" | tail -n +2 | dmenu -p "> " )
        # Get all the data of that entry
        result=$(echo "$password" | keepassxc-cli show "$filename" "$selection")

        # Username
        un=$(echo "$result" | sed -n 's/UserName: //p')
        # Password
        pw=$(echo "$result" | sed -n 's/Password: //p')

        # echo Username: $un
        # echo Password: $pw

        # Type Username
        xdotool type --window "$active_id" --delay 100 "$un"
        xdotool key --window "$active_id" Tab
        xdotool type --window "$active_id" --delay 100 "$pw"
        xdotool key --window "$active_id" Return
    else
        exit
    fi
fi

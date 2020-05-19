# dotfiles

Collection of my dotfiles as well as a bunch of scripts.

![](./imgs/screenshot.png)

# Scripts
## ./conf-files-updater.sh
Automatically copys all config files from this directory to where they should be on the system

# ./package-installer.sh
Automatically installs all packages with the installed package manager, can also install other stuff like:
- yay
- picom
- omf (Oh my fish)
- cli-visualizer
- vim-plug
(These require building from source or some other kind of special install)

# ./scripts/dmenuautotype.sh
Script for automatically typing passwords from a kdbx database.

To start a new session, simply run the script. Then type in the masterpassword for the database. You will now be presented with a prompt to enter a session password, this password will be valid until you restart your computer.

Now if you call the script again, you just have to enter your session password to gain access to the database. A dmenu (Through rofi) will open with a list of all passwords stored in the database. Upon selection, the username will be automatically typed to the window that was focused prior to calling the script, followed by a tab (To get from the username field to the password field), the password and enter (to login).

The master password is encrypted by the session password using aes, the encrypted password is then stored in a txt file in the /tmp/ folder. You can easily modify this script to always ask for the master password if that is not secure enough for you.

# ./scripts/dmenuunicode.sh
Opens a dmenu with a list of all unicode emojis, selection will be typed or copied to clipboard. Credit for this goes to Luke Smith, see file for a link.

# ./scripts/fav-song.sh
Puts the currently playing song into a favorites playlist (m3u file). Can write to other playlists as well when called with parameters.
Requires cmus.

# ./scripts/lock.sh
Locks the screen using i3-lock, uses blurred image of screen as background. [Credit](https://github.com/petvas/i3lock-blur)

# ./scripts/reimport-playlits-cmus.sh
REMOVES ALL PLAYLISTS FROM CMUS, then reimports all m3u files from a directory. Will restart cmus in the process.

# ./scripts/wally.sh
Script for managing wallapers. Can pick a random wallpaper from a list; Can be sorted by tags.

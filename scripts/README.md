# Scripts

### ./take-screenshot.sh
Select an area on screen and take a screenshot of the selected area.
### ./fav-song.sh
Add the currently playing song to a playlist of choice. Filtert to only show playlists starting with `a.`.
### ./draw-terminal.sh
Select an area on screen and get a floating terminal with the selected dimensions.
### ./play-song.sh
Bring up a dmenu with every mp3 in a given directory, play the selection.
### ./keyboard-layout-switcher.sh
Bring up a dmenu with available keyboard layouts, switch to the selection.
### ./reimport-playlists-cmus.sh
Deletes all playlists in cmus, then imports all m3u files from a given directory.
### ./insert-emoji.sh
Bring up a dmenu with emojis, copy/insert the selection.
### ./lock.sh
Lock input.
### ./wally.sh
Script for switching wallpapers. This is horrible, do yourself a favor and don't use this script.

## Polybar
### ./polybar/cmus.sh
Displays the currently playing song title, indicates the progress by coloring part of the title.

## Legacy
### ./legacy/dwmblocks/cmus.sh
Breaks on longer titles.
### ./legacy/dwmblocks/keyboard-layout.sh
Displays the current keyboard layout.
### ./legacy/dwmblocks/time.sh
Displays the current time.
### ./legacy/encrypt.sh
Part of an abandonend project.
### ./legacy/keepass-autotype.sh
On first startup, enter the master password to a kdbx file and provide a session password.
The master password will be saved, encrypted with the session password.
On every startup where such a save file exists, 
enter the session password to bring up dmenu with every entry in the database.
The selected entry will be auto-typed (Type username, tab, password, enter).
I don't know how secure this is, so I would advise against using it.
(Also if you have multiple entry with the same name, it will type the first one)
Instead, use a proper keepass client like keeweb, I wrote a plugin for that to utilize dmenu.
### ./legacy/unzip_configs.sh
Part of an abandonend project.
### ./legacy/zip_configs.sh
Part of an abandonend project.
### ./legacy/decrypt.sh
Part of an abandonend project.


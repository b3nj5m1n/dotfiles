# screenshots

## bspwm
![bspwm](https://i.imgur.com/muvVu7x.png)
![bspwm](https://i.imgur.com/tIWBDqA.png)

<details>
    <summary>[old] bpswm</summary>
    <img src="https://i.imgur.com/FW7iDir.png" alt="">
</details>
<details>
    <summary>[old] i3-gaps</summary>
    <img src="https://i.imgur.com/s18UaNz.png" alt="">
</details>

# dotfiles

## This repo includes my config for the following programs:
* lightdm [Config]
* bpswm [Config/Colorscheme]
* zsh [Config/Colorscheme/Prompt]
* sxhkd [Config]
* picom [Config]
* polybar [Config]
* neovim [Config/Colorscheme]
* vim-airline [Config/Colorscheme]
* alacritty [Config/Colorscheme]
* cmus [Config/Colorscheme]
* dunst [Config/Colorscheme]
* ranger [Config]
* cli-visualizer [Config/Colorscheme]

## ./conf-files-updater.sh
This script automatically copys all the config files to the correct dirs on the system.
Use with caution.
There is also a version of this script in the legacy directory for the config files of programs I no longer use.

## ./package-installer.sh
This script used to install a bunch of programs using the available package manager.
I have ditched this now because I exclusively use arch and can therefore use a metapackage.
Now this script can autmatically install some stuff that is not in mainline repos. (It doesn't work that well)
Available is:
* --yay (Auto installs the aur helper on an arch based system, works somewhat reliably)
* --picom (For non arch distros, clones git repo and builds from source)
* --omf (Installs oh my fish)
* --cli-visualizer (Clones git repo and builds from source)
* --vim-plug (Install plug plugin manager for vim and neovim)

## ./update.sh
This script is pretty old now, it used to be a combination of the two mentioned above.
The remaining functionality is:
* -h (Diplays the current number of commits in this repo)
* --lightdm (Enables lightdm service)
* --ycp (Runs install script of you complete me)
* --nerd-fonts (Clones full nerd fonts repo and installs UbuntuMono)

## other/
### arch-linux-installation-guide.md
The arch installation guide I wrote, specific to this dotfiles repo.
Following it should get you to a setup exactly like mine, but I can't gurantee completeness.
### color_pallete.css
Contains the colors I use for all my custom color schemes.
### fonts
Contains the names of some of the fonts I use.
### arch-meta/
Contains a meta package with most of the programs I use.

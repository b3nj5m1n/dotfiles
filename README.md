# screenshots

## bspwm

![bspwm](https://i.imgur.com/7qgwfxA.png)

<details>
    <summary>[old] bpswm</summary>
    <img src="https://i.imgur.com/0y2oj9p.jpg" alt="">
</details>
<details>
    <summary>[old] bpswm</summary>
    <img src="https://i.imgur.com/NLPsol2.png" alt="">
    <img src="https://i.imgur.com/AWBphLn.png" alt="">
    <img src="https://i.imgur.com/muvVu7x.png" alt="">
    <img src="https://i.imgur.com/tIWBDqA.png" alt="">
</details>
<details>
    <summary>[old] bpswm</summary>
    <img src="https://i.imgur.com/FW7iDir.png" alt="">
</details>
<details>
    <summary>[old] i3-gaps</summary>
    <img src="https://i.imgur.com/s18UaNz.png" alt="">
</details>

# dotfiles

## This repo includes my config for the following programs (You can find them in the files/ directory):
* lightdm [Config]
* bpswm [Config/Colorscheme]
* zsh [Config/Colorscheme/Prompt]
* sxhkd [Config]
* picom [Config]
* neovim [Config/Colorscheme]
* vim-airline [Config/Colorscheme]
* alacritty [Config/Colorscheme]
* dunst [Config/Colorscheme]
* ranger [Config]
* cli-visualizer [Config/Colorscheme]
* lemonbar [Config/Scripts]

## ./bay.sh
This script automatically calls 3 other scripts located in the scripts folder: load-bay.sh, process-bay.sh and unload-bay.sh

The first script will copy all of my config files into the bay directory whilst creating the appropriate directory struture.

The second script will then replace all of the placeholders in my config files with the values that should go there, according to the choosen placeholder file. For now these are color values.

The last script then copys all of the files from the bay directory onto the actual root filesystem.

In praxis this allows me to change color schemes for all of my programs in a few seconds.

## other/
### arch-linux-installation-guide.md
The arch installation guide I wrote, specific to this dotfiles repo.
Following it should get you to a setup exactly like mine, but I can't gurantee completeness.
### color_pallete.css
Contains the colors I use for all my custom color schemes.
### fonts
Contains the names of some of the fonts I use.
### arch-meta/
Contains a meta package with most of the programs I use. (Not exactly up to date)

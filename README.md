# screenshots

## bspwm

<img src="https://i.imgur.com/PUtsTpf.png" alt="">

<details>
    <summary>[old] bpswm</summary>
    <img src="https://i.imgur.com/7qgwfxA.png" alt="">
</details>
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
* (neo)mutt
* (neo)vim
* alacritty
* anki
* bpswm
* cli-visualizer
* dunst
* emacs (doom)
* lemonbar
* lightdm
* picom
* ranger
* sxhkd
* tmux
* zsh

## ./bay.sh
This script automatically calls 3 other scripts located in the scripts folder: load-bay.sh, process-bay.sh and unload-bay.sh

The first script will copy all of my config files into the bay directory whilst creating the appropriate directory struture.

The second script will then replace all of the placeholders in my config files with the values that should go there, according to the choosen placeholder file. For now these are color values.

The last script then copys all of the files from the bay directory onto the actual root filesystem.

In praxis this allows me to change color schemes for all of my programs in a few seconds.


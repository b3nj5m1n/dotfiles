<div align="center"> 
<img src="./docs/amazing_banner.svg" alt="banner" width="80%">
<hr>
<p><b>Behold, the dots</b></p>
</div>

## Overview

I keep all my dotfiles in this repository. I tried my best to organise them in a way that makes sense, so here's a quick rundown of the general structure.

If you're looking for the config files for a specific program, you're going to want to look in `files/`. Most notably, here you'll find my config for neovim, my window manager, tmux and my shell.

If you're looking for my NixOS configuration, unsuprisingly, you'll find it in `nix/`.

If you're looking for my scripts, also unsuprisingly, you'll find them in `scripts/`.

**You can't just copy paste a lot of these files.**

I use [dotter](https://github.com/SuperCuber/dotter) to manage my dotfiles, so some of my config files have placeholders that will be replaced by a `dotter deploy`. Generally, these look like `{{ variable }}`, and I use them for colors, to disable modules in my statusbar based on the host (for example, display a battery module on my laptop, but not on my desktop), and a bunch of other stuff.

You can look in `.dotter/` to see my config for different hosts, all the variables, where the config files actually get copied to, etc.

Finally, I keep some documentation in `docs/`. Here, you'll find my arch install guide, for example, and some general notes about stuff that was unnecessarily difficult to set up.

## Current Setup

I'm currently using [Arch Linux](https://archlinux.org/) on my desktop and [NixOS](https://nixos.org/) on my laptop. I've been using Arch as my daily driver for more than 2 years now, and it's definitely a great distro, but NixOS is very promising so far, so we'll see if I switch to it completely.

On my desktop, I'm running [bspwm](https://github.com/baskerville/bspwm). I've been using it forever and honestly wouldn't really recommend it. There's a lot of things you have to manually do with shell scripts to get it working well, and I've had several of my scripts randomly stop working in the past. It's also not actively developed (it's considered feature complete, so this is not necessarily a bad thing) and, in my experience, not very performant. If I were to start over, I'd probably choose [awesome](https://github.com/awesomeWM/awesome/) instead. Since I'm planning to over move to wayland anyways though, I haven't bothered to set up awesome properly myself.

On my laptop, I'm running [sway](https://github.com/swaywm/sway). My first tiling WM was [i3](https://github.com/swaywm/sway), so it's quite familiar, and my experience so far has been very good. I'll probably try out other wayland compositors though before I fully switch to wayland on my desktop. I'm considering trying out [hyprland](https://github.com/hyprwm/Hyprland/) and [river](https://github.com/riverwm/river), but they're both not very mature software.

There's some tools that are specific to X (bspwm) or wayland (sway), like rofi/wofi/tofi, but for the most part, the rest of my setup is shared across both of my machines, as well as my raspberry pi.

I use [neovim](https://github.com/neovim/neovim) as my texteditor. I've used [emacs](https://github.com/doomemacs/doomemacs) in the past, I liked it, but I prefer something more lightweight. I use a ton of plugins for neovim, you can find my full configuration in `files/nvim/`. My config is currently written in [fennel](https://fennel-lang.org/). I wrote my entire config in [neorg](https://github.com/nvim-neorg/neorg), but unfortunately, getting the required dependencies to extract all code blocks using tree-sitter is a bit of a hassle, so for now I've copied everything over to `config.fnl` and commented out the norg parts.

I use the terminal for almost everything, so I have a fairly extensive shell configuration. `files/shrc/shrc.sh` is shared across bash and zsh, bash and zsh each have a little bit of their own config as well though. You'll find all of my aliases, enviornment variables and some of the cli tools I use in these files. Most notably, I use [atuin](https://github.com/ellie/atuin) to manage my shell history, I use [zoxide](https://github.com/ajeetdsouza/zoxide) to make `cd` more powerful, and I use [starship](https://github.com/starship/starship) to generate my shell's prompt. I highly recommend all 3 of those.

I've also recently started using [eww](https://github.com/elkowar/eww) for my status bar, and I wrote a little helper program called [pfui](https://github.com/b3nj5m1n/pfui) to generate some of the data for my statusbar.

Finally, I'd like to congratulate myself on 1000 commits. Here's to a 1000 more 🥂.

## History

Here, you'll find a gallery of screenshots from past setups.

<details>
<summary>Old screenshots</summary>
<p align="center"> 
<img src="https://raw.githubusercontent.com/b3nj5m1n/bigconf/master/imgs/03-01-21_31-52-01.png" alt="">
<img src="https://raw.githubusercontent.com/b3nj5m1n/bigconf/master/imgs/03-01-21_01-53-01.png" alt="">
<br>
<span>Bspwm - <i>2021-01-03</i></span>
</p>

<p align="center"> 
<img src="https://i.imgur.com/PUtsTpf.png" alt="">
<br>
<span>Bspwm - <i>2020-12-11</i></span>
</p>

<p align="center"> 
<img src="https://i.imgur.com/7qgwfxA.png" alt="">
<br>
<span>Bspwm - <i>2020-11-24</i></span>
</p>

<p align="center"> 
<img src="https://i.imgur.com/0y2oj9p.jpg" alt="">
<br>
<span>Bspwm - <i>2020-07-20</i></span>
</p>

<p align="center"> 
<img src="https://i.imgur.com/NLPsol2.png">
<img src="https://i.imgur.com/AWBphLn.png">
<img src="https://i.imgur.com/muvVu7x.png">
<img src="https://i.imgur.com/tIWBDqA.png">
<br>
<span>Bspwm - <i>2020-06-20</i></span>
</p>

<p align="center"> 
<img src="https://i.imgur.com/FW7iDir.png" alt="">
<br>
<span>Bspwm - <i>2020-06-02</i></span>
</p>

<p align="center"> 
<img src="https://i.imgur.com/s18UaNz.png" alt="">
<br>
<span>i3-gaps - <i>2020-05-10</i></span>
</p>
</details>

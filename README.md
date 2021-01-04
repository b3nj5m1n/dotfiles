# Dotfiles

I use arch btw.

I also use doom emacs, neovim, tmux, bspwm, ncmpcpp, neomutt, the list goes on. You can find the config files for all of those in this repository, I use [dotter](https://github.com/SuperCuber/dotter) to manage my dotfiles.

![neovim](https://raw.githubusercontent.com/b3nj5m1n/bigconf/master/imgs/03-01-21_31-52-01.png)
![emacs](https://raw.githubusercontent.com/b3nj5m1n/bigconf/master/imgs/03-01-21_44-52-01.png)
![ncmcpp](https://raw.githubusercontent.com/b3nj5m1n/bigconf/master/imgs/03-01-21_01-53-01.png)

## Deploying

You'll need a few programs to do an inital minimal deploy.
This will set up a usable shell-enviorment.

Before you can get started, you'll need to install git, which should be in the standard repositorys of every distro, and clone my dotfiles repository:
```sh
git clone git@github.com:b3nj5m1n/dotfiles.git
```
You'll also need rust, more specifically cargo, to install everything you need:
```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
```sh
rustup install stable
rustup default stable
```


You're now ready to build and install dotter:
```sh
cargo install dotter
```
Pick a profile to deploy or build your own, put it in .dotter as local.toml (For example `cp profiles/desktop.toml .dotter/local.toml`)
You should now be able to do your inital deploy:
```sh
sudo dotter deploy --force
```
Afterwards, you'll need to fix the permissions.
Do this for the .config dir, and every file that gives you a permission error when you execute `dotter deploy` (Without sudo):
```sh
sudo chown $USER ~/.config/**
```
If you run into problems with the cache:
```sh
rm -rf .dotter/cache*
```
From now on, this should work without any errors and in a fraction of a second:
```sh
dotter deploy
```

You'll need the following programs to take full advantage of the configs (All of them are aliased so you can use the normal program names):

- tmux (Terminal multiplexer) (Should be in every distros default repository)
- zsh (Shell) (Should be in every distros default repository)
- starship (Prompt) (`cargo install starship`)
- zoxide (Better cd) (`cargo install zoxide`)
- exa (Better ls) (`cargo install exa`)
- fd (Better find) (`cargo install fd-find`)
- sd (Better sed) (`cargo install sd`)
- skim (fzf but rust) (`cargo install skim`)
- ripgrep (better grep) (`cargo install ripgrep`)
- procs (better ps) (`cargo install procs`)
- dust (better du) (`cargo install du-dust`)
- bottom (better top) (`cargo install bottom`)
- bat (better cat) (`cargo install bat`)

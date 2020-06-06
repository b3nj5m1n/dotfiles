source /home/b3nj4m1n/.config/zsh/antigen.zsh

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 4
zstyle ':completion:*' menu select=3
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' substitute 1
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/b3nj4m1n/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=9999
SAVEHIST=999999
setopt autocd

# End of lines configured by zsh-newuser-install


######################### Antigen #########################

antigen use oh-my-zsh

##### Plugins #####

# antigen bundle zsh-users/zsh-autosuggestions
antigen bundle softmoth/zsh-vim-mode
antigen bundle zsh-users/zsh-syntax-highlighting

##### Themes #####

# antigen theme robbyrussell
antigen theme cloud
# antigen theme af-magic

antigen apply

bindkey -v
export KEYTIMEOUT=1


export EDITOR=nvim

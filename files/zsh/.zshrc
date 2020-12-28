if [ $(($RANDOM % 4)) -eq $((1)) ]; then
    pfetch
fi

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

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
HISTSIZE=9999999
SAVEHIST=9999999
setopt autocd

# End of lines configured by zsh-newuser-install

##### Prompt #####

# fpath+=$XDG_CONFIG_HOME/zsh/pure
# autoload -U promptinit; promptinit
# zstyle :prompt:pure:prompt color "%c5-hex"
# zstyle :prompt:pure:path color "%c6-hex"
# zstyle :prompt:pure:user color "%c2-hex"
# zstyle :prompt:pure:host color "%c10-hex"
# git:branch
# git:dirty
# git:action
# git:arrow
# git:stash
# execution_time
# prompt pure

# Vi key bindings
bindkey -v
export KEYTIMEOUT=1

# Enable Ctrl + Backspace to delete word backwards
bindkey '^H' backward-kill-word
# Enable deleting last char on a line & going back to the previous one
bindkey -v '^?' backward-delete-char
# Enable skipping words with Ctrl + Arrow Keys
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
# History Search
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^F' history-incremental-pattern-search-forward
bindkey -M vicmd '/' history-incremental-pattern-search-backward
bindkey -M vicmd '?' history-incremental-pattern-search-forward
bindkey "^z" history-beginning-search-backward
bindkey "^u" history-beginning-search-forward

autoload edit-command-line; zle -N edit-command-line
# Space in normal mode to edit current line in editor buffer
bindkey -M vicmd ' ' edit-command-line

# Use starship prompt
eval "$(starship init zsh)"
# Source common aliases, exports, etc.
source ~/.config/shrc

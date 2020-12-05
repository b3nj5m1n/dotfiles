if [ $(($RANDOM % 4)) -eq $((1)) ]; then
    pfetch
fi

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# export ADOTDIR=$XDG_CONFIG_HOME/antigen
# source /home/b3nj4m1n/.config/zsh/antigen.zsh

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
HISTSIZE=9999
SAVEHIST=999999
setopt autocd

# End of lines configured by zsh-newuser-install


######################### Antigen #########################

# antigen use oh-my-zsh

##### Plugins #####

# antigen bundle zsh-users/zsh-syntax-highlighting
# antigen bundle zsh-users/zsh-autosuggestions
# antigen bundle softmoth/zsh-vim-mode

##### Themes #####

# antigen theme robbyrussell
# antigen theme cloud
# antigen theme af-magic

# antigen apply

##### Prompt #####

fpath+=$XDG_CONFIG_HOME/zsh/pure
autoload -U promptinit; promptinit
prompt pure

# if [[ -z $ZSH_THEME_CLOUD_PREFIX ]]; then
#     ZSH_THEME_CLOUD_PREFIX='%{%G%}'
# fi

# PROMPT='%{$fg_bold[green]%}%p %{$FG[%prm-xterm]%}%c %{$fg_bold[cyan]%}$(git_prompt_info)%{$fg_bold[blue]%}% %{$fg_bold[green]%}$ZSH_THEME_CLOUD_PREFIX %{$reset_color%}'

# ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$FG[%prm-xterm]%}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}]%{$FG[%prm-xterm]%}%{%G⚡%}%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}]"


# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#737373"


bindkey -v
export KEYTIMEOUT=1


export EDITOR=nvim

autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd ' ' edit-command-line

# Default/Prefered gpg profile to use
export DFGPGPROFILE="9F7D2083BB220CEEB720E068309D4C8689849C5B"

# Alias for copying output of a command to clipboard
alias cpy='xclip -selection clipboard'
# Alias for hiding terminal when starting certain programs
alias zathura='devour zathura'
alias feh='devour feh'

# Clean up home dir
## adb
alias yarn="yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME}/notmuch-config"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"
export INPUTRC="${XDG_CONFIG_HOME}/shell/inputrc"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export WINEPREFIX="${XDG_DATA_HOME}/wineprefixes/default"
export KODI_DATA="${XDG_DATA_HOME}/kodi"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME}/android"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export GOPATH="${XDG_DATA_HOME}/go"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible/ansible.cfg"
export UNISON="${XDG_DATA_HOME}/unison"
export HISTFILE="${XDG_DATA_HOME}/history"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export VSCODE_PORTABLE="$XDG_DATA_HOME/vscode"
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export GEM_HOME="$XDG_DATA_HOME/gem"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"

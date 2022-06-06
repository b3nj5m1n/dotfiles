# XDG enviorment variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

############### Enviornment Variables ###############

# Default Programs
export EDITOR=nvim
export FUZZY_FINDER=sk

# Use difftastic for git diffing
export GIT_EXTERNAL_DIFF=difft

# Use vim keybindings for mcfly
export MCFLY_KEY_SCHEME=vim

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Default/Prefered gpg profile to use
export DFGPGPROFILE="9F7D2083BB220CEEB720E068309D4C8689849C5B"

# Use bat for colorized manpages
export MANPAGER="sh -c 'col -bx | bat --theme=Dracula -l man -p'"

export TERM=alacritty-full

# {{#if force_terminfo}}
# # Enable tmux & emacs to run properly
# export TERM=xterm-256color-full
# {{/if}}


############### Functions ###############
source /usr/bin/scripts/colors.sh

function update_normal_pacman {
    pacman -Syy
}
function update_normal {
    yay -Syy
}
function upgrade_normal_pacman {
    pacman -Quq | while read p; do pacman -S $p --noconfirm --needed || echo $p >>pacman-failed.log; done
}
function upgrade_normal {
    yay -Quq --repo | while read p; do yay -S $p --noconfirm --noremovemake --nocleanafter --answerclean None --answerdiff None --answeredit None --needed --sudoloop || echo $p >>yay-failed.log; done
}
function upgrade_aur {
    yay -Quq --aur | while read p; do yay -S $p --noconfirm --noremovemake --nocleanafter --answerclean None --answerdiff None --answeredit None --needed --sudoloop || echo $p >>yay-failed.log; done
}
function instl {
    yay -S $1 --noconfirm --noremovemake --nocleanafter --answerclean None --answerdiff None --answeredit None --needed --sudoloop
}
function update {
    update_normal
    upgrade_normal
    upgrade_aur
}

# Show an interacitve help menu with all defined and commented aliases
function alias_help {
    /usr/bin/cat ~/.config/shrc | grep -E "alias \w+='.+' #" | /usr/bin/sed -n -r 's/alias (\w+)=.+# (.+)$/\1 - \2/p' | $FUZZY_FINDER
    # You could also write this as an alias like this:
    # alias ahelp='/usr/bin/cat ~/.config/shrc | grep "alias \w+='\''.+'\'' #" | /usr/bin/sed -n -r '\''s/alias (\w+)=.+# (.+)$/\1 - \2/p'\'' | $FUZZY_FINDER' # List all available aliases
}


############### Aliases ###############

alias ahelp="alias_help" # List all available aliases

alias sx='systemctl suspend && exit' # Suspend

alias pac='paru --skipreview --bottomup --noremovemake --nocleanafter --sudoloop --pgpfetch --batchinstall' # Package manager

alias cl='ros exec cl-repl' # Common Lisp repl

alias myip='curl "https://api.ipify.org"' # Get public ip adress

alias yeetread='tspreed -w 400 -l -i -f' # Read with the power of the yeet

alias mkexe='sudo chmod +x' # Make executable

# Git
alias g='git' # Git
alias ga='git add' # Git add
alias gaa='git add --all' # Git add all unstaged changes
alias gr='git remove' # Git unstage/remove
alias gc='git commit' # Git commit
alias gl='git log' # Git log
alias gca='git commit --amend' # Git ammend
alias gp='git push' # Git push
alias gpl='git pull' # Git pull
alias gf='git fetch' # Git fetch
alias gst='git status' # Git status
alias gsd='git diff --staged' # Git show diff (Diff of current staged area)
alias grt='cd $(git rev-parse --show-toplevel)' # Jump to the root of the git repository
alias gsb='git switch $(git branch | sd "[ |*]" "" | $FUZZY_FINDER)' # Git interacitvely switch branche
alias grb='git branch -d $(git branch | sd "[ |*]" "" | $FUZZY_FINDER)' # Git interacitvely delete branche
function git_search_commits() { 
    git --no-pager log --pretty="%s|%cn|%cr|%h" | awk -F'|' '{ printf "%s... by %s, %s (%s)\n", $1=substr($1,1,25), $2, $3, $4 }' | sk | /usr/bin/sed -n -r 's/^.*\((\w+)\)$/\1/p'
}
alias gsc='git_search_commits' # Search git commits

# .. for moving up one directory in shells where that isn't supported
alias ..='cd ..'
# Always use sudo when running pacman
alias pacman='sudo pacman'

# Alias for opening files with emacsclient
alias emcs='emacsclient --tty' # Open emacs in terminal
alias emcS='devour emacsclient --create-frame' # Open emacs in GUI and hide the terminal window
alias emCS='emacsclient --create-frame' # Open emacs in GUI

# Alias for copying output of a command to clipboard
alias cpy='xclip -selection clipboard' # Copy piped command output to clipboard

# Aliases for hiding terminal when starting certain programs
alias zathura='devour zathura'
alias feh='devour feh --keep-zoom-vp'
alias mpv='devour mpv'

# Exa (ls replacement)
alias ls='exa --grid --icons'
alias ll='exa --long --icons'
alias la='exa --long --all'
alias l='exa --grid --across'
alias tree='exa --tree --icons'

# zoxide (cd replacement)
alias cd='z'

# skim (fzf replacement)
alias fzf='sk'

# RipGrep (grep replacement)
alias grep='rg --no-line-number'

# fd (find replacement)
alias find='fd'

# Procs (ps replacement)
alias ps='procs'

# Dust (du replacement)
alias du='dust'

# Bottom (top replacement)
alias top='btm'
alias htop='btm'

# Bat (cat replacement)
alias cat='bat --paging=never --theme=Dracula --style="numbers,changes" --italic-text=always'
alias ct='bat --paging=never --theme=Dracula --style="plain" --italic-text=always'

# Duf (df replacement)
alias df='duf'


############### Boring Stuff ###############

# Clean up home dir by moving some dotfiles to the XDG directories they should be in by default
alias mbsync='mbsync -c "$XDG_CONFIG_HOME/isync/mbsyncrc"'
alias yarn="yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME}/android"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible/ansible.cfg"
export ANSIBLE_HOME="${XDG_DATA_HOME}/ansible"
export CABAL_CONFIG="$XDG_CONFIG_HOME/cabal/config"
export CABAL_DIR="$XDG_CACHE_HOME/cabal"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export ELM_HOME="$XDG_CACHE_HOME/elm"
export ERRFILE="$XDG_CACHE_HOME/X11/xsession-errors"
export GEM_HOME="$XDG_DATA_HOME/gem"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
export GHCUP_USE_XDG_DIRS=true
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GOPATH="${XDG_DATA_HOME}/go"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export GRIPHOME="$XDG_CONFIG_HOME/grip"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc-2.0"
export HISTFILE="${XDG_DATA_HOME}/history"
export INPUTRC="${XDG_CONFIG_HOME}/shell/inputrc"
export JDK_HOME="/usr/lib/jvm/default"
export JDTLS_HOME="/usr/share/java/jdtls"
export KODI_DATA="${XDG_DATA_HOME}/kodi"
export LESSHISTFILE="-"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME}/notmuch-config"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export ROSWELL_HOME="$XDG_DATA_HOME/roswell"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"
export STACK_ROOT="$XDG_DATA_HOME"/stack
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export UNISON="${XDG_DATA_HOME}/unison"
export VSCODE_PORTABLE="$XDG_DATA_HOME/vscode"
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"
export WINEPREFIX="${XDG_DATA_HOME}/wine"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"

# Path variable
export PATH="$PATH:$CARGO_HOME/bin"
export PATH="$PATH:$GEM_HOME/ruby/2.7.0/bin/"
export PATH="$PATH:$HOME/.rvm/bin"

# Task nag when doing a task that's not top priority
export TASK_NAG="I desire that we be better strangers."

# Enable colored output wherever that isn't the default
# alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
# alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# alias ll='ls -alF'
# alias la='ls -A'
# alias l='ls -CF'

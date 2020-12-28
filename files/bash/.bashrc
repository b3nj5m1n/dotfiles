
#
# ~/.bashrc
#

# Auto generated stuff

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# Custom Stuff

# Prompt

# # Colors
# PINK="\[\033[38;5;13m\]"
# AQUA="\[\033[38;5;49m\]"
# RED="\[\033[38;5;197m\]"
# # Modifiers
# RESET="\[$(tput sgr0)\]"
# BOLD="\[$(tput bold)\]"
# # Components
# OPEN_BRACKET="["$RESET
# CLOSING_BRACKET="]"$RESET
# TIME_HH_MM_XM="\@"$RESET
# STATUS_CODE="\$?"$RESET
# USER="\u"
# HOST="\h"
# WDIR="\W"

# # Bold Aqua Bracket
# PS1=$BOLD$AQUA$OPEN_BRACKET
# # Bold Pink Time
# PS1=$PS1$BOLD$PINK$TIME_HH_MM_XM
# # Space
# PS1=$PS1" "
# # Bold Aqua Question mark
# PS1=$PS1$BOLD$AQUA"?"
# # Space
# PS1=$PS1" "
# # Bold Pink Exit code
# PS1=$PS1$BOLD$PINK$STATUS_CODE
# # Bold Aqua Bracket
# PS1=$PS1$BOLD$AQUA$CLOSING_BRACKET
# # New Line
# PS1=$PS1"\n"
# # Bold Aqua Bracket
# PS1=$PS1$BOLD$AQUA$OPEN_BRACKET
# # Pink User
# PS1=$PS1$PINK$USER
# # Aqua @
# PS1=$PS1$AQUA"@"
# # Pink Host
# PS1=$PS1$PINK$HOST
# # Space
# PS1=$PS1" "
# # Bold Aqua >
# PS1=$PS1$BOLD$AQUA">"
# # Space
# PS1=$PS1" "
# # Pink Working Dir
# PS1=$PS1$PINK$WDIR
# # Bold Aqua Bracket
# PS1=$PS1$BOLD$AQUA$CLOSING_BRACKET
# # Red $
# PS1=$PS1$RED"$"
# # Space
# PS1=$PS1" "
# # Reset
# PS1=$PS1$RESET

# export PS1=$PS1

# Use starship prompt
eval "$(starship init bash)"
# Source common aliases, exports, etc.
source ~/.config/shrc

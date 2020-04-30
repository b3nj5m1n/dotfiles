#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
# PS1='[\u@\h \W]\$ '
export PS1="\[$(tput bold)\]\[\033[38;5;6m\][\[$(tput sgr0)\]\[\033[38;5;197m\]\$?\[$(tput sgr0)\] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;6m\]?\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;161m\]\@\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;6m\]]\[$(tput sgr0)\] \n\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;6m\][\[$(tput sgr0)\]\[\033[38;5;161m\]\u\[$(tput sgr0)\]\[\033[38;5;6m\]@\[$(tput sgr0)\]\[\033[38;5;197m\]\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;44m\]>\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;161m\]\W\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;6m\]]\[$(tput sgr0)\]\[\033[38;5;197m\]\\$\[$(tput sgr0)\]"
export EDITOR=vim

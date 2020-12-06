#!/usr/bin/fish

fish_vi_key_bindings
function fish_mode_prompt
end
function fish_greeting
end

# function fish_prompt
#     set_color purple
#     date "+%m/%d/%y"
#     set_color FF0
#     echo (pwd) '>' (set_color normal)
# end

######################## Aliases ########################
##### Auto Color #####
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
##### Other #####
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ..='cd ..'

######################## Abbreviations ########################
abbr -a cpy='xclip -selection clipboard'

# Use starship prompt
starship init fish | source

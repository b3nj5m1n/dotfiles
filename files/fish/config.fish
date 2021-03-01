#!/usr/bin/fish

fish_vi_key_bindings
function fish_mode_prompt
end
function fish_greeting
end

# Start ssh agent
export SSH_AUTH_SOCK=~/.ssh/ssh-agent.sock
# test whether $SSH_AUTH_SOCK is valid
ssh-add -l 2>/dev/null >/dev/null
# if not valid, then start ssh-agent using $SSH_AUTH_SOCK
[ $status -ge 2 ] && rm -f "$SSH_AUTH_SOCK" && ssh-agent -a "$SSH_AUTH_SOCK" >/dev/null
# eval `ssh-agent -a $SSH_AUTH_SOCK` &>/dev/null

# Use starship prompt
starship init fish | source
# Init zoxide (Better navigation than with cd)
zoxide init fish | source
# Init mcfly (Better Ctrl + r)
mcfly init fish | source
mcfly_key_bindings
# Source common aliases, exports, etc.
# source ~/.config/shrc

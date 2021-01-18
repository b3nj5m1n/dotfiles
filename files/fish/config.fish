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
set MCFLY_FILE ~/.config/mcfly.fish
if test -r "$MCFLY_FILE"
    source "$MCFLY_FILE"
    mcfly_key_bindings
else
    printf "\033[1;35mDownloading mcly config..\033[0m\n"
    wget --output-document "$MCFLY_FILE" --quiet "https://raw.githubusercontent.com/cantino/mcfly/master/mcfly.fish"
end
# Source common aliases, exports, etc.
source ~/.config/shrc

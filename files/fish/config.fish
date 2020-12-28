#!/usr/bin/fish

fish_vi_key_bindings
function fish_mode_prompt
end
function fish_greeting
end

# Use starship prompt
starship init fish | source
# Init zoxide (Better navigation than with cd)
zoxide init fish | source
# Source common aliases, exports, etc.
source ~/.config/shrc

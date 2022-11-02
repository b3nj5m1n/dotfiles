local wezterm = require 'wezterm';

return {
    default_prog = { '/usr/bin/tmux' },

    color_scheme = "Catppuccin Macchiato",

    font = wezterm.font("{{ font.font }}"),
    font_size = {{ font.font_size_float }},
    font_antialias = 'Subpixel',

    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },

    scrollback_lines = 81920,

    enable_tab_bar = false,

    window_background_opacity = 1,
}


lib = require 'lib'

widget = {
    plugin = 'xkb',
    cb = function(t)
        if t.name then
            local base_layout = t.name:match('[^(]+')
            return {full_text = lib.colorize(base_layout, '#eee', '#00000000', '#ff0066')}
        else
            return {full_text = '[? ID ' .. t.id .. ']'}
        end
    end,
}

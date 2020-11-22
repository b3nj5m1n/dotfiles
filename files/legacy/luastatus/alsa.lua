lib = require 'lib'

widget = {
    plugin = 'alsa',
    cb = function(t)
        text = ""
        if t.mute then
            text = lib.colorize('mute', "#eee", "#00000000", "#ff0066")
        else
            local percent = (t.vol.cur - t.vol.min) / (t.vol.max - t.vol.min) * 100
            text = lib.colorize(string.format('%3d%%', math.floor(0.5 + percent)), "#eee", "#00000000", "#ff0066")
        end
        return {full_text = string.format("%%{A1::}%%{A2::}%s%%{A2}%%{A1}", text)}
    end,
    event = function(t)
        print(t.button)
        -- if t.button == 2 then     -- left mouse button
        -- os.execute('exec amixer set Master toggle')
        -- end
    end,
}

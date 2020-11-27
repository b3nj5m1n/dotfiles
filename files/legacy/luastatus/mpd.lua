lib = require 'lib'
utf8 = require 'utf8'

text, time, total, is_playing = nil, nil, nil, false
timeout = 2
titlewidth = 40

widget = {
    plugin = 'mpd',
    opts = {
        timeout = timeout,
    },
    cb = function(t)
        if t.what == 'update' then
            -- build title
            local title
            if t.song.Title then
                title = t.song.Title
                if t.song.Artist then
                    title = t.song.Artist .. ' - ' .. title
                end
            else
                title = t.song.file or ''
            end
            title = string.sub(title, 1, titlewidth -1) .. '...'

            -- build text
            if t.status.state == 'play' then
                text = title
            elseif t.status.state == 'pause' then
                text = "[paused]"
            elseif t.status.state == 'stop' then
                text = "[stopped]"
            end

            -- update other globals
            if t.status.time then
                time, total = t.status.time:match('(%d+):(%d+)')
                time, total = tonumber(time), tonumber(total)
            else
                time, total = nil, nil
            end
            is_playing = t.status.state == 'play'

        elseif t.what == 'timeout' then
            if is_playing then
                time = math.min(time + timeout, total)
            end

        else
            -- 'connecting' or 'error'
            return {full_text = t.what}
        end

        -- calc progress
        local len = utf8.len(text)
        -- 'time' and 'total' can be nil here, we check for 'total' only
        local ulpos = (total and total ~= 0)
                        and math.floor(len / total * time + 0.5)
                        or 0

        status = lib.colorize(string.sub(text, 1, ulpos), '#ff0066', '#00000000', '#ff0066') ..
                lib.colorize(string.sub(text, ulpos + 1, len), '#eee', '#00000000', "#ff0066")
        return {full_text = lib.addClick(status, 1, "toggle")}
    end,
    event = function(t)
        if t == 'toggle' then
            os.execute('exec mpc toggle &')
        end
    end,
}

lib = require 'lib'

days = {
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
}

months = {
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
}

widget = {
    plugin = 'timer',
    opts = {period = 5},
    cb = function(t)
        local d = os.date('*t')
        local text = string.format(' %s, %d %s, %02d:%02d ', days[d.wday], d.day, months[d.month], d.hour, d.min)
        return lib.colorize(text, '#eee', '#00000000', '#ff0066')
    end
}

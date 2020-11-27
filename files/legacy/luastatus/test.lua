lib = require 'lib'

fifo_path = os.getenv('HOME') .. '/.fifo-test'
assert(os.execute('f=' .. fifo_path .. '; set -e; rm -f $f; mkfifo -m600 $f'))

widget = {
    plugin = 'timer',
    opts = {
        fifo = fifo_path,
        period = 2.0,
    },
    cb = function(t)
        if t == 'fifo' then
            return {full_text = 'Thanks!'}
        else
            return {full_text = '%{A1:moin:} Click me %{A1}'}
        end
    end,
    event = function(t)
        -- opening the FIFO for writing here may, in some rare cases, block (and doing this from
        -- this process would lead to a deadlock), so we spawn another process to do it and do not
        -- wait for its termination (which would also lead to a deadlock).
        os.execute('exec touch ' .. fifo_path .. '&')
        print(t)
    end,
}

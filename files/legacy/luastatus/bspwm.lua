lib = require 'lib'

function os.capture(cmd)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  return s
end

widget = luastatus.require_plugin('pipe').widget{
    command = 'exec bspc subscribe',
    cb = function(t)
        result = os.capture("/home/b3nj4m1n/dotfiles/files/legacy/luastatus/bspwm.sh")
        return {full_text = result}
    end,
}

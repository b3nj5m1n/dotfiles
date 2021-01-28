require'nvim-web-devicons'.setup()
local gl = require('galaxyline')
local gls = gl.section

-- Global Color Defenitions

local colors = {
    background = '#20212b',
    currentline = '#44475a',
    foreground = '#f8f8f2',
    comment = '#6272a4',
    cyan = '#8be9fd',
    green = '#50fa7b',
    orange = '#ffb86c',
    pink = '#ff79c6',
    purple = '#bd93f9',
    red = '#ff5555',
    yellow = '#f1fa8c',
}

-- Mappings

local modes = {
    [ "n" ] = {colors.purple, "Normal", ""},
    [ "i" ] = {colors.green, "Insert", ""},
    [ "v" ] = {colors.pink, "Visual", ""},
    [ "" ] = {colors.pink, "Visual Block", ""},
    [ "V" ] = {colors.pink, "Visual Line", ""},
    [ "c" ] = {colors.orange, "Command", ""},
    [ "no" ] = {colors.purple, "MODE", ""},
    [ "s" ] = {colors.orange, "MODE", ""},
    [ "S" ] = {colors.orange, "MODE", ""},
    [ "" ] = {colors.orange, "MODE", ""},
    [ "ic" ] = {colors.yellow, "MODE", ""},
    [ "R" ] = {colors.purple, "MODE", ""},
    [ "Rv" ] = {colors.purple, "MODE", ""},
    [ "cv" ] = {colors.red, "MODE", ""},
    [ "ce" ] = {colors.red, "MODE", ""},
    [ "r" ] = {colors.cyan, "MODE", ""},
    [ "rm" ] = {colors.cyan, "MODE", ""},
    [ "r?" ] = {colors.cyan, "MODE", ""},
    [ "!" ] = {colors.red, "MODE", ""},
    [ "t" ] = {colors.red, "MODE", ""},
}

-- Helper functions

--- Abbreviate each individual word in a string
-- @param s String to abbreviate
-- @param n Number of characters to abbreviate each word to
local abbrev = function(s, n)
    local result = ""
    for token in string.gmatch(s, "[^%s]+") do
        result = result .. string.sub(token, 1, n) .. " "
    end
    return result
end

--- Test if the buffer is empty
local buffer_not_empty = function()
    if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
        return true
    end
    return false
end

--- Test if the window is wide enough to display git added/removed/changed stats
local checkwidth = function()
    local squeeze_width  = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
        return true
    end
    return false
end

-- Left Section

gls.left[1] = {
    ViMode = {
        provider = function()
            local mode = vim.fn.mode()
            local mode_color = modes[mode][1]
            local mode_string = modes[mode][2]
            local mode_icon = modes[mode][3]
            vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color .. ' guibg=' .. colors.background .. ' gui=bold')
            return '▊ ' .. abbrev(mode_string, 2) .. ' '
        end,
    },
}
gls.left[2] = {
    FileSize = {
        provider = 'FileSize',
        condition = buffer_not_empty,
        highlight = {colors.foreground,colors.background}
    }
}
gls.left[3] ={
    FileIcon = {
        provider = 'FileIcon',
        condition = buffer_not_empty,
        highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.background},
    },
}
gls.left[5] = {
    FileName = {
        provider = {'FileName'},
        condition = buffer_not_empty,
        highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.background,'bold'}
    }
}

gls.left[6] = {
    LineInfo = {
        provider = 'LineColumn',
        separator = ' ',
        separator_highlight = {'NONE',colors.background},
        highlight = {colors.foreground,colors.background},
    },
}

gls.left[7] = {
    PerCent = {
        provider = 'LinePercent',
        separator = ' ',
        separator_highlight = {'NONE',colors.background},
        highlight = {colors.foreground,colors.background,'bold'},
    }
}
gls.left[8] = {
    DiagnosticError = {
        provider = 'DiagnosticError',
        icon = '  ',
        highlight = {colors.red,colors.background}
    }
}
gls.left[9] = {
    DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        icon = '  ',
        highlight = {colors.yellow,colors.background},
    }
}
gls.left[10] = {
    DiagnosticHint = {
        provider = 'DiagnosticHint',
        icon = '  ',
        highlight = {colors.cyan,colors.background},
    }
}


-- Right Section

gls.right[1] = {
    FileEncode = {
        provider = 'FileEncode',
        separator = ' ',
        separator_highlight = {'NONE',colors.background},
        highlight = {colors.cyan,colors.background,'bold'}
    }
}

gls.right[2] = {
    FileFormat = {
        provider = 'FileFormat',
        separator = ' ',
        separator_highlight = {'NONE',colors.background},
        highlight = {colors.cyan,colors.background,'bold'}
    }
}

gls.right[3] = {
    GitIcon = {
        provider = function() return '  ' end,
        condition = require('galaxyline.provider_vcs').check_git_workspace,
        separator = ' ',
        separator_highlight = {'NONE',colors.background},
        highlight = {colors.violet,colors.background,'bold'},
    }
}

gls.right[4] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = require('galaxyline.provider_vcs').check_git_workspace,
        highlight = {colors.violet,colors.background,'bold'},
    }
}

gls.right[5] = {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = checkwidth,
        icon = '  ',
        highlight = {colors.green,colors.background},
    }
}
gls.right[6] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = checkwidth,
        icon = ' 柳',
        highlight = {colors.orange,colors.background},
    }
}
gls.right[7] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = checkwidth,
        icon = '  ',
        highlight = {colors.red,colors.background},
    }
}


-- Short Left Section

gls.short_line_left[1] = {
    BufferType = {
        provider = 'FileTypeName',
        separator = ' ',
        separator_highlight = {'NONE',colors.background},
        highlight = {colors.blue,colors.background,'bold'}
    }
}

gls.short_line_left[2] = {
    SFileName = {
        provider = function ()
            local fileinfo = require('galaxyline.provider_fileinfo')
            local fname = fileinfo.get_current_file_name()
            for _,v in ipairs(gl.short_line_list) do
                if v == vim.bo.filetype then
                    return ''
                end
            end
            return fname
        end,
        condition = buffer_not_empty,
        highlight = {colors.white,colors.background,'bold'}
    }
}


-- Short Right Section

gls.short_line_right[1] = {
    BufferIcon = {
        provider= 'BufferIcon',
        highlight = {colors.foreground,colors.background}
    }
}

gls.left[11] = {
    DiagnosticInfo = {
        provider = 'DiagnosticInfo',
        icon = '  ',
        highlight = {colors.blue,colors.background},
    }
}


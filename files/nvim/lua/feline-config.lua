-- [nfnl] Compiled from fnl/feline-config.fnl by https://github.com/Olical/nfnl, do not edit.
local prov_lsp = require("feline.providers.lsp")
local prov_vi_mode = require("feline.providers.vi_mode")
local prov_file = require("feline.providers.file")
local prov_git = require("feline.providers.git")
local force_inactive = {filetypes = {"NvimTree", "dbui", "packer", "startify", "fugitive", "fugitiveblame"}, buftypes = {}, bufnames = {}}
local components = {active = {{}, {}, {}}, inactive = {{}, {}, {}}}
local catppuccin = {bg = "#1e1e2e", black = "#181926", yellow = "#f9e2af", cyan = "#94e2d5", oceanblue = "#89b4fa", green = "#a6e3a1", orange = "#fab387", violet = "#cba6f7", magenta = "#eba0ac", white = "#f5e0dc", fg = "#f5e0dc", skyblue = "#74c7ec", red = "#f38ba8", grey = "#494d64"}
local vi_mode_colors = {NORMAL = "green", OP = "green", INSERT = "red", CONFIRM = "red", VISUAL = "skyblue", LINES = "skyblue", BLOCK = "skyblue", REPLACE = "violet", ["V-REPLACE"] = "violet", ENTER = "cyan", MORE = "cyan", SELECT = "orange", COMMAND = "green", SHELL = "green", TERM = "green", NONE = "yellow"}
force_inactive.buftypes = {"terminal"}
local function component_3f(component)
  if (nil == component.provider) then
    return false
  else
    return true
  end
end
local function add_component(section)
  local function _2_(component_)
    if component_3f(component_) then
      section[(1 + #section)] = component_
      return nil
    else
      for index, component in ipairs(component_) do
        add_component(section)(component)
      end
      return nil
    end
  end
  return _2_
end
local register_active_left = add_component(components.active[1])
local register_active_middle = add_component(components.active[2])
local register_active_right = add_component(components.active[3])
local side_indicator
local function _4_()
  local val = {}
  val.bg = prov_vi_mode.get_mode_color()
  val.fg = "black"
  val.style = "bold"
  return val
end
side_indicator = {provider = " ", hl = _4_, right_sep = " "}
local vi_mode
local function _5_()
  local val = {}
  val.fg = prov_vi_mode.get_mode_color()
  val.bg = "bg"
  val.style = "bold"
  return val
end
vi_mode = {provider = "vi_mode", hl = _5_, right_sep = " ", show_mode_name = true}
local git_branch = {provider = "git_branch", hl = {fg = "yellow", bg = "bg", style = "bold"}, left_sep = " "}
local function git_has_changes_3f()
  local changes = vim.b.gitsigns_status_dict
  if (changes == nil) then
    return false
  else
    local has_additions = (changes.added ~= 0)
    local has_changes = (changes.changed ~= 0)
    local has_removals = (changes.removed ~= 0)
    return (has_additions or (has_changes or has_removals))
  end
end
local function git_diff(type)
  local gsd = vim.b.gitsigns_status_dict
  if ((gsd and gsd[type]) and (gsd[type] > 0)) then
    return tostring(gsd[type])
  else
    return "0"
  end
end
local function pad(string, padding, width)
  local amount_to_pad = (width - #string)
  return (string.rep(padding, amount_to_pad) .. string)
end
local git_start_section
local function _8_()
  return git_has_changes_3f()
end
git_start_section = {provider = "[", enabled = _8_, hl = {fg = "grey", bg = "bg", style = "bold"}, left_sep = " "}
local git_added
local function _9_()
  return ("\239\145\151 " .. pad(git_diff("added"), " ", 2))
end
local function _10_()
  return git_has_changes_3f()
end
git_added = {provider = _9_, enabled = _10_, hl = {fg = "green", bg = "bg", style = "bold"}, left_sep = ""}
local git_changed
local function _11_()
  return ("\238\171\159 " .. pad(git_diff("removed"), " ", 2))
end
local function _12_()
  return git_has_changes_3f()
end
git_changed = {provider = _11_, enabled = _12_, hl = {fg = "orange", bg = "bg", style = "bold"}, left_sep = " "}
local git_removed
local function _13_()
  return ("\239\145\153 " .. pad(git_diff("changed"), " ", 2))
end
local function _14_()
  return git_has_changes_3f()
end
git_removed = {provider = _13_, enabled = _14_, hl = {fg = "red", bg = "bg", style = "bold"}, left_sep = " "}
local git_end_section
local function _15_()
  return git_has_changes_3f()
end
git_end_section = {provider = "]", enabled = _15_, hl = {fg = "grey", bg = "bg", style = "bold"}, right_sep = " "}
local filename
local function _16_()
  local val = {}
  val.fg = prov_vi_mode.get_mode_color()
  val.bg = "bg"
  val.style = "bold"
  return val
end
filename = {provider = {name = "file_info", opts = {type = "relative-short", file_modified_icon = ""}}, icon = "", hl = _16_}
local file_type
local function _17_()
  return ("[" .. prov_file.file_type({}, {icon = ""}) .. "]")
end
file_type = {provider = _17_, hl = {fg = "white", bg = "bg", style = "bold"}, left_sep = " "}
local function format_messages(messages)
  local result = {}
  local i = 1
  for _, msg in pairs(messages) do
    if (i < 3) then
      table.insert(result, ((msg.percentage or 0) .. "%% " .. (msg.title or "")))
      i = (i + 1)
    else
    end
  end
  return table.concat(result, " ")
end
local function lsp_connected_3f()
  return (next(vim.lsp.buf_get_clients(0)) ~= nil)
end
local lsp_status
local function _19_()
  local messages = vim.lsp.util.get_progress_messages()
  if (#messages == 0) then
    return "+LSP"
  else
    return (" " .. format_messages(messages))
  end
end
local function _21_()
  return lsp_connected_3f()
end
lsp_status = {provider = _19_, hl = {fg = "violet", bg = "bg", style = "bold"}, enabled = _21_, left_sep = " "}
local function lsp_has_diagnostics_3f()
  return (0 ~= #vim.diagnostic.get(0, {}))
end
local function lsp_diagnostics_count(type)
  local count = vim.tbl_count(vim.diagnostic.get(0, {severity = type}))
  return (((count ~= 0) and tostring(count)) or "0")
end
local lsp_start_section
local function _22_()
  return lsp_connected_3f()
end
lsp_start_section = {provider = "[", enabled = _22_, hl = {fg = "grey", bg = "bg", style = "bold"}, left_sep = " "}
local lsp_errors
local function _23_()
  return ("\238\170\135 " .. pad(lsp_diagnostics_count(vim.diagnostic.severity.ERROR), " ", 1))
end
local function _24_()
  return lsp_connected_3f()
end
lsp_errors = {provider = _23_, enabled = _24_, hl = {fg = "red", style = "bold"}, left_sep = ""}
local lsp_warnings
local function _25_()
  return ("\238\169\172 " .. pad(lsp_diagnostics_count(vim.diagnostic.severity.WARN), " ", 1))
end
local function _26_()
  return lsp_connected_3f()
end
lsp_warnings = {provider = _25_, enabled = _26_, hl = {fg = "yellow", style = "bold"}, left_sep = " "}
local lsp_hints
local function _27_()
  return ("\239\145\137 " .. pad(lsp_diagnostics_count(vim.diagnostic.severity.HINT), " ", 1))
end
local function _28_()
  return prov_lsp.diagnostics_exist(vim.diagnostic.severity.HINT)
end
lsp_hints = {provider = _27_, enabled = _28_, hl = {fg = "cyan", style = "bold"}, left_sep = " "}
local lsp_infos
local function _29_()
  return ("\238\169\180 " .. pad(lsp_diagnostics_count(vim.diagnostic.severity.INFO), " ", 1))
end
local function _30_()
  return prov_lsp.diagnostics_exist(vim.diagnostic.severity.INFO)
end
lsp_infos = {provider = _29_, enabled = _30_, hl = {fg = "skyblue", style = "bold"}, left_sep = " "}
local lsp_end_section
local function _31_()
  return lsp_connected_3f()
end
lsp_end_section = {provider = "]", enabled = _31_, hl = {fg = "grey", bg = "bg", style = "bold"}, right_sep = " "}
local file_size = {provider = "file_size", hl = {fg = "cyan", bg = "bg", style = "bold"}, right_sep = " "}
local position = {provider = {name = "position", opts = {padding = true}}, hl = {fg = "skyblue", bg = "bg", style = "bold"}, right_sep = " "}
local percentage = {provider = "line_percentage", hl = {fg = "oceanblue", bg = "bg", style = "bold"}, right_sep = " "}
register_active_left(side_indicator)
register_active_left(vi_mode)
register_active_left(git_branch)
register_active_left({git_start_section, git_added, git_changed, git_removed, git_end_section})
register_active_middle(filename)
register_active_middle(file_type)
register_active_middle(lsp_status)
register_active_right({lsp_start_section, lsp_errors, lsp_warnings, lsp_hints, lsp_infos, lsp_end_section})
register_active_right({file_size, position, percentage})
return (require("feline")).setup({theme = catppuccin, default_bg = bg, default_fg = fg, vi_mode_colors = vi_mode_colors, components = components, force_inactive = force_inactive})

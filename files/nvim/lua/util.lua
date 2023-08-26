-- [nfnl] Compiled from fnl/util.fnl by https://github.com/Olical/nfnl, do not edit.
local module = {}
_G["config"] = {plugins = {}, ["plugin-configs"] = {}, ["plugin-setups"] = {}, fn = {}, var = {}}
def(__fnl_global__set_2dvar, vim.api.nvim_set_var)
def(__fnl_global__get_2dopt, vim.api.nvim_get_option)
def(expand, vim.fn.expand)
def(__fnl_global__nvim_2dset_2dkeymap, vim.api.nvim_set_keymap)
def(__fnl_global__nvim_2dset_2dopt, vim.api.nvim_set_option_value)
defn(__fnl_global__set_2dopt, {__fnl_global__option_2dname, __fnl_global__option_2dvalue}, "Set nvim option with an empty options table. Wrapper around nvim-set-opt.", __fnl_global__nvim_2dset_2dopt(__fnl_global__option_2dname, __fnl_global__option_2dvalue, {}))
for i = 1, #{...}, 2 do
  __fnl_global__set_2dopt(({...})[i], ({...})[(1 + i)])
end
defn(__fnl_global__set_2dopts, {...}, "Set multiple options.", nil)
local function _1_(...)
  local opts = {noremap = true, silent = true, desc = description}
  return __fnl_global__nvim_2dset_2dkeymap(mode, __fnl_global__left_2dside, __fnl_global__right_2dside, opts)
end
defn(__fnl_global__set_2dkeymap_2dpure, {description, mode, __fnl_global__left_2dside, __fnl_global__right_2dside}, "Set a 'pure' keymap, i.e. no callback", _1_(...))
local function _2_(...)
  local opts = {noremap = true, silent = true, desc = description, callback = callback}
  return __fnl_global__nvim_2dset_2dkeymap(mode, __fnl_global__left_2dside, "", opts)
end
defn(__fnl_global__set_2dkeymap_2dcallback, {description, mode, __fnl_global__left_2dside, callback}, "Set a keymap with a callback.", _2_(...))
defn(__fnl_global__get_2ddescription_2dprefix, {s}, "If description is 'Normal: text text', this function will return 'normal'", string.lower(string.sub(s, 1, (string.find(s, ":", 1, true) - 1))))
defn(__fnl_global__get_2ddescription, {s}, "If description is 'Normal: text text', this function will return 'text text'", string.sub(s, (string.find(s, ":", 1, true) + 2)))
local mode
do
  local _3_ = __fnl_global__get_2ddescription_2dprefix(description)
  if (_3_ == "normal") then
    mode = "n"
  elseif (_3_ == "visual") then
    mode = "v"
  elseif (_3_ == "insert") then
    mode = "i"
  elseif (_3_ == "terminal") then
    mode = "t"
  else
    mode = nil
  end
end
local description = __fnl_global__get_2ddescription(description)
local function _6_(...)
  local _5_ = type(__fnl_global__right_2dside_2dor_2dcallback)
  if (_5_ == "string") then
    return __fnl_global__set_2dkeymap_2dpure(description, mode, __fnl_global__left_2dside, __fnl_global__right_2dside_2dor_2dcallback)
  elseif (_5_ == "table") then
    return __fnl_global__set_2dkeymap_2dcallback(description, mode, __fnl_global__left_2dside, __fnl_global__right_2dside_2dor_2dcallback)
  else
    return nil
  end
end
defn(__fnl_global__set_2dkeymap, {description, __fnl_global__left_2dside, __fnl_global__right_2dside_2dor_2dcallback}, "Set keymap with description, default options and either left-side or callback.", nil, nil, _6_(...))
local function visual_selection_range()
  local _, csrow, cscol, _0 = unpack(vim.fn.getpos("'<"))
  local _1, cerow, cecol, _2 = unpack(vim.fn.getpos("'>"))
  if ((csrow < cerow) or ((csrow == cerow) and (cscol <= cecol))) then
    return (csrow - 1), (cscol - 1), (cerow - 1), cecol
  else
    return (cerow - 1), (cecol - 1), (csrow - 1), cscol
  end
end
local function set_visual_selection(start_line, start_col, end_line, end_col)
  vim.api.nvim_buf_set_mark(0, "<", start_line, start_col, {})
  vim.api.nvim_buf_set_mark(0, ">", end_line, end_col, {})
  return vim.api.nvim_feedkeys("gv", "n", false)
end
local function _16_(...)
  local start
  local function _9_(...)
    if (direction == "up") then
      return 1
    else
      return 0
    end
  end
  start = ((__fnl_global__p_2dstart - 1) - _9_(...))
  local _end
  local function _10_(...)
    if (direction == "down") then
      return 1
    else
      return 0
    end
  end
  _end = (__fnl_global__p_2dend + _10_(...))
  local selection = vim.api.nvim_buf_get_lines(0, (__fnl_global__p_2dstart - 1), __fnl_global__p_2dend, false)
  local neighbour
  local _12_
  do
    local _11_ = direction
    if (_11_ == "up") then
      _12_ = vim.api.nvim_buf_get_lines(0, (__fnl_global__p_2dstart - 2), (__fnl_global__p_2dstart - 1), false)
    elseif (_11_ == "down") then
      _12_ = vim.api.nvim_buf_get_lines(0, __fnl_global__p_2dend, (__fnl_global__p_2dend + 1), false)
    else
      _12_ = nil
    end
  end
  neighbour = (_12_)[1]
  do
    local _17_ = direction
    if (_17_ == "up") then
      table.insert(selection, neighbour)
    elseif (_17_ == "down") then
      table.insert(selection, 1, neighbour)
    else
    end
  end
  return vim.api.nvim_buf_set_lines(0, start, _end, false, selection)
end
defn(__fnl_global__move_2dlines, {direction, __fnl_global__p_2dstart, __fnl_global__p_2dend}, _16_(...))
local function _19_(...)
  local pos = vim.api.nvim_win_get_cursor(0)
  local row = pos[1]
  local col = pos[2]
  if (((direction == "down") or (row > 1)) and ((direction == "up") or (row < vim.api.nvim_buf_line_count(0)))) then
    __fnl_global__move_2dlines(direction, row, row)
    local _20_ = direction
    if (_20_ == "up") then
      return vim.api.nvim_win_set_cursor(0, {(row - 1), col})
    elseif (_20_ == "down") then
      return vim.api.nvim_win_set_cursor(0, {(row + 1), col})
    else
      return nil
    end
  else
    return nil
  end
end
defn(__fnl_global__move_2dcurrent_2dline, {direction}, _19_(...))
local function _23_(...)
  local pos = vim.api.nvim_win_get_cursor(0)
  local row = pos[1]
  local col = pos[2]
  local start, start_col, _end, end_col = visual_selection_range()
  if (((direction == "down") or (start > 0)) and ((direction == "up") or ((_end + 1) < vim.api.nvim_buf_line_count(0)))) then
    __fnl_global__move_2dlines(direction, (1 + start), (1 + _end))
    local _24_ = direction
    if (_24_ == "up") then
      set_visual_selection(start, start_col, _end, end_col)
      return vim.api.nvim_win_set_cursor(0, {(row - 1), col})
    elseif (_24_ == "down") then
      set_visual_selection((start + 2), start_col, (_end + 2), end_col)
      return vim.api.nvim_win_set_cursor(0, {(row + 1), col})
    else
      return nil
    end
  else
    return nil
  end
end
defn(__fnl_global__move_2dcurrent_2dselection, {direction}, _23_(...))
return module

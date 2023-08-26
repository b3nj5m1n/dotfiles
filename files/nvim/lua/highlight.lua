-- [nfnl] Compiled from fnl/highlight.fnl by https://github.com/Olical/nfnl, do not edit.
for group, config in pairs(groups) do
  vim.api.nvim_set_hl(0, group, config)
end
defn(__fnl_global__create_2dhl_2dgroups, {groups}, nil)
vim.cmd("augroup highlight_yank\n           autocmd!\n           au TextYankPost * silent! lua vim.highlight.on_yank({higroup=\"IncSearch\", timeout=200})\n           augroup END")
local function _2_(...)
  local accent_a
  if (mode == "normal") then
    accent_a = "#a6da95"
  elseif (mode == "insert") then
    accent_a = "#ee99a0"
  else
    accent_a = "#8bd5ca"
  end
  return __fnl_global__create_2dhl_2dgroups({CursorLineNr = {fg = accent_a}})
end
defn(__fnl_global__create_2dgroups_2dcursor_2dline, {mode}, _2_(...))
defn(__fnl_global__create_2dgroups_2dcursorword, {}, __fnl_global__create_2dhl_2dgroups({MiniCursorword = {bg = "#1e2030"}}, {MiniCursorwordCurrent = {bg = "#181926"}}))
local function _3_(...)
  local accent = "#342f50"
  return __fnl_global__create_2dhl_2dgroups({UfoFoldedFg = {fg = accent}, UfoFoldedBg = {bg = accent}, Folded = {bg = accent}})
end
defn(__fnl_global__create_2dgroups_2dufo, {}, _3_(...))
local function _5_(...)
  local bg = "#181926"
  local fg = "#cad3f5"
  local bg_light = "#1e2030"
  local accent_a
  if (mode == "normal") then
    accent_a = "#a6da95"
  elseif (mode == "insert") then
    accent_a = "#ee99a0"
  else
    accent_a = "#8bd5ca"
  end
  local accent_b = "#c6a0f6"
  return __fnl_global__create_2dhl_2dgroups({TelescopeBorder = {bg = bg, fg = fg}, TelescopeNormal = {bg = bg}, TelescopePreviewBorder = {bg = bg, fg = bg}, TelescopePreviewNormal = {bg = bg}, TelescopePreviewTitle = {bg = accent_b, fg = bg}, TelescopePromptBorder = {bg = bg_light, fg = bg_light}, TelescopePromptNormal = {bg = bg_light, fg = fg}, TelescopePromptPrefix = {bg = bg_light, fg = accent_a}, TelescopePromptTitle = {bg = accent_a, fg = bg}, TelescopeResultsBorder = {bg = bg, fg = bg}, TelescopeResultsNormal = {bg = bg}, TelescopeResultsTitle = {bg = bg, fg = bg}})
end
defn(__fnl_global__create_2dgroups_2dtelescope, {mode}, _5_(...))
return defn(__fnl_global__create_2dgroups_2dcmp, {}, __fnl_global__create_2dhl_2dgroups({PmenuSel = {bg = "#282C34", fg = "NONE"}, Pmenu = {fg = "#C5CDD9", bg = "#22252A"}, CmpItemAbbrDeprecated = {fg = "#7E8294", bg = "NONE", strikethrough = true}, CmpItemAbbrMatch = {fg = "#82AAFF", bg = "NONE", bold = true}, CmpItemAbbrMatchFuzzy = {fg = "#82AAFF", bg = "NONE", bold = true}, CmpItemMenu = {fg = "#C792EA", bg = "NONE", italic = true}, CmpItemKindField = {fg = "#EED8DA", bg = "#B5585F"}, CmpItemKindProperty = {fg = "#EED8DA", bg = "#B5585F"}, CmpItemKindEvent = {fg = "#EED8DA", bg = "#B5585F"}, CmpItemKindText = {fg = "#C3E88D", bg = "#9FBD73"}, CmpItemKindEnum = {fg = "#C3E88D", bg = "#9FBD73"}, CmpItemKindKeyword = {fg = "#C3E88D", bg = "#9FBD73"}, CmpItemKindConstant = {fg = "#FFE082", bg = "#D4BB6C"}, CmpItemKindConstructor = {fg = "#FFE082", bg = "#D4BB6C"}, CmpItemKindReference = {fg = "#FFE082", bg = "#D4BB6C"}, CmpItemKindFunction = {fg = "#EADFF0", bg = "#A377BF"}, CmpItemKindStruct = {fg = "#EADFF0", bg = "#A377BF"}, CmpItemKindClass = {fg = "#EADFF0", bg = "#A377BF"}, CmpItemKindModule = {fg = "#EADFF0", bg = "#A377BF"}, CmpItemKindOperator = {fg = "#EADFF0", bg = "#A377BF"}, CmpItemKindVariable = {fg = "#C5CDD9", bg = "#7E8294"}, CmpItemKindFile = {fg = "#C5CDD9", bg = "#7E8294"}, CmpItemKindUnit = {fg = "#F5EBD9", bg = "#D4A959"}, CmpItemKindSnippet = {fg = "#F5EBD9", bg = "#D4A959"}, CmpItemKindFolder = {fg = "#F5EBD9", bg = "#D4A959"}, CmpItemKindMethod = {fg = "#DDE5F5", bg = "#6C8ED4"}, CmpItemKindValue = {fg = "#DDE5F5", bg = "#6C8ED4"}, CmpItemKindEnumMember = {fg = "#DDE5F5", bg = "#6C8ED4"}, CmpItemKindInterface = {fg = "#D8EEEB", bg = "#58B5A8"}, CmpItemKindColor = {fg = "#D8EEEB", bg = "#58B5A8"}, CmpItemKindTypeParameter = {fg = "#D8EEEB", bg = "#58B5A8"}}))

local opts = {noremap = true, silent = true}
local opts = {}

-- Navigating Tabs
vim.api.nvim_set_keymap('n', '<C-h>', ':tabprevious<CR>', opts) -- h to switch to previous tab
vim.api.nvim_set_keymap('n', '<C-l>', ':tabnext<CR>', opts) -- l to switch to next tab
vim.api.nvim_set_keymap('n', '<A-h>', ':execute \'silent! tabmove \' . (tabpagenr()-2)<CR>', opts) -- h to move current tab to the left
vim.api.nvim_set_keymap('n', '<A-l>', ':execute \'silent! tabmove \' . (tabpagenr()+1)<CR>', opts) -- l to move current tab to the right

-- Navigating Splits
vim.api.nvim_set_keymap('n', '<leader>wh', '<C-W>h', opts) -- Leader + w(indow) + h to switch to window on the left
vim.api.nvim_set_keymap('n', '<leader>wj', '<C-W>j', opts) -- Leader + w(indow) + j to switch to window on the bottom
vim.api.nvim_set_keymap('n', '<leader>wk', '<C-W>k', opts) -- Leader + w(indow) + k to switch to window on the top
vim.api.nvim_set_keymap('n', '<leader>wl', '<C-W>l', opts) -- Leader + w(indow) + l to switch to window on the right

-- Line highlighting
vim.api.nvim_set_keymap('n', '<leader>hl', ':set cursorline!<CR>', opts) -- Leader + h(ighlighting) + l(ine) to toggle highlighting the current line
vim.api.nvim_set_keymap('n', '<leader>hc', ':set cursorcolumn!<CR>', opts) -- Leader + h(ighlighting) + c(olumn) to toggle highlighting the current column

-- Plugins
vim.api.nvim_set_keymap('n', '<leader>r', ':RnvimrToggle<CR>', opts) -- Toggle ranger
vim.api.nvim_set_keymap('n', '<leader><space>', ':Files<CR>', opts) -- Open fzf
vim.api.nvim_set_keymap('n', '<leader>g', ':Rg<CR>', opts) -- Open RipGrep

-- " Append semicolon to end of line and return to previous location
-- nnoremap g; m`A;<esc>``

-- " Jump to placeholder in file, replace it and go into insert
-- nmap <buffer> <leader>; /<%&%><CR>c5l

local opts = {noremap = true, silent = true}

-- Keep visual selection after indent
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true })
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true })

vim.api.nvim_set_keymap('t', '<C-g>', '<C-\\><C-n>', opts) -- Use Control + g to get back to normal mode in terminal emulator
vim.api.nvim_set_keymap('n', '<leader>pm', ':lua make()<CR><CR>', opts) -- Project Make (Runn make in the directory)

-- Navigating Tabs
vim.api.nvim_set_keymap('n', '<C-h>', ':tabprevious<CR>', opts) -- h to switch to previous tab
vim.api.nvim_set_keymap('n', '<C-l>', ':tabnext<CR>', opts) -- l to switch to next tab
vim.api.nvim_set_keymap('n', '<A-h>', ':execute \'silent! tabmove \' . (tabpagenr()-2)<CR>', opts) -- h to move current tab to the left
vim.api.nvim_set_keymap('n', '<A-l>', ':execute \'silent! tabmove \' . (tabpagenr()+1)<CR>', opts) -- l to move current tab to the right

-- Splits
vim.api.nvim_set_keymap('n', '<leader>wv', ':vsplit<CR>', opts) -- Leader + w(indow) + h to switch to window on the left
vim.api.nvim_set_keymap('n', '<leader>ws', ':split<CR>', opts) -- Leader + w(indow) + h to switch to window on the left
vim.api.nvim_set_keymap('n', '<leader>wh', '<C-W>h', opts) -- Leader + w(indow) + h to switch to window on the left
vim.api.nvim_set_keymap('n', '<leader>wj', '<C-W>j', opts) -- Leader + w(indow) + j to switch to window on the bottom
vim.api.nvim_set_keymap('n', '<leader>wk', '<C-W>k', opts) -- Leader + w(indow) + k to switch to window on the top
vim.api.nvim_set_keymap('n', '<leader>wl', '<C-W>l', opts) -- Leader + w(indow) + l to switch to window on the right

-- Line highlighting
vim.api.nvim_set_keymap('n', '<leader>hl', ':set cursorline!<CR>', opts) -- Leader + h(ighlighting) + l(ine) to toggle highlighting the current line
vim.api.nvim_set_keymap('n', '<leader>hc', ':set cursorcolumn!<CR>', opts) -- Leader + h(ighlighting) + c(olumn) to toggle highlighting the current column

-- Plugins
--[[ vim.api.nvim_set_keymap('i', '<c-c>', '<ESC>', opts) -- Close auto-complete menu with Control + C
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"',  { noremap = true, silent = true, expr = true }) -- Select next item in completion menu with tab
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { noremap = true, silent = true, expr = true }) -- Select previous item in completion menu with tab
vim.api.nvim_set_keymap('i', '<CR>', 'ncm2_ultisnips#expand_or("\\<CR>", "n")', { noremap = true, silent = true, expr = true }) -- Select previous item in completion menu with tab ]]
-- inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

-- LSP
-- vim.api.nvim_set_keymap('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>lsd', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>lsw', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>le', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>ll', '<cmd>lua vim.lsp.buf.format{async = true}<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>lf', [[ <cmd>lua require'lspsaga.provider'.lsp_finder()<CR> ]], opts)
vim.api.nvim_set_keymap('n', '<leader>la', [[ <cmd>lua require('lspsaga.codeaction').code_action()<CR> ]], opts)
vim.api.nvim_set_keymap('n', '<leader>ld', [[ <cmd>lua require('lspsaga.hover').render_hover_doc()<CR> ]], opts)
vim.api.nvim_set_keymap('n', '<leader>ls', [[ <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR> ]], opts)
vim.api.nvim_set_keymap('n', '<leader>lh', [[ <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR> ]], opts)
vim.api.nvim_set_keymap('n', '<leader>lr', [[ <cmd>lua require('lspsaga.rename').rename()<CR> ]], opts)
vim.api.nvim_set_keymap('n', '<leader>lp', [[ <cmd>lua require('lspsaga.provider').preview_definition()<CR> ]], opts)
vim.api.nvim_set_keymap("n", '<leader>lx', "<cmd>Trouble lsp_references<cr>", opts)

-- Trouble
vim.api.nvim_set_keymap("n", '<leader>xx', "<cmd>Trouble<cr>", opts)
vim.api.nvim_set_keymap("n", '<leader>xw', "<cmd>Trouble workspace_diagnostics<cr>", opts)
vim.api.nvim_set_keymap("n", '<leader>xd', "<cmd>Trouble document_diagnostics<cr>", opts)
vim.api.nvim_set_keymap("n", '<leader>xl', "<cmd>Trouble loclist<cr>", opts)
vim.api.nvim_set_keymap("n", '<leader>xq', "<cmd>Trouble quickfix<cr>", opts)

-- Telescope
vim.api.nvim_set_keymap('n', '<leader>tf', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], opts) -- Open fuzzy file finder
vim.api.nvim_set_keymap('n', '<leader>tg', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], opts) -- Open live grep
vim.api.nvim_set_keymap('n', '<leader>tb', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], opts) -- Open buffer list
vim.api.nvim_set_keymap('n', '<leader>th', [[<cmd>lua require('telescope.builtin').help_tags()<cr>]], opts) -- Open help tags

-- " Append semicolon to end of line and return to previous location
-- nnoremap g; m`A;<esc>``

-- " Jump to placeholder in file, replace it and go into insert
-- nmap <buffer> <leader>; /<%&%><CR>c5l

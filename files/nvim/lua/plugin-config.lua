--- UltiSnips ---
vim.api.nvim_set_var("UltiSnipsExpandTrigger", "<c-j>")
vim.api.nvim_set_var("UltiSnipsJumpForwardTrigger", "<c-a>")
vim.api.nvim_set_var("UltiSnipsJumpBackwardTrigger", "<c-s>")


--- completion ---
vim.api.nvim_exec('autocmd BufEnter * call ncm2#enable_for_buffer()', false) -- enable ncm2 for all buffers
vim.api.nvim_set_var("ncm2#complete_length", { { 1,2 }, { 7,1 } }) -- Require a length of 2 for sources with priorities 1-6, 0 for the highest priority
vim.api.nvim_set_var("ncm2#total_popup_limit", 10) -- How many items to show at once
vim.api.nvim_set_var("ncm2#popup_delay", 10) -- How often to refresh, 60 is default, the lower the less flickering


--- lsp ---
local lspconfig = require('lspconfig')
local ncm2 = require('ncm2')
lspconfig.pyls.setup{on_init = ncm2.register_lsp_source}
lspconfig.rls.setup{on_init = ncm2.register_lsp_source}
lspconfig.solargraph.setup{on_init = ncm2.register_lsp_source}
lspconfig.bashls.setup{on_init = ncm2.register_lsp_source}
lspconfig.clangd.setup{on_init = ncm2.register_lsp_source}
lspconfig.cmake.setup{on_init = ncm2.register_lsp_source}
lspconfig.cssls.setup{on_init = ncm2.register_lsp_source}
lspconfig.dockerls.setup{on_init = ncm2.register_lsp_source}
lspconfig.gdscript.setup{on_init = ncm2.register_lsp_source}
lspconfig.gopls.setup{on_init = ncm2.register_lsp_source}
lspconfig.html.setup{on_init = ncm2.register_lsp_source}
lspconfig.jsonls.setup{on_init = ncm2.register_lsp_source}
lspconfig.omnisharp.setup{on_init = ncm2.register_lsp_source}
lspconfig.perlls.setup{on_init = ncm2.register_lsp_source}
lspconfig.sqlls.setup{on_init = ncm2.register_lsp_source}
lspconfig.texlab.setup{on_init = ncm2.register_lsp_source}
lspconfig.tsserver.setup{on_init = ncm2.register_lsp_source}
lspconfig.vimls.setup{on_init = ncm2.register_lsp_source}
lspconfig.yamlls.setup{on_init = ncm2.register_lsp_source}

vim.api.nvim_exec('autocmd BufWritePre *.c lua vim.lsp.buf.formatting()', false) -- Auto-format on save


-- Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
  },
  indent = {
    enable = true
  }
}


 --- airline ---
vim.api.nvim_set_var('airline_theme', 'dracula') -- Require a length of 2 for sources with priorities 1-6, 0 for the highest priority


--- sneak ---
-- highlight Sneak guifg=black guibg=#00C7DF ctermfg=black ctermbg=cyan
-- highlight SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow


--- fzf ---
-- " These are the default extra key bindings
vim.api.nvim_set_var('fzf_action', vim.api.nvim_eval('{ "ctrl-t": "tab split", "ctrl-x": "split", "ctrl-v": "vsplit" }')) -- Require a length of 2 for sources with priorities 1-6, 0 for the highest priority


--- Nvim Tree Lua ---
--  let g:nvim_tree_side = 'left'
-- let g:nvim_tree_width = 30
-- let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
-- let g:nvim_tree_auto_open = 0
-- let g:nvim_tree_auto_close = 1
-- let g:nvim_tree_quit_on_open = 0
-- let g:nvim_tree_follow = 0
-- let g:nvim_tree_indent_markers = 0
-- let g:nvim_tree_hide_dotfiles = 0
-- let g:nvim_tree_git_hl = 0
-- let g:nvim_tree_root_folder_modifier = ':~'
-- let g:nvim_tree_tab_open = 0
-- let g:nvim_tree_width_allow_resize  = 1
-- let g:nvim_tree_show_icons = { }

-- " NOTE: the 'edit' key will wrap/unwrap a folder and open a file
-- let g:nvim_tree_bindings = {
--     \ 'refresh':         'r',
--     \ 'create':          'a',
--     \ 'remove':          'd',
--     \ 'rename':          'R',
--     \ 'cut':             'x',
--     \ 'copy':            'c',
--     \ 'paste':           'p',
--     \ }

-- let g:nvim_tree_icons = {
--     \ 'default': '',
--     \ 'symlink': '',
--     \ 'git': {
--     \   'unstaged': "✗",
--     \   'staged': "✓",
--     \   'unmerged': "",
--     \   'renamed': "➜",
--     \   'untracked': "★"
--     \   },
--     \ 'folder': {
--     \   'default': "",
--     \   'open': "",
--     \   'symlink': "",
--     \   }
--     \ }

-- nnoremap <C-n> :NvimTreeToggle<CR>
-- " NvimTreeOpen and NvimTreeClose are also available if you need them

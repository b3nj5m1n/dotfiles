" --- UltiSnips --- "
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-a>"
let g:UltiSnipsJumpBackwardTrigger="<c-s>"


" --- completion --- "
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
set shortmess+=c
" Require a length of 2 for sources with priorities 1-6, 0 for the highest priority
let g:ncm2#complete_length=[[1,2], [7,0]]
" How many items to show at once
let g:ncm2#total_popup_limit=10
" How often to refresh, 60 is default, the lower the less flickering
let g:ncm2#popup_delay=10
" Enable control + c for exiting the completion menu
inoremap <c-c> <ESC>
" Tab and Shift + Tab for navigating
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" --- lsp --- "
lua << EOF
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
EOF

nnoremap <leader>ld      <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <leader>lh      <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <leader>li      <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>ls      <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>lt      <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <leader>lr      <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <leader>lsd     <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <leader>lsw     <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <leader>le      <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <leader>lf    <cmd>lua vim.lsp.buf.formatting()<CR>

autocmd BufWritePre *.c lua vim.lsp.buf.formatting()


" --- airline --- "
let g:airline_theme = 'dracula'


" --- nerdtree --- "
" Open files from nerd tree in new tab
let NERDTreeCustomOpenArgs={'file':{'where': 't'}}

" Automatically close vim if the only open window is nerd tree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" --- quickscope --- "
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

highlight QuickScopePrimary guifg='#00C7DF' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#eF5F70' gui=underline ctermfg=81 cterm=underline

let g:qs_max_chars=150


" --- sneak --- "
highlight Sneak guifg=black guibg=#00C7DF ctermfg=black ctermbg=cyan
highlight SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow


" --- fzf --- "
" This is the default extra key bindings
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

map <C-f> :Files<CR>
map <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>m :Marks<CR>


let g:fzf_tags_command = 'ctags -R'
" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"


" Customize fzf colors to match your color scheme
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)


" Get text in files with Rg
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
            \   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
            \ call fzf#vim#grep(
            \   'git grep --line-number '.shellescape(<q-args>), 0,
            \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)


" --- Nvim Tree Lua --- "
 let g:nvim_tree_side = 'left'
let g:nvim_tree_width = 30
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
let g:nvim_tree_auto_open = 0
let g:nvim_tree_auto_close = 1
let g:nvim_tree_quit_on_open = 0
let g:nvim_tree_follow = 0
let g:nvim_tree_indent_markers = 0
let g:nvim_tree_hide_dotfiles = 0
let g:nvim_tree_git_hl = 0
let g:nvim_tree_root_folder_modifier = ':~'
let g:nvim_tree_tab_open = 0
let g:nvim_tree_width_allow_resize  = 1
let g:nvim_tree_show_icons = { }

" NOTE: the 'edit' key will wrap/unwrap a folder and open a file
let g:nvim_tree_bindings = {
    \ 'refresh':         'r',
    \ 'create':          'a',
    \ 'remove':          'd',
    \ 'rename':          'R',
    \ 'cut':             'x',
    \ 'copy':            'c',
    \ 'paste':           'p',
    \ }

let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★"
    \   },
    \ 'folder': {
    \   'default': "",
    \   'open': "",
    \   'symlink': "",
    \   }
    \ }

nnoremap <C-n> :NvimTreeToggle<CR>
" NvimTreeOpen and NvimTreeClose are also available if you need them

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue

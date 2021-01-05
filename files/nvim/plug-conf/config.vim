" --- UltiSnips --- "
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-a>"
let g:UltiSnipsJumpBackwardTrigger="<c-s>"


" --- completion --- "
" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
let g:completion_matching_smart_case = 1
" How many chars min to start completion
let g:completion_trigger_keyword_length = 1
" Trigger completion on deletion
let g:completion_trigger_on_delete = 1

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Enable snippet support
let g:completion_enable_snippet = 'UltiSnips'

" Avoid showing message extra message when using completion
set shortmess+=c

let g:completion_chain_complete_list = [
    \{'complete_items': ['path']},
    \{'complete_items': ['lsp', 'buffers']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]
let g:completion_auto_change_source = 1


" --- lsp --- "
lua require'lspconfig'.pyls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.rls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.solargraph.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.bashls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.clangd.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.cmake.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.cssls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.dockerls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.gdscript.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.gopls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.html.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.jsonls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.omnisharp.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.perlls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.sqlls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.texlab.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.vimls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.yamlls.setup{on_attach=require'completion'.on_attach}

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

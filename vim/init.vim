syntax on

set noerrorbells
" set tabstop=4 softtabstop=4                                                               
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set encoding=UTF-8
set termguicolors
set relativenumber
set number
set fdm=syntax
set foldnestmax=20
set nofoldenable
set foldlevel=2

highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.vim/plugged')

" Textobject for the current line 
" Plug 'kana/vim-textobj-line'
" Insert surrounding chars (Like ' or <p>) example: cs"' to change " to '
" S to insert around selection
Plug 'tpope/vim-surround'
" Comment out text example: gcc to comment out line, gc to comment out
" visual selection
Plug 'tpope/vim-commentary'
" Replace with register example: gr iw replaces the inner word, gr replaces
" the curent selection
Plug 'vim-scripts/ReplaceWithRegister'
" Title Case example: gt title cases selection, gT titlecases current line
Plug 'christoomey/vim-titlecase'
" Indent Text object
Plug 'michaeljsmith/vim-indent-object'
" Sort text example: gsip sort the current pararaph
Plug 'christoomey/vim-sort-motion'
" Copy/Paste to/from system clipboard example: cpiw copy current word to
" clipboard cvi' paste inside single quotes
" cP cV is mapped to current lines
Plug 'christoomey/vim-system-copy'
" Text object for entire buffer example: vae select whole document
" Plug 'kana/vim-textobj-entire'
" Highlight color codes
Plug 'ap/vim-css-color'

" Track the engine.
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


Plug 'jremmen/vim-ripgrep'
Plug 'kien/ctrlp.vim'
Plug 'leafgarland/typescript-vim'
Plug 'lyuts/vim-rtags'
" Visualisation of undo tree
Plug 'mbbill/undotree'
" File tree explorer
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'ycm-core/YouCompleteMe'
" Icons in nerd tree
Plug 'ryanoasis/vim-devicons'
" I think this changes the color of the icons and stuff in nerdtree 
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Custom status/tabline
Plug 'vim-airline/vim-airline'
" Themes for airline
Plug 'vim-airline/vim-airline-themes'

Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'

" Color Schemes
" Plug 'chuling/vim-equinusocio-material'
" Plug 'flazz/vim-colorschemes'
" Plug 'morhetz/gruvbox'
" Plug 'schickele/vim-nachtleben'
" Plug 'jschmold/sweet-dark.vim'
Plug 'b3nj5m1n/dotfiles'

call plug#end()

colorscheme Pinky
let g:airline_theme='pinky_airline'

if executable('rg')
    let g:rg_derive_root='true'
endif

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

let g:ctrlp_use_caching = 0

" Open files from nerd tree in new tab
let NERDTreeCustomOpenArgs={'file':{'where': 't'}}

" Automatically close vim if the only open window is nerd tree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let mapleader = "ö"

" Mappings

" Ctrl + a selects entire file
map <C-a> <esc>ggVG<CR>

" Ctrl + left/right switch current tab to previous/next
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
" Alt + left/right moves the current tab to the left/right
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
" Ctrl + n to toggle nerd tree
map <C-n> :NERDTreeToggle<CR>
" Leader key + u to switch between open split screens
nnoremap <leader>u <c-w>w
" Use tab to indent selection & keep selection
" vmap <tab> >gvolloll

" Disable tab for youcompleteme
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
" Press ctrl + j to select a completion (First select with arrow keys)
nnoremap <C-j> g:ycm_key_list_select_completion

" Fold navigation
nnoremap <leader>o zo
nnoremap <leader>c zc
nnoremap <leader>j :call NextClosedFold('j')<cr>
nnoremap <leader>k :call NextClosedFold('k')<cr>
function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction

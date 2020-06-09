call plug#begin('~/.config/nvim/autoload/plugged')

" Textobject for the current line 
" Plug 'kana/vim-textobj-line'
" Insert surrounding chars (Like ' or <p>) example: cs"' to change " to '
" S to insert around selection
" ysiw to insert around inner word
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

" Better search with f and t
Plug 'unblevable/quick-scope'

" Better vertical motion
Plug 'justinmk/vim-sneak'

" Auto pairs for ( and so on
Plug 'jiangmiao/auto-pairs'

" Editor config
Plug 'editorconfig/editorconfig-vim'

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
" Plug 'ycm-core/YouCompleteMe'
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

" Automatically install missing plugins on startup
autocmd VimEnter *
            \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \|   PlugInstall --sync | q
            \| endif

call plug#begin('~/.config/nvim/autoload/plugged')

" Completion, file browsing, snippets, surround, etc.
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Coc extensions
let g:coc_global_extensions = [ "coc-clangd", "coc-css", "coc-explorer", "coc-html", "coc-java", "coc-json", "coc-python", "coc-snippets", "coc-tsserver", "coc-vimlsp", "coc-xml", "coc-pairs", "coc-texlab" ]

" Snippets (Premade snippet files)
Plug 'honza/vim-snippets'

" Repeat commands by plugins
Plug 'tpope/vim-repeat'

" Surround text object
Plug 'tpope/vim-surround'

" Comment out text
Plug 'tpope/vim-commentary'

" Faster handeling of folds
Plug 'Konfekt/FastFold'

" Replace with register example: gr iw replaces the inner word, gr replaces
" the curent selection
Plug 'vim-scripts/ReplaceWithRegister'

" Personal wiki
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" Highlight color codes
Plug 'ap/vim-css-color'

" Better search with f and t
Plug 'unblevable/quick-scope'

" Better vertical motion
Plug 'justinmk/vim-sneak'

" File searching
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

" Editor config
Plug 'editorconfig/editorconfig-vim'

" Custom status/tabline
Plug 'vim-airline/vim-airline'
" Themes for airline
Plug 'vim-airline/vim-airline-themes'

" Vim git integration
Plug 'tpope/vim-fugitive'
" Indicate changed, removed or added lines
Plug 'mhinz/vim-signify'

" Ranger integration
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}

" Color Schemes
" Plug 'b3nj5m1n/dotfiles'
Plug 'b3nj5m1n/gruvbox-material', { 'branch': 'pinky' }

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
            \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \|   PlugInstall --sync | q
            \| endif

" Enable syntax highlighting
syntax on
" Set color scheme
colorscheme Pinky

" Enable mouse support
set mouse=a
" Disable error bell & screen flashing
set noerrorbells
" Insert spaces instead of tab
set expandtab
" How many spaces will be inserted for a tab
set tabstop=4
" Number of spaces that a tab counts for
set softtabstop=4                                                               
" Affects <<, >>, and auto indent
set shiftwidth=4
" Automatically indent on a new line
set smartindent
" Long lines are displayed as one line (Horizontal scrolling required)
set nowrap
" Ignore case in searches
set ignorecase
" Don't ignore case in searches when using case in search
set smartcase
" Don't create swapfiles
set noswapfile
" Don't keep a backup file
set nobackup
" Keep a file with the undo stack
set undofile
" File to store undo stack in
set undodir=~/.config/nvim/undodir
" Directly jump to next match when searching
set incsearch
" Set encoding
set encoding=UTF-8
" Enable 24-bit color
set termguicolors
" Auto fold method set to syntax (Determine folds based on file specific syntax)
set fdm=syntax
" Deepest possible fold
set foldnestmax=20
" Enable fold by default
set foldenable
" The higher, the more folded regions are open (0 = all folds closed)
set foldlevel=5
" Enable line numbers
set nu
" Enable realitve line numbers
set relativenumber
" Indicate current line
set cursorline
" Set color of current line highlighting
hi CursorLine guibg= #242124
" Indicate current column (Disable by default, change with keymapping)
set nocursorcolumn
" Set color of current column highlighting
hi CursorColumn guibg= #242124

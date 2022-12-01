(module options)
   
; --- Preferences ---

(set-var :mapleader " ")
(set-var :maplocalleader ",")
(set-opts
  :foldlevel      99 ; The higher, the more folded regions are open (0 = all folds closed)
  :foldlevelstart 99 ; Inital fold level; close all folds when opening a new buffer
  :laststatus     3 ; Global statusbar
  :wrap           false ; Long lines are displayed as one line (Horizontal scrolling required)
  :relativenumber true ; Enable relative line numbers
  :expandtab      true ; Insert spaces instead of tab
  :spelllang      "en_GB,de,es,cjk" ; Dictionarys to use for checking spelling
  :list           true ; Show invisible characters
  :listchars     "eol:↴,nbsp:+,space:⋅,tab:⟼ ,trail:-") ; Invisible character and what character to show for it
  ;:diffopt     "vertical" ; Options for viewing (git) diffs
   

; --- Sane Defaults ---

; These are what I would set as the defaults for nvim. Nothing specific to me.
(set-var :syntax true)
(set-opts
  :termguicolors  true  ; Enable 24-bit color
  :backup         false ; Don't create a backup file before overwriting a file
  :completeopt    "noinsert,menuone,noselect" ; Do not insert anything until the user selects it; Show the menu when there is just one match; Force the user to select something from the menu
  :encoding       "UTF-8" ; Set encoding to UTF-8
  :errorbells     false ; Disable error bell & screen flashing
  :guicursor      "n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor" ; Cursor shapes
  :hidden         true ; Don't kill buffers, when exiting, keep them around in the background
  :hlsearch       false ; No highlighting on search
  :ignorecase     true ; Ignore case in searches
  :inccommand     :split ; Show preview of substitute
  :incsearch      true ; Directly jump to next match when searching
  :mouse          :a ; Enable mouse support
  :pumheight      20 ; Max completion menu height
  :sessionoptions "blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal" ; Session management options
  :shortmess      (.. (get-opt :shortmess) :c) ; Avoid prompts for auto-complete
  :showmode       false ; Hide the -- INSERT -- at the bottom
  :smartcase      true ; Don't ignore case in searches when using case in search
  :swapfile       false ; Don't create swapfiles
  :undodir        (expand "$XDG_DATA_HOME/nvim/undodir") ; File to store undo stacks in
  :cursorcolumn   false ; Indicate current column
  :cursorline     true ; Indicate current line
  :foldexpr       "nvim_treesitter#foldexpr()" ; Auto fold based on treesitter
  :foldmethod     "expr" ; Auto fold method set to syntax (Determine folds based on file specific syntax)
  :foldnestmax    20 ; Deepest possible fold
  :number         true ; Enable line numbers
  :smartindent    true ; Automatically indent on a new line
  :undofile       true ; Keep a file with the undo stack
  :shiftwidth     4 ; Affects <<, >>, and auto indent
  :softtabstop    4 ; Number of spaces a <Tab> accounts for when editing
  :tabstop        4 ; How many spaces a <Tab> in a file accounts for
  :scrolloff      2 ; Start scrolling when 2 lines from top/bottom, i.e. always show 2 lines of context
  :sidescrolloff  4 ; Same as above but for horizontal scrolling
  :signcolumn     "yes") ; Always dispaly the signcolumn at the left side

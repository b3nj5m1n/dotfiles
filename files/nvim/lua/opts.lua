-- Leader Key
vim.g.mapleader = ' '
vim.b.mapleader = ' '

-- Color Configuration
vim.g.syntax = true -- Enable syntax highlighting
vim.api.nvim_set_option("termguicolors", true) -- Enable 24-bit color
vim.api.nvim_exec('autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE', false) -- Make sure the background color stays as transparent
vim.cmd('colorscheme dracula') -- Use dracula colorscheme

-- Global Settings
vim.api.nvim_set_option("hidden", true) -- Don't kill buffers, when exiting, keep them around in the background
vim.api.nvim_set_option("backup", false) -- Don't create a backup file before overwriting a file
vim.api.nvim_set_option("encoding", "UTF-8") -- Directly jump to next match when searching
vim.api.nvim_set_option("errorbells", false) -- Disable error bell & screen flashing
vim.api.nvim_set_option("foldlevel", 99) -- The higher, the more folded regions are open (0 = all folds closed)
vim.api.nvim_set_option("foldlevelstart", 99) -- Inital fold level; close all folds when opening a new buffer
vim.api.nvim_set_option("ignorecase", true) -- Ignore case in searches
vim.api.nvim_set_option("hlsearch", false) -- No highlighting on search
vim.api.nvim_set_option("incsearch", true) -- Directly jump to next match when searching
vim.api.nvim_set_option("mouse", 'a') -- Enable mouse support
vim.api.nvim_set_option("smartcase", true) -- Don't ignore case in searches when using case in search
vim.api.nvim_set_option("swapfile", false) -- Don't create swapfiles
vim.api.nvim_set_option("undodir", vim.fn.expand("~/.local/share/nvim/undodir")) -- File to store undo stacks in
vim.api.nvim_set_option("completeopt", "noinsert,menuone,noselect") -- Do not insert anything until the user selects it; Show the menu when there is just one match; Force the user to select something from the menu
vim.api.nvim_set_option("shortmess", vim.api.nvim_get_option("shortmess") .. "c") -- Avoid prompts for auto-complete

-- Window Settings
vim.api.nvim_win_set_option(0, "cursorcolumn", false) -- Indicate current column
vim.api.nvim_win_set_option(0, "cursorline", true) -- Indicate current line
vim.api.nvim_win_set_option(0, "foldmethod", "expr") -- Auto fold method set to syntax (Determine folds based on file specific syntax)
vim.api.nvim_win_set_option(0, "foldexpr", "nvim_treesitter#foldexpr()") -- Auto fold based on treesitter
vim.api.nvim_win_set_option(0, "foldnestmax", 20) -- Deepest possible fold
vim.api.nvim_win_set_option(0, "wrap", false) -- Long lines are displayed as one line (Horizontal scrolling required)
vim.api.nvim_win_set_option(0, 'number', true) -- Enable line numbers
vim.api.nvim_win_set_option(0, 'relativenumber', true) -- Enable relative line numbers

-- Buffer Setttings
vim.api.nvim_buf_set_option(0, "spelllang", "en_GB,cjk") -- Dictionarys to use for checking spelling
vim.api.nvim_buf_set_option(0, "expandtab", true) -- Insert spaces instead of tab
vim.api.nvim_buf_set_option(0, "shiftwidth", 4) -- Affects <<, >>, and auto indent
vim.api.nvim_buf_set_option(0, "smartindent", true) -- Automatically indent on a new line
vim.api.nvim_buf_set_option(0, "softtabstop", 4) -- Number of spaces a <Tab> accounts for when editing
vim.api.nvim_buf_set_option(0, "tabstop", 4) -- How many spaces a <Tab> in a file accounts for
vim.api.nvim_buf_set_option(0, "undofile", true) -- Keep a file with the undo stack

-- Neovide Configuration
if vim.g.neovide then
    vim.api.nvim_exec('autocmd ColorScheme * highlight Normal guibg=#282a36', false)
    vim.api.nvim_set_var("neovide_transparency", 0.5)
end


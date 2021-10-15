-- Leader Key
vim.g.mapleader = ' '
vim.b.mapleader = ' '

local opt_manager = {}

opt_manager.options_global = {}
opt_manager.options_window = {}
opt_manager.options_buffer = {}

function opt_manager.add_option_global(option_name, option_value)
    -- vim.api.nvim_set_option(option_name, option_value)
    vim.o[option_name] = option_value
end

function opt_manager.add_option_window(scope, option_name, option_value)
    -- vim.api.nvim_win_set_option(scope, option_name, option_value)
    vim.wo[option_name] = option_value
    opt_manager.add_option_global(option_name, option_value)
end
function opt_manager.add_option_buffer(scope, option_name, option_value)
    -- vim.api.nvim_buf_set_option(scope, option_name, option_value)
    vim.bo[option_name] = option_value
    opt_manager.add_option_global(option_name, option_value)
end

-- Color Configuration
vim.g.syntax = true -- Enable syntax highlighting
vim.api.nvim_set_option("termguicolors", true) -- Enable 24-bit color
-- vim.api.nvim_exec('autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE', false) -- Make sure the background color stays as transparent
vim.api.nvim_exec('autocmd ColorScheme * highlight VertSplit guifg=#282a36 guibg=#bd93f9', false) -- Buffer seperator
--[[ vim.api.nvim_exec('autocmd ColorScheme * highlight StatusLine guifg=#bd93f9 guibg=#bd93f9', false) -- Statusbar color, will be used for the seperator when using galaxyline with split screen
vim.api.nvim_exec('autocmd ColorScheme * highlight StatusLineNC guifg=#bd93f9 guibg=#bd93f9', false) -- Statusbar color, will be used for the seperator when using galaxyline with split screen ]]
-- vim.cmd('colorscheme dracula') -- Use dracula colorscheme
-- LspDiagnostic
vim.api.nvim_exec('autocmd ColorScheme * highlight DiagnosticError guifg=#ff5555', false)
vim.api.nvim_exec('autocmd ColorScheme * highlight DiagnosticWarning guifg=#f1fa8c', false)
vim.api.nvim_exec('autocmd ColorScheme * highlight DiagnosticHint guifg=#50fa7b', false)
vim.api.nvim_exec('autocmd ColorScheme * highlight DiagnosticInformation guifg=#8be9fd', false)

-- Global Settings
opt_manager.add_option_global("backup", false) -- Don't create a backup file before overwriting a file
opt_manager.add_option_global("completeopt", "noinsert,menuone,noselect") -- Do not insert anything until the user selects it; Show the menu when there is just one match; Force the user to select something from the menu
opt_manager.add_option_global("encoding", "UTF-8") -- Directly jump to next match when searching
opt_manager.add_option_global("errorbells", false) -- Disable error bell & screen flashing
opt_manager.add_option_global("foldlevel", 99) -- The higher, the more folded regions are open (0 = all folds closed)
opt_manager.add_option_global("foldlevelstart", 99) -- Inital fold level; close all folds when opening a new buffer
opt_manager.add_option_global("guicursor", "n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor") -- Cursor shapes
opt_manager.add_option_global("hidden", true) -- Don't kill buffers, when exiting, keep them around in the background
opt_manager.add_option_global("hlsearch", false) -- No highlighting on search
opt_manager.add_option_global("ignorecase", true) -- Ignore case in searches
opt_manager.add_option_global("inccommand", "split") -- Show preview of substitute
opt_manager.add_option_global("incsearch", true) -- Directly jump to next match when searching
opt_manager.add_option_global("mouse", 'a') -- Enable mouse support
opt_manager.add_option_global("sessionoptions", "blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal") -- Session management options
opt_manager.add_option_global("shortmess", vim.api.nvim_get_option("shortmess") .. "c") -- Avoid prompts for auto-complete
opt_manager.add_option_global("showmode", false) -- Hide the -- INSERT -- at the bottom
opt_manager.add_option_global("smartcase", true) -- Don't ignore case in searches when using case in search
opt_manager.add_option_global("swapfile", false) -- Don't create swapfiles
opt_manager.add_option_global("undodir", vim.fn.expand("~/.local/share/nvim/undodir")) -- File to store undo stacks in

-- Window Settings
opt_manager.add_option_window(0, "cursorcolumn", false) -- Indicate current column
opt_manager.add_option_window(0, "cursorline", true) -- Indicate current line
opt_manager.add_option_window(0, "foldexpr", "nvim_treesitter#foldexpr()") -- Auto fold based on treesitter
opt_manager.add_option_window(0, "foldmethod", "expr") -- Auto fold method set to syntax (Determine folds based on file specific syntax)
opt_manager.add_option_window(0, "foldnestmax", 20) -- Deepest possible fold
opt_manager.add_option_window(0, "wrap", false) -- Long lines are displayed as one line (Horizontal scrolling required)
opt_manager.add_option_window(0, 'number', true) -- Enable line numbers
opt_manager.add_option_window(0, 'relativenumber', true) -- Enable relative line numbers

-- Buffer Setttings
opt_manager.add_option_buffer(0, "expandtab", true) -- Insert spaces instead of tab
opt_manager.add_option_buffer(0, "shiftwidth", 4) -- Affects <<, >>, and auto indent
opt_manager.add_option_buffer(0, "smartindent", true) -- Automatically indent on a new line
opt_manager.add_option_buffer(0, "softtabstop", 4) -- Number of spaces a <Tab> accounts for when editing
opt_manager.add_option_buffer(0, "spelllang", "en_GB,de,es,cjk") -- Dictionarys to use for checking spelling
opt_manager.add_option_buffer(0, "tabstop", 4) -- How many spaces a <Tab> in a file accounts for
opt_manager.add_option_buffer(0, "undofile", true) -- Keep a file with the undo stack

-- Neovide Configuration
if vim.g.neovide then
    vim.api.nvim_exec('autocmd ColorScheme * highlight Normal guibg=#282a36', false)
    vim.api.nvim_set_var("neovide_transparency", 0.5)
end

-- Show invisible characters
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

vim.opt.scrolloff = 2 -- Lines of context
vim.opt.sidescrolloff = 4 -- Columns of context
vim.opt.signcolumn = "yes" -- Always show signcolumn

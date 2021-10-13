-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

vim.g.kommentary_create_default_mappings = false

return require('packer').startup(function()

    use {'wbthomason/packer.nvim', opt = true} -- Packer can manage itself as an optional plugin

    use { 'nvim-neorg/neorg', requires = 'nvim-lua/plenary.nvim' }

    use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

    use {'dracula/vim', as = 'dracula'} -- You can alias plugin names

    use 'rmagatti/auto-session' -- Automatic session management

    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup {
                char = "|",
                buftype_exclude = {"terminal"}
            }
        end
    }

    use 'jbyuki/nabla.nvim'

    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-textobjects'

    use 'simrat39/symbols-outline.nvim'

    use 'neovim/nvim-lspconfig' -- Common configs for the in-built lsp client
    use 'glepnir/lspsaga.nvim'

    use { 'ms-jpq/coq_nvim', run = "::COQdeps", config = function()
        vim.cmd([[ let g:coq_settings = { 'auto_start': 'shut-up' }]])
    end } -- Completion support
    use 'ms-jpq/coq.artifacts' -- 9k+ snippets
    use 'ms-jpq/coq.thirdparty'

    -- use 'SirVer/ultisnips' -- Snippet Engine

    -- use 'honza/vim-snippets' -- Snippets (Premade snippet files)

    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'} }
    } -- Fuzzy Finding

    use 'windwp/nvim-autopairs' -- Auto pairs

    use 'kyazdani42/nvim-web-devicons' -- File Icons

    use { 'ms-jpq/chadtree', run = ':CHADdeps' } -- File Tree

    use 'tpope/vim-repeat' -- Repeat commands by plugins

    use 'tpope/vim-surround' -- Surround text object

    use 'b3nj5m1n/kommentary' -- Comment out text
    -- use '~/Documents/Github/kommentary/'

    use 'norcalli/nvim-colorizer.lua' -- Highlight color codes

    use 'justinmk/vim-sneak' -- Better vertical motion

    use 'editorconfig/editorconfig-vim' -- Editor config

    use 'famiu/feline.nvim'
    -- use 'vim-airline/vim-airline' -- Custom status/tabline
    --[[ use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    } -- Custom status/tabline ]]

    use 'tpope/vim-fugitive' -- Vim git integration

    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('gitsigns').setup {
                signs = {
                    add          = {hl = 'DiffAdd'   , text = '│', numhl='GitSignsAddNr'},
                    change       = {hl = 'DiffChange', text = '│', numhl='GitSignsChangeNr'},
                    delete       = {hl = 'DiffDelete', text = '_', numhl='GitSignsDeleteNr'},
                    topdelete    = {hl = 'DiffDelete', text = '‾', numhl='GitSignsDeleteNr'},
                    changedelete = {hl = 'DiffChange', text = '~', numhl='GitSignsChangeNr'},
                },
                numhl = false,
                keymaps = {
                    -- Default keymap options
                    noremap = true,
                    buffer = true,

                    ['n <leader>hn'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
                    ['n <leader>hp'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

                    ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
                    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
                    ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
                    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
                    ['n <leader>hv'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
                },
                watch_gitdir = {
                    interval = 1000
                },
            }
        end
    } -- Indicate changed, removed or added lines

    -- use 'lotabout/skim.vim' -- Fuzzy-finding files
    -- use 'airblade/vim-rooter'

end)

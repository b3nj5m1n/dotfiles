local pc = require('plugin-config')
-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

vim.g.kommentary_create_default_mappings = false

return require('packer').startup(function()

    use {'wbthomason/packer.nvim', opt = true} -- Packer can manage itself as an optional plugin

    use {
        'nvim-neorg/neorg',
        requires = 'nvim-lua/plenary.nvim',
        config = pc.neorg(),
    }

    use {
        'TimUntersberger/neogit',
        requires = 'nvim-lua/plenary.nvim',
        config = pc.neogit(),
    }

    use {
        'Mofiqul/dracula.nvim',
        config = function()
            vim.cmd("colorscheme dracula")
        end
    } -- colorscheme

    use({
        "folke/persistence.nvim",
        event = "BufReadPre",
        module = "persistence",
        config = function()
            require("persistence").setup()
        end,
    }) -- Save sessions

    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup {
                char = "|",
                space_char_blankline = " ",
                show_current_context = true,
                buftype_exclude = {"terminal"}
            }
        end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        config = pc.treesitter(),
    }
    use {
        'nvim-treesitter/nvim-treesitter-textobjects'
    }

    -- use 'simrat39/symbols-outline.nvim'

    use {
        'neovim/nvim-lspconfig',
        config = pc.lsp(),
    } -- Common configs for the in-built lsp client
    use {
        'glepnir/lspsaga.nvim',
        config = pc.lsp_saga(),
    }

    use { 'ms-jpq/coq_nvim',
        run = ":COQdeps",
        branch = 'coq',
        config = function()
            vim.g.coq_settings = {
                ["auto_start"] = 'shut-up',
                ["display.ghost_text.enabled"]=false,
                ["xdg"] = true,
                ['clients.third_party.enabled']=false,
            }
            require("coq")
        end
    } -- Completion support
    use {
        'ms-jpq/coq.artifacts', branch = 'artifacts'
    } -- 9k+ snippets

    -- use 'SirVer/ultisnips' -- Snippet Engine

    -- use 'honza/vim-snippets' -- Snippets (Premade snippet files)

    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'} }
    } -- Fuzzy Finding

    use {
        'windwp/nvim-autopairs',
        config = pc.autopairs(),
    } -- Auto pairs

    use {
        'kyazdani42/nvim-web-devicons'
    } -- File Icons

    -- use { 'ms-jpq/chadtree', run = ':CHADdeps', branch = 'chad' } -- File Tree

    use  {
        'tpope/vim-repeat'
    } -- Repeat commands by plugins

    use {
        'tpope/vim-surround'
    } -- Surround text object

    use {
        'b3nj5m1n/kommentary',
        config = pc.kommentary(),
    } -- Comment out text
    -- use '~/Documents/Github/kommentary/'

    use {
        'norcalli/nvim-colorizer.lua',
        config = pc.colorizer(),
    } -- Highlight color codes

    use {
        'editorconfig/editorconfig-vim'
    } -- Editor config

    use {
        'hoob3rt/lualine.nvim',
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'dracula-nvim'
                }
            }
        end,
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    } -- Statusline

    use {
        'tpope/vim-fugitive'
    } -- Vim git integration

    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('gitsigns').setup()
        end
    } -- Indicate changed, removed or added lines

end)

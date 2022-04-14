-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

require('packer').startup({function()

    use {
        'wbthomason/packer.nvim',
        opt = true,
        cmd = { "PackerSync" },
    } -- Packer can manage itself as an optional plugin

    use {
        'lewis6991/impatient.nvim',
        --[[ config = function()
            require('impatient')
        end ]]
    }

    use {
        'nvim-neorg/neorg',
        requires = 'nvim-lua/plenary.nvim',
        ft = "norg",
        module = "neorg",
        config = function() require('plugin-config').neorg() end,
    }

    use {
        'TimUntersberger/neogit',
        requires = 'nvim-lua/plenary.nvim',
        config = function() require('plugin-config').neogit() end,
        cmd = {},
    }

    use {
        'Mofiqul/dracula.nvim',
        event = "UiEnter",
        config = function()
            vim.cmd("colorscheme dracula")
        end
    } -- colorscheme

    use {
        "folke/persistence.nvim",
        event = "BufReadPre",
        module = "persistence",
        config = function()
            require("persistence").setup()
        end,
    } -- Save sessions

    use {
        "lukas-reineke/indent-blankline.nvim",
        event = "UiEnter",
        module = "indent_blankline",
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
        event = "UiEnter",
        config = function() require('plugin-config').treesitter() end,
    }
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        event = "UiEnter",
    }

    -- use 'simrat39/symbols-outline.nvim'

    use {
        'neovim/nvim-lspconfig',
        event = "VimEnter",
        -- module = "lspconfig",
        config = function() require('plugin-config').lsp() end,
    } -- Common configs for the in-built lsp client

    use {
        'glepnir/lspsaga.nvim',
        event = "VimEnter",
        module = "lspsaga",
        config = function() require('plugin-config').lsp_saga() end,
    }

    use {
        'hrsh7th/nvim-cmp',
        config = function() require('plugin-config').cmp() end,
    } -- Completion
    use {
        'hrsh7th/cmp-nvim-lsp',
        requires = 'hrsh7th/nvim-cmp',
        requires = 'neovim/nvim-lspconfig',
    }
    use {
        'hrsh7th/cmp-nvim-lsp-signature-help',
        requires = 'hrsh7th/nvim-cmp',
        requires = 'hrsh7th/cmp-nvim-lsp',
        requires = 'neovim/nvim-lspconfig',
    }
    use {
        'hrsh7th/cmp-buffer',
        after = 'nvim-cmp',
        requires = 'hrsh7th/nvim-cmp',
    }
    use {
        'hrsh7th/cmp-path',
        after = 'nvim-cmp',
        requires = 'hrsh7th/nvim-cmp',
    }
    use {
        'saadparwaiz1/cmp_luasnip',
        requires = 'hrsh7th/nvim-cmp',
        requires = 'L3MON4D3/LuaSnip',
    }

    use {
        'L3MON4D3/LuaSnip',
        config = function() require('plugin-config').luasnip() end,
    } -- Snippet Engine

    use {
        'rafamadriz/friendly-snippets',
    } -- Snippets

    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'} },
        event = "UiEnter",
    } -- Fuzzy Finding

    use {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        module = "nvim-autopairs",
        config = function() require('plugin-config').autopairs() end,
    } -- Auto pairs

    --[[ use {
        'kyazdani42/nvim-web-devicons'
    } -- File Icons ]]

    -- use { 'ms-jpq/chadtree', run = ':CHADdeps', branch = 'chad' } -- File Tree

    use  {
        'tpope/vim-repeat',
        event = "BufEnter",
    } -- Repeat commands by plugins

    use {
        'tpope/vim-surround',
        event = "InsertEnter",
    } -- Surround text object

    use {
        'b3nj5m1n/kommentary',
        event = "VimEnter",
        module = "kommentary",
        setup = function()
            vim.g.kommentary_create_default_mappings = false
        end,
        config = function() require('plugin-config').kommentary() end,
    } -- Comment out text
    -- use '~/Documents/Github/kommentary/'

    use {
        'norcalli/nvim-colorizer.lua',
        event = "BufEnter",
        module = "colorizer",
        config = function() require('plugin-config').colorizer() end,
    } -- Highlight color codes

    use {
        'editorconfig/editorconfig-vim'
    } -- Editor config

    use {
        'beauwilliams/statusline.lua',
    } -- Statusline

    use {
        'tpope/vim-fugitive',
        event = "BufEnter",
    } -- Vim git integration

    use {
        'lewis6991/gitsigns.nvim',
        event = "BufEnter",
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('gitsigns').setup()
        end
    } -- Indicate changed, removed or added lines

end,
    config = {
        compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua',
    }
})

require('impatient')
require('packer_compiled')

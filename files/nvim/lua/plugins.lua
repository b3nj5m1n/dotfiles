-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

require('packer').startup({function()

    use {
        'wbthomason/packer.nvim',
        branch = "master",
        commit = "4dedd3b08f8c6e3f84afbce0c23b66320cd2a8f2",
        opt = true,
        cmd = { "PackerSync" },
    } -- Packer can manage itself as an optional plugin

    use {
        'rktjmp/hotpot.nvim',
        branch = "master",
        commit = "8ccf600ccb5dbc28ea329d641a58e2fd6974d38e",
        config = function() require("hotpot") end,
    } -- Fennel support

    use {
        'lewis6991/impatient.nvim',
        branch = "main",
        commit = "2337df7d778e17a58d8709f651653b9039946d8d",
    }

    use {
        'nvim-neorg/neorg',
        branch = "main",
        commit = "633dfc9f0c3a00a32ee89d4ab826da2eecfe9bd8",
        requires = 'nvim-lua/plenary.nvim',
        ft = "norg",
        module = "neorg",
        config = function() require('plugin-config').neorg() end,
    }

    use {
        'kyazdani42/nvim-tree.lua',
        branch = "master",
        commit = "7f2ed4e04337d9729052f23d918f644ada18daa0",
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require('nvim-tree').setup {} end,
        disable = true,
    }

    use {
        'TimUntersberger/neogit',
        branch = "master",
        commit = "c8dd268091ffcbcb673de59c5b37ff26a2eb24ed",
        requires = 'nvim-lua/plenary.nvim',
        config = function() require('plugin-config').neogit() end,
        cmd = {},
    }

    use {
        'Mofiqul/dracula.nvim',
        branch = "main",
        commit = "a219971291c56bcca3827cb7bd40aaaef23feeca",
        event = "UiEnter",
        config = function()
            vim.cmd("colorscheme dracula")
        end
    } -- colorscheme

    use {
        'folke/persistence.nvim',
        branch = "main",
        commit = "77cf5a6ee162013b97237ff25450080401849f85",
        event = "BufReadPre",
        module = "persistence",
        config = function()
            require("persistence").setup()
        end,
    } -- Save sessions

    use {
        'eraserhd/parinfer-rust',
        branch = "master",
        commit = "211f72e32cccbc728a8346f665c0a0b52c01c1e4",
        run = "cargo build --release",
    }

    use {
        'p00f/nvim-ts-rainbow',
        branch = "master",
        commit = "04284dc97eac0d0ecfea68e10be824d1a6585de0",
        event = "UiEnter",
    }

    use {
        'hkupty/iron.nvim',
        branch = "master",
        commit = "8eeb7935247c4a0286047d0854bdce9fe345aad4",
        config = function()
            local iron = require("iron.core")
            iron.setup {
                config = {
                    should_map_plug = false,
                    scratch_repl = true,
                },
                keymaps = {}
            }
        end,
        disable = true,
    }

    use {
        'lukas-reineke/indent-blankline.nvim',
        branch = "master",
        commit = "045d9582094b27f5ae04d8b635c6da8e97e53f1d",
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
        branch = "master",
        commit = "db0e5192911a8bf9df2f2a45c4dab249d5cbf32c",
        event = "UiEnter",
        config = function() require('plugin-config').treesitter() end,
    }
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = "master",
        commit = "8af3045c2703248b58d8ee3ee3b18399525bd5d6",
        event = "UiEnter",
    }

    -- use 'simrat39/symbols-outline.nvim'

    use {
        'neovim/nvim-lspconfig',
        branch = "master",
        commit = "99596a8cabb050c6eab2c049e9acde48f42aafa4",
        event = "VimEnter",
        -- module = "lspconfig",
        config = function() require('plugin-config').lsp() end,
    } -- Common configs for the in-built lsp client

    use {
        'tami5/lspsaga.nvim',
        branch = "main",
        commit = "5309d75bd90ce5b1708331df3af1e971fa83a2b9",
        event = "VimEnter",
        module = "lspsaga",
        config = function() require('plugin-config').lsp_saga() end,
    }

    use {
        'hrsh7th/nvim-cmp',
        branch = "main",
        commit = "b5433f901ebffc9e01b82ae13da9a92d49569205",
        config = function() require('plugin-config').cmp() end,
    } -- Completion
    use {
        'hrsh7th/cmp-nvim-lsp',
        branch = "main",
        commit = "ebdfc204afb87f15ce3d3d3f5df0b8181443b5ba",
        requires = 'hrsh7th/nvim-cmp',
        requires = 'neovim/nvim-lspconfig',
    }
    use {
        'hrsh7th/cmp-nvim-lsp-signature-help',
        branch = "main",
        commit = "8014f6d120f72fe0a135025c4d41e3fe41fd411b",
        requires = 'hrsh7th/nvim-cmp',
        requires = 'hrsh7th/cmp-nvim-lsp',
        requires = 'neovim/nvim-lspconfig',
    }
    use {
        'hrsh7th/cmp-buffer',
        branch = "main",
        commit = "d66c4c2d376e5be99db68d2362cd94d250987525",
        after = 'nvim-cmp',
        requires = 'hrsh7th/nvim-cmp',
    }
    use {
        'hrsh7th/cmp-path',
        branch = "main",
        commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e",
        after = 'nvim-cmp',
        requires = 'hrsh7th/nvim-cmp',
    }
    use {
        'hrsh7th/cmp-omni',
        branch = "main",
        commit = "7a457f0c4f9e0801fee777d955eb841659aa3b84",
        after = 'nvim-cmp',
        requires = 'hrsh7th/nvim-cmp',
    }
    use {
        'saadparwaiz1/cmp_luasnip',
        branch = "master",
        commit = "b10829736542e7cc9291e60bab134df1273165c9",
        requires = 'hrsh7th/nvim-cmp',
        requires = 'L3MON4D3/LuaSnip',
    }

    use {
        'L3MON4D3/LuaSnip',
        branch = "master",
        commit = "6b67cb12747225a6412d8263bb97d6d2b8d9366a",
        config = function() require('plugin-config').luasnip() end,
    } -- Snippet Engine

    use {
        'rafamadriz/friendly-snippets',
        branch = "main",
        commit = "e302658e765cf20e6af5a1be8cc07a996d6ee2cc",
    } -- Snippets

    use {
        'nvim-telescope/telescope.nvim',
        branch = "master",
        commit = "b7ae91c82b33f8f347fa060208adb3da80ae9260",
        requires = { {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'} },
        event = "UiEnter",
    } -- Fuzzy Finding

    use {
        'windwp/nvim-autopairs',
        branch = "master",
        commit = "38d486a1c47ae2722a78cf569008de0a64f4b153",
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
        branch = "master",
        commit = "24afe922e6a05891756ecf331f39a1f6743d3d5a",
        event = "BufEnter",
    } -- Repeat commands by plugins

    use {
        'tpope/vim-surround',
        branch = "master",
        commit = "81fc0ec460dd8b25a76346e09aecdbca2677f1a7",
        event = "InsertEnter",
    } -- Surround text object

    use {
        'b3nj5m1n/kommentary',
        branch = "main",
        commit = "12ecde4ed3ecb39964000a5fd034ae4c1d307388",
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
        branch = "master",
        commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6",
        event = "BufEnter",
        module = "colorizer",
        config = function() require('plugin-config').colorizer() end,
    } -- Highlight color codes

    use {
        'editorconfig/editorconfig-vim',
        branch = "master",
        commit = "a8e3e66deefb6122f476c27cee505aaae93f7109",
    } -- Editor config

    use {
        'beauwilliams/statusline.lua',
        branch = "master",
        commit = "72de7c81992ee416ccb6c5a03ef84c76cc414318",
    } -- Statusline

    use {
        "folke/trouble.nvim",
        branch = "main",
        commit = "691d490cc4eadc430d226fa7d77aaa84e2e0a125",
        event = "BufEnter",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup { }
        end
    } -- Pretty diagnostic window

    use {
        'tpope/vim-fugitive',
        branch = "master",
        commit = "4b0f2b604562e9681ae3b80c2665f168ac637cea",
        event = "BufEnter",
    } -- Vim git integration

    use {
        'lewis6991/gitsigns.nvim',
        branch = "main",
        commit = "f83a2e11cd7a486e92f3c6630e71e93a073a11da",
        event = "BufEnter",
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('gitsigns').setup{
                signs = {
                    add          = {hl = 'GitSignsAdd'   , text = '▌', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
                    change       = {hl = 'GitSignsChange', text = '▌', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
                },
                current_line_blame = true,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol',
                    delay = 5000,
                    ignore_whitespace = false,
                },
                on_attach = function(bufnr)
                    vim.api.nvim_exec('highlight GitSignsCurrentLineBlame guifg=#5a5e7a', false)
                end,
            }
        end
    } -- Indicate changed, removed or added lines

end,
    config = {
        compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua',
    }
})

require('impatient')
require('packer_compiled')

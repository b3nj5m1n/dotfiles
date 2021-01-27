-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()

    use {'wbthomason/packer.nvim', opt = true} -- Packer can manage itself as an optional plugin

    use {'dracula/vim', as = 'dracula'} -- You can alias plugin names

    use 'nvim-treesitter/nvim-treesitter'

    use 'neovim/nvim-lspconfig' -- Common configs for the in-built lsp client

    use 'ncm2/ncm2' -- Provides completions for in-built lsp client
    use 'ncm2/ncm2-bufword' -- Completion source for words in current buffer
    use 'ncm2/ncm2-path' -- Completion source for filepaths
    use 'ncm2/ncm2-ultisnips' -- Completion source for utilsnips
    use 'roxma/nvim-yarp' -- Required by ncm2

    use 'SirVer/ultisnips' -- Snippet Engine

    use 'honza/vim-snippets' -- Snippets (Premade snippet files)

    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'} }
    } -- Fuzzy Finding

    use 'jiangmiao/auto-pairs' -- Auto pairs

    use 'kyazdani42/nvim-web-devicons' -- File Icons

    use 'kyazdani42/nvim-tree.lua' -- File Tree

    use 'tpope/vim-repeat' -- Repeat commands by plugins

    use 'tpope/vim-surround' -- Surround text object

    use 'glepnir/prodoc.nvim' -- Comment out text

    use 'norcalli/nvim-colorizer.lua' -- Highlight color codes

    use 'justinmk/vim-sneak' -- Better vertical motion

    use 'editorconfig/editorconfig-vim' -- Editor config

    -- use 'vim-airline/vim-airline' -- Custom status/tabline
    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    } -- Custom status/tabline

    use 'tpope/vim-fugitive' -- Vim git integration

    use 'mhinz/vim-signify' -- Indicate changed, removed or added lines

    -- use 'lotabout/skim.vim' -- Fuzzy-finding files
    -- use 'airblade/vim-rooter'

end)

(module plugins
  {require
   {util util
    paq paq}})

; [plenary](https://github.com/nvim-lua/plenary.nvim)
(paq.paq-add "plenary" "Common lua functions for nvim plugins"
  "nvim-lua/plenary.nvim"
  :branch "master"
  :commit "4b7e52044bbb84242158d977a50c4cbcd85070c7")

; [aniseed](https://github.com/Olical/aniseed)
(paq.paq-add "aniseed" "Fennel support"
  "Olical/aniseed"
  :branch "master"
  :commit "9892a40d4cf970a2916a984544b7f984fc12f55c")

; [kommentary](https://github.com/b3nj5m1n/kommentary)
; This is a plugin I wrote a while back, it's similar to tpope's [vim-commentary](https://github.com/tpope/vim-commentary), but written in lua and with more functionality. About a year after I wrote this plugin, we also got [Comment.nvim](https://github.com/numToStr/Comment.nvim), which has a bit more functionality than kommentary and is definitely worth checking out if you don't already have a commenting plugin.
(paq.paq-add "kommentary" "Comment out text"
  "b3nj5m1n/kommentary"
  :commit "533d768a140b248443da8346b88e88db704212ab"
  ; :event "VimEnter"
  :module "kommentary"
  :setup (util.set-var :kommentary_create_default_mappings false))

; [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
; (paq.paq-add "nvim-ts-context-commentstring" "Change commentstring in nested languages"
;   "JoosepAlviste/nvim-ts-context-commentstring"
;   :commit "32d9627123321db65a4f158b72b757bcaef1a3f4")

; [dressing.nvim](https://github.com/stevearc/dressing.nvim)
(paq.paq-add "dressing" "Better default ui interfaces"
  "stevearc/dressing.nvim"
  :branch "master"
  :commit "ed44aa798ab07dc298f43f35c8e0c93a1b335abb"
  :ft "norg"
  :module "neorg")

; [neorg](https://github.com/nvim-neorg/neorg)
(paq.paq-add "neorg" "Org-mode equivalent for neovim"
  "nvim-neorg/neorg"
  :commit "10cd28e3bec3f6583f545ba0d504e65f63a64aae"
  :requires ["nvim-lua/plenary.nvim" "nvim-treesitter/nvim-treesitter"]
  :ft "norg"
  :module "neorg")

; [dracula](https://github.com/Mofiqul/dracula.nvim)
; (paq.paq-add "dracula" "Dracula colorscheme with treesitter support"
;  "Mofiqul/dracula.nvim"
;  :commit "55f24e76a978c73c63d22951b0700823f21253b7"
;  :event "UiEnter"
;  :config (vim.cmd "colorscheme dracula"))

; [gruvbox](https://github.com/ellisonleao/gruvbox.nvim)
; (paq.paq-add "gruvbox" "Gruvbox colorscheme"
;   "ellisonleao/gruvbox.nvim"
;   :commit "2fc4980dfa17e76f7c7e963caa69599051d2e75e"
;   ; :event "UiEnter"
;   :config (do
;            (local gruvbox (require :gruvbox))
;            (vim.cmd "colorscheme gruvbox")))
     
; [catppuccin](https://github.com/catppuccin/nvim)
(paq.paq-add "catppuccin" "Catppuccin colorscheme"
  "catppuccin/nvim"
  ; :as "colorscheme"
  :commit "e695645298320e9714d10897aadee3cb5951567a")

; [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
(paq.paq-add "indent-blankline" "Show indent guides"
  "lukas-reineke/indent-blankline.nvim"
  :branch "master"
  :commit "db7cbcb40cc00fc5d6074d7569fb37197705e7f6"
  ; :after "colorscheme"
  :module "indent_blankline")
  ; :event "UiEnter")
   
; [leap.nvim](https://github.com/ggandor/leap.nvim)
(paq.paq-add "leap" "Smooth af navigation plugin"
  "ggandor/leap.nvim"
  :branch "main"
  :commit "847a1dcfb1a3a576860151754d95fb3b0014663e")
  ; :event "UiEnter")
   
; [murmur.lua](https://github.com/nyngwang/murmur.lua)
(paq.paq-add "murmur" "Highlight current word in buffer"
  "nyngwang/murmur.lua"
  :commit "b7fc2b36df33fca58efe3a9f5b487f1be4bf138e")
  ; :event "UiEnter")

; [nvim-parinfer](https://github.com/gpanders/nvim-parinfer)
(paq.paq-add "parinfer" "Parinfer plugin written in lua"
  "gpanders/nvim-parinfer"
  :branch "master"
  :commit "82bce5798993f4fe5ced20e74003b492490b4fe8")
  ; :event "UiEnter")

; [telescope](https://github.com/nvim-telescope/telescope.nvim)
(paq.paq-add "telescope" "Fuzzy finder"
  "nvim-telescope/telescope.nvim"
  :branch "master"
  :commit "97847309cbffbb33e442f07b8877d20322a26922"
  :requires "nvim-lua/plenary.nvim")
  ; :event "UiEnter"
   
; [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
(paq.paq-add "autopairs" "Autopairs"
  "windwp/nvim-autopairs"
  :branch "master"
  :commit "6b6e35fc9aca1030a74cc022220bc22ea6c5daf4"
  ; :event "InsertEnter"
  :module "nvim-autopairs")

; [vim-repeat](https://github.com/tpope/vim-repeat)
(paq.paq-add "vim-repeat" "Repeat plugin commands using dot"
  "tpope/vim-repeat"
  :branch "master"
  :commit "24afe922e6a05891756ecf331f39a1f6743d3d5a")
  ; :event "BufEnter")

; [nvim-surround](https://github.com/kylechui/nvim-surround)
(paq.paq-add "nvim-surround" "Surround text objects"
  "kylechui/nvim-surround"
  :branch "main"
  :commit "7e5096b736ae252d04d543af6a13280125dc6d0f")
  ; :event "InsertEnter")

; [nvim-colorizer](https://github.com/nvchad/nvim-colorizer.lua)
(paq.paq-add "nvim-colorizer" "Highlight color codes"
  "nvchad/nvim-colorizer.lua"
  :branch "master"
  :commit "760e27df4dd966607e8fb7fd8b6b93e3c7d2e193"
  ; :event "BufEnter"
  :module "colorizer")
   
; [editorconfig](https://github.com/editorconfig/editorconfig-vim)
(paq.paq-add "editorconfig" "Automatically load some configuration options based on project"
  "editorconfig/editorconfig-vim"
  :branch "master"
  :commit "a8e3e66deefb6122f476c27cee505aaae93f7109")

; [feline.nvim](https://github.com/feline-nvim/feline.nvim)
(paq.paq-add "feline" "Statusline"
  "feline-nvim/feline.nvim"
  :branch "master"
  :commit "6d4e3f934bffaa1893a690cd9b8f8b584ef0a7ea")

; [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)
(paq.paq-add "web-deviconds" "File icons"
   "kyazdani42/nvim-web-devicons"
   :branch "master"
   :commit "9061e2d355ecaa2b588b71a35e7a11358a7e51e1")

; [vim-vinegar](https://github.com/tpope/vim-vinegar)
(paq.paq-add "vim-vinegar" "Netrw improvements"
  "tpope/vim-vinegar"
  :branch "master"
  :commit "bb1bcddf43cfebe05eb565a84ab069b357d0b3d6")

; [netrw.nvim](https://github.com/prichrd/netrw.nvim)
(paq.paq-add "netrw.nvim" "Netrw improvements"
  "prichrd/netrw.nvim"
  :branch "master"
  :commit "98154b526f4fc8168aadf5cab963c4eadba5ba48")

; [conjure](https://github.com/Olical/conjure)
(paq.paq-add "conjure" "Interactive evaluation"
  "Olical/conjure"
  :branch "master"
  :commit "839fe23a7746f03aa9ef1ebf087501cd6126cf0f")

; [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
(paq.paq-add "nvim-treesitter" "Treesitter abstraction layer"
     "nvim-treesitter/nvim-treesitter"
     :branch "master"
     :commit "c155b6bb308269ca4a376777a8621261efbd17cb")

; [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
(paq.paq-add "treesitter-textobjects" "Textobjects like functions from treesitter"
  "nvim-treesitter/nvim-treesitter-textobjects"
  :branch "master"
  :commit "13739a5705d9592cbe7da372576363dc8ea5f723")
  ; :event "UiEnter")

; [nvim-ts-rainbow](https://github.com/p00f/nvim-ts-rainbow)
(paq.paq-add "rainbow-parens" "Color nested parens using treesitter"
  "p00f/nvim-ts-rainbow"
  :branch "master"
  :commit "1ec3f880585c644ddd50a51502c59f4e36f03e62")
  ; :event "UiEnter")

; [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
(paq.paq-add "lspconfig" "Lsp abstraction layer"
  "neovim/nvim-lspconfig"
  :branch "master"
  :commit "2315a397fd5057e3a74a09a240f606af28447ebf")
  ; :event "VimEnter"

; [rust-tools.nvim](https://github.com/simrat39/rust-tools.nvim)
(paq.paq-add "rust-tools" "More support for rust analyzer"
  "simrat39/rust-tools.nvim"
  :branch "master"
  :commit "99fd1238c6068d0637df30b6cee9a264334015e9")

; [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls)
(paq.paq-add "nvim-jdtls" "More support for java lsp"
  "mfussenegger/nvim-jdtls"
  :branch "master"
  :commit "f39efa0e823bcc876d18a7b44d3b61191c42e61c")

; [lspsaga.nvim](https://github.com/glepnir/lspsaga.nvim)
; (paq.paq-add "lspsaga" "Better lsp ui"
;   "glepnir/lspsaga.nvim"
;   :commit "391cf74475ad094ccad7c5501710b27fcdb9b883"
;   ; :event "VimEnter"
;   :module "lspsaga")

; ; [lsp_lines.nvim](https://git.sr.ht/~whynothugo/lsp_lines.nvim)
; (paq.paq-add "lsp_lines" "Lsp diagnostics"
;   "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
;   :commit "ec98b45c8280e5ef8c84028d4f38aa447276c002")
    
; [trouble.nvim](https://github.com/folke/trouble.nvim)
(paq.paq-add "trouble" "Better diagnostics ui"
  "folke/trouble.nvim"
  :commit "ed65f84abc4a1e5d8f368d7e02601fc0357ea15e")
  ; :event "BufEnter")

; [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
(paq.paq-add "nvim-cmp" "Completion plugin"
  "hrsh7th/nvim-cmp"
  :commit "11a95792a5be0f5a40bab5fc5b670e5b1399a939"
  :config) 

; [lspkind.nvim](https://github.com/onsails/lspkind.nvim)
(paq.paq-add "lspkind" "vscode-like pictograms for neovim lsp completion items "
  "onsails/lspkind.nvim"
  :branch "master"
  :commit "c68b3a003483cf382428a43035079f78474cd11e")

; [nvim-cmp-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
(paq.paq-add "cmp-lsp" "Cmp provider for lsp"
  "hrsh7th/cmp-nvim-lsp"
  :commit "3cf38d9c957e95c397b66f91967758b31be4abe6")

; [nvim-cmp-lsp-signature-help](https://github.com/hrsh7th/cmp-nvim-lsp-signature-help)
(paq.paq-add "cmp-lsp-signature" "Cmp provider for lsp signatures"
  "hrsh7th/cmp-nvim-lsp-signature-help"
  :commit "d2768cb1b83de649d57d967085fe73c5e01f8fd7")

; [nvim-cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
(paq.paq-add "cmp-buffer" "Cmp provider for buffer words"
  "hrsh7th/cmp-buffer"
  :commit "3022dbc9166796b644a841a02de8dd1cc1d311fa")

; [nvim-cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline)
(paq.paq-add "cmp-cmdline" "Cmp provider for commandline"
  "hrsh7th/cmp-cmdline"
  :commit "c66c379915d68fb52ad5ad1195cdd4265a95ef1e")

; [nvim-cmp-path](https://github.com/hrsh7th/cmp-path)
(paq.paq-add "cmp-path" "Cmp provider for filepaths"
  "hrsh7th/cmp-path"
  :commit "91ff86cd9c29299a64f968ebb45846c485725f23")

; [nvim-cmp-luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
(paq.paq-add "cmp-luasnip" "Cmp provider for luasnip"
  "saadparwaiz1/cmp_luasnip"
  :branch "master"
  :commit "a9de941bcbda508d0a45d28ae366bb3f08db2e36")

; [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
(paq.paq-add "luasnip" "Snippet engine"
  "L3MON4D3/LuaSnip"
  :branch "master"
  :commit "663d54482b11bca1ce94f56993b9f6ab485a13dc")

; [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
(paq.paq-add "friendly-snippets" "Snippet collection"
  "rafamadriz/friendly-snippets"
  :commit "bb318c455e4e8946d64c79753f5bb07f7c27d711")

; [neogit](https://github.com/TimUntersberger/neogit)
(paq.paq-add "neogit" "Magit for neovim"
  "TimUntersberger/neogit"
  :branch "master"
  :commit "1acb13c07b34622fe1054695afcecff537d9a00a"
  :requires "nvim-lua/plenary.nvim"
  :module "neogit"
  :after "plenary.nvim")

; [vim-fugitive](https://github.com/tpope/vim-fugitive)
(paq.paq-add "fugitive" "Basic git integration"
  "tpope/vim-fugitive"
  :branch "master"
  :commit "4b0f2b604562e9681ae3b80c2665f168ac637cea")
  ; :event "BufEnter")

; [gitsigns](https://github.com/lewis6991/gitsigns.nvim)
(paq.paq-add "gitsigns" "Show added/removed/changed lines"
  "lewis6991/gitsigns.nvim"
  :commit "851cd32caaea84f303c4fdf51d72dfa5fcd795bb"
  :requires "nvim-lua/plenary.nvim")
  ; :event "BufEnter")

; [promise-async](https://github.com/kevinhwang91/promise-async)
(paq.paq-add "promise-async" "Promise/await in lua"
  "kevinhwang91/promise-async"
  :commit "70b09063cdf029079b25c7925e4494e7416ee995")

; [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo)
(paq.paq-add "nvim-ufo" "Handling of folds"
  "kevinhwang91/nvim-ufo"
  :commit "e988139f6f2d3b3fb5cb512a164636ed7dc41c1f"
  :requires "kevinhwang91/nvim-ufo")

; [nvim-dap](https://github.com/mfussenegger/nvim-dap)
(paq.paq-add "nvim-dap" "Debug Adapter Protocol Implemenation"
  "mfussenegger/nvim-dap"
  :branch "master"
  :commit "8f396b7836b9bbda9edd9f655f12ca377ae97676")

; [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
(paq.paq-add "nvim-dap-ui" "UI for nvim-dap"
  "rcarriga/nvim-dap-ui"
  :branch "master"
  :commit "54365d2eb4cb9cfab0371306c6a76c913c5a67e3")

; [nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text)
(paq.paq-add "nvim-dap-virtual-text" "Virtual text for variable content when debugging"
  "theHamsta/nvim-dap-virtual-text"
  :branch "master"
  :commit "2971ce3e89b1711cc26e27f73d3f854b559a77d4")

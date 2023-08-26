;(module plugins
;  {require
;   {util util
;    paq paq

; [plenary](https://github.com/nvim-lua/plenary.nvim)
(paq.paq-add "plenary" "Common lua functions for nvim plugins"
  "nvim-lua/plenary.nvim"
  :branch "master"
  :commit "0dbe561ae023f02c2fb772b879e905055b939ce3")

; [nfnl](https://github.com/Olical/nfnl)
(paq.paq-add "nfnl" "Fennel support"
  "Olical/nfnl"
  :commit "9fd29f394a57e14e573850defd288ea263876cbf")
; ; [aniseed](https://github.com/Olical/aniseed)
; (paq.paq-add "aniseed" "Fennel support"
;   "Olical/aniseed"
;   :branch "master"
;   :commit "7bc09736f3651c10d29b82d1a465b7f540614be1")

; [kommentary](https://github.com/b3nj5m1n/kommentary)
; This is a plugin I wrote a while back, it's similar to tpope's [vim-commentary](https://github.com/tpope/vim-commentary), but written in lua and with more functionality. About a year after I wrote this plugin, we also got [Comment.nvim](https://github.com/numToStr/Comment.nvim), which has a bit more functionality than kommentary and is definitely worth checking out if you don't already have a commenting plugin.
(paq.paq-add "kommentary" "Comment out text"
  "b3nj5m1n/kommentary"
  :commit "533d768a140b248443da8346b88e88db704212ab"
  :event "VimEnter"
  :optional true
  ; :module "kommentary"
  :setup (util.set-var :kommentary_create_default_mappings false)
  :config ((. (require :plugin-config) :kommentary)))
          

; [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
; (paq.paq-add "nvim-ts-context-commentstring" "Change commentstring in nested languages"
;   "JoosepAlviste/nvim-ts-context-commentstring"
;   :commit "32d9627123321db65a4f158b72b757bcaef1a3f4")

; [dressing.nvim](https://github.com/stevearc/dressing.nvim)
(paq.paq-add "dressing" "Better default ui interfaces"
  "stevearc/dressing.nvim"
  :branch "master"
  :commit "ee571505f3566f84fd252e76c4ce6df6eaf2fb94"
  :optional true
  :config ((. (require :plugin-config) :dressing)))

; [neorg](https://github.com/nvim-neorg/neorg)
(paq.paq-add "neorg" "Org-mode equivalent for neovim"
  "nvim-neorg/neorg"
  :commit "f296a22864bbac0d94ad00fa18cc8231dbeaa1e3"
  :requires ["nvim-lua/plenary.nvim" "nvim-treesitter/nvim-treesitter"]
  ; :optional true
  ; :filetype "norg"
  :config ((. (require :plugin-config) :neorg)))
  ;:module "neorg")

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
  :commit "da8f4875bdc4d73ff039c2e42a3ef931414e50bd")

; [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
(paq.paq-add "indent-blankline" "Show indent guides"
  "lukas-reineke/indent-blankline.nvim"
  :branch "master"
  :commit "9637670896b68805430e2f72cf5d16be5b97a22a"
  ; :after "colorscheme"
  ; :module "indent_blankline"
  :optional true)
  ; :event "UiEnter")
   
; [leap.nvim](https://github.com/ggandor/leap.nvim)
(paq.paq-add "leap" "Smooth af navigation plugin"
  "ggandor/leap.nvim"
  :branch "main"
  :commit "5efe985cf68fac3b6a6dfe7a75fbfaca8db2af9c"
  :optional true)
  ; :event "UiEnter")
   
; [mini.cursorword](https://github.com/echasnovski/mini.cursorword)
(paq.paq-add "cursorword" "Highlight current word in buffer"
  "echasnovski/mini.cursorword"
  :commit "066770d17218d783dc76abde80fde89967f94907"
  :config true
  :opts { :delay 0})
  ; :config (. (require "mini.cursorword") :setup) {}
  ; :event "UiEnter"
  ; :optional true)

; [nvim-parinfer](https://github.com/gpanders/nvim-parinfer)
(paq.paq-add "parinfer" "Parinfer plugin written in lua"
  "gpanders/nvim-parinfer"
  :branch "master"
  :commit "5ca09287ab3f4144f78ff7977fabc27466f71044")
  ; :optional true
  ; :event "UiEnter")

; [telescope](https://github.com/nvim-telescope/telescope.nvim)
(paq.paq-add "telescope" "Fuzzy finder"
  "nvim-telescope/telescope.nvim"
  :branch "master"
  :commit "2d92125620417fbea82ec30303823e3cd69e90e8"
  :requires "nvim-lua/plenary.nvim"
  :optional true)
  ; :event "UiEnter"
   
; [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
(paq.paq-add "autopairs" "Autopairs"
  "windwp/nvim-autopairs"
  :branch "master"
  :commit "ae5b41ce880a6d850055e262d6dfebd362bb276e"
  :optional true)
  ; :event "InsertEnter")
  ; :module "nvim-autopairs")

; [vim-repeat](https://github.com/tpope/vim-repeat)
(paq.paq-add "vim-repeat" "Repeat plugin commands using dot"
  "tpope/vim-repeat"
  :branch "master"
  :commit "24afe922e6a05891756ecf331f39a1f6743d3d5a"
  :optional true)
  ; :event "BufEnter")

; [nvim-surround](https://github.com/kylechui/nvim-surround)
(paq.paq-add "nvim-surround" "Surround text objects"
  "kylechui/nvim-surround"
  :branch "main"
  :commit "1c2ef599abeeb98e40706830bcd27e90e259367a"
  :optional true)
  ; :event "InsertEnter")

; [nvim-colorizer](https://github.com/nvchad/nvim-colorizer.lua)
(paq.paq-add "nvim-colorizer" "Highlight color codes"
  "nvchad/nvim-colorizer.lua"
  :branch "master"
  :commit "dde3084106a70b9a79d48f426f6d6fec6fd203f7"
  ; :event "BufEnter"
  ; :module "colorizer")
  :optional true)
   
; [editorconfig](https://github.com/editorconfig/editorconfig-vim)
(paq.paq-add "editorconfig" "Automatically load some configuration options based on project"
  "editorconfig/editorconfig-vim"
  :branch "master"
  :commit "e014708e917b457e8f6c57f357d55dd3826880d4"
  :optional true)

; [feline.nvim](https://github.com/feline-nvim/feline.nvim)
(paq.paq-add "feline" "Statusline"
  "feline-nvim/feline.nvim"
  :branch "master"
  :commit "d48b6f92c6ccdd6654c956f437be49ea160b5b0c"
  :optional true)

; [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)
(paq.paq-add "web-deviconds" "File icons"
   "kyazdani42/nvim-web-devicons"
   :branch "master"
   :commit "cfc8824cc1db316a276b36517f093baccb8e799a"
   :optional true)

; [vim-vinegar](https://github.com/tpope/vim-vinegar)
(paq.paq-add "vim-vinegar" "Netrw improvements"
  "tpope/vim-vinegar"
  :branch "master"
  :commit "bb1bcddf43cfebe05eb565a84ab069b357d0b3d6"
  :optional true)

; [netrw.nvim](https://github.com/prichrd/netrw.nvim)
(paq.paq-add "netrw.nvim" "Netrw improvements"
  "prichrd/netrw.nvim"
  :branch "master"
  :commit "596435bd2f5b0162b86c97ca8244e2b0862d3a4a"
  :optional true)

; [conjure](https://github.com/Olical/conjure)
(paq.paq-add "conjure" "Interactive evaluation"
  "Olical/conjure"
  :branch "master"
  :commit "0d9b823db06cc11e6115b54297f690dff10c0299"
  :optional true)

; [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
(paq.paq-add "nvim-treesitter" "Treesitter abstraction layer"
     "nvim-treesitter/nvim-treesitter"
     :branch "master"
     :commit "31f608e47b838594d32a7bc42028e2cefd0ddaad"
  :optional true)

; [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
(paq.paq-add "treesitter-textobjects" "Textobjects like functions from treesitter"
  "nvim-treesitter/nvim-treesitter-textobjects"
  :branch "master"
  :commit "9e519b6146512c8e2e702faf8ac48420f4f5deec"
  ; :event "UiEnter")
  :optional true)

; [nvim-ts-rainbow](https://github.com/p00f/nvim-ts-rainbow)
(paq.paq-add "rainbow-parens" "Color nested parens using treesitter"
  "hiphish/rainbow-delimiters.nvim"
  :branch "master"
  :commit "698a4396623a479fb1bfd3ad5fd23d244996cbeb"
  ; :event "UiEnter")
  :optional true)

; [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
(paq.paq-add "lspconfig" "Lsp abstraction layer"
  "neovim/nvim-lspconfig"
  :branch "master"
  :commit "f7922e59aeb9bc3e31a660ea4e7405ffa3fc2c3a"
  :event "VimEnter"
  :optional true
  :config ((. (require :plugin-config) :lspconfig)))

; [rust-tools.nvim](https://github.com/simrat39/rust-tools.nvim)
(paq.paq-add "rust-tools" "More support for rust analyzer"
  "simrat39/rust-tools.nvim"
  :branch "master"
  :commit "0cc8adab23117783a0292a0c8a2fbed1005dc645"
  :filetype "rust"
  :event "VimEnter"
  :optional true)

; [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls)
(paq.paq-add "nvim-jdtls" "More support for java lsp"
  "mfussenegger/nvim-jdtls"
  :branch "master"
  :commit "095dc490f362adc85be66dc14bd9665ddd94413b"
  :filetype "java"
  :optional true)

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
  :commit "40aad004f53ae1d1ba91bcc5c29d59f07c5f01d3"
  :event "BufEnter"
  :optional true)

; [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
(paq.paq-add "nvim-cmp" "Completion plugin"
  "hrsh7th/nvim-cmp"
  :commit "51f1e11a89ec701221877532ee1a23557d291dd5"
  :event "BufEnter"
  :optional true)

; [lspkind.nvim](https://github.com/onsails/lspkind.nvim)
(paq.paq-add "lspkind" "vscode-like pictograms for neovim lsp completion items "
  "onsails/lspkind.nvim"
  :branch "master"
  :commit "57610d5ab560c073c465d6faf0c19f200cb67e6e"
  :event "BufEnter"
  :optional true)

; [nvim-cmp-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
(paq.paq-add "cmp-lsp" "Cmp provider for lsp"
  "hrsh7th/cmp-nvim-lsp"
  :commit "44b16d11215dce86f253ce0c30949813c0a90765"
  :event "BufEnter"
  :optional true)

; [nvim-cmp-lsp-signature-help](https://github.com/hrsh7th/cmp-nvim-lsp-signature-help)
(paq.paq-add "cmp-lsp-signature" "Cmp provider for lsp signatures"
  "hrsh7th/cmp-nvim-lsp-signature-help"
  :commit "3d8912ebeb56e5ae08ef0906e3a54de1c66b92f1"
  :event "BufEnter"
  :optional true)

; [nvim-cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
(paq.paq-add "cmp-buffer" "Cmp provider for buffer words"
  "hrsh7th/cmp-buffer"
  :commit "3022dbc9166796b644a841a02de8dd1cc1d311fa"
  :event "BufEnter"
  :optional true)

; [nvim-cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline)
(paq.paq-add "cmp-cmdline" "Cmp provider for commandline"
  "hrsh7th/cmp-cmdline"
  :commit "8ee981b4a91f536f52add291594e89fb6645e451"
  :event "BufEnter"
  :optional true)

; [nvim-cmp-path](https://github.com/hrsh7th/cmp-path)
(paq.paq-add "cmp-path" "Cmp provider for filepaths"
  "hrsh7th/cmp-path"
  :commit "91ff86cd9c29299a64f968ebb45846c485725f23"
  :event "BufEnter"
  :optional true)

; [nvim-cmp-luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
(paq.paq-add "cmp-luasnip" "Cmp provider for luasnip"
  "saadparwaiz1/cmp_luasnip"
  :branch "master"
  :commit "18095520391186d634a0045dacaa346291096566"
  :event "BufEnter"
  :optional true)

; [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
(paq.paq-add "luasnip" "Snippet engine"
  "L3MON4D3/LuaSnip"
  :branch "master"
  :commit "c4d6298347f7707e9757351b2ee03d0c00da5c20")

; [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
(paq.paq-add "friendly-snippets" "Snippet collection"
  "rafamadriz/friendly-snippets"
  :commit "377d45475b49e37460a902d6d569d2093d4037d0")
  ; :optional true)

; [neogit](https://github.com/TimUntersberger/neogit)
(paq.paq-add "neogit" "Magit for neovim"
  "NeogitOrg/neogit"
  :branch "master"
  :commit "d764b406a1a6f3db13a28bef10e139a09fcc14dd"
  :requires "nvim-lua/plenary.nvim"
  ; :module "neogit"
  ; :after "plenary.nvim"
  ; :optional true
  :config true)

; [vim-fugitive](https://github.com/tpope/vim-fugitive)
(paq.paq-add "fugitive" "Basic git integration"
  "tpope/vim-fugitive"
  :branch "master"
  :commit "b3b838d690f315a503ec4af8c634bdff3b200aaf"
  ; :event "BufEnter")
  :optional true)

; [gitsigns](https://github.com/lewis6991/gitsigns.nvim)
(paq.paq-add "gitsigns" "Show added/removed/changed lines"
  "lewis6991/gitsigns.nvim"
  :commit "749267aaa863c30d721c9913699c5d94e0c07dd3"
  :requires "nvim-lua/plenary.nvim"
  ; :event "BufEnter")
  :optional true)

; [promise-async](https://github.com/kevinhwang91/promise-async)
(paq.paq-add "promise-async" "Promise/await in lua"
  "kevinhwang91/promise-async"
  :commit "e94f35161b8c5d4a4ca3b6ff93dd073eb9214c0e"
  :optional true)

; [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo)
(paq.paq-add "nvim-ufo" "Handling of folds"
  "kevinhwang91/nvim-ufo"
  :commit "0c0e1e0af68a608b15d18125be92953c553a5f27"
  :requires "kevinhwang91/nvim-ufo"
  :optional true)

; [nvim-dap](https://github.com/mfussenegger/nvim-dap)
(paq.paq-add "nvim-dap" "Debug Adapter Protocol Implemenation"
  "mfussenegger/nvim-dap"
  :branch "master"
  :commit "4377a05b9476587b7b485d6a9d9745768c4e4b37"
  :optional true)

; [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
(paq.paq-add "nvim-dap-ui" "UI for nvim-dap"
  "rcarriga/nvim-dap-ui"
  :branch "master"
  :commit "85b16ac2309d85c88577cd8ee1733ce52be8227e"
  :optional true)

; [nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text)
(paq.paq-add "nvim-dap-virtual-text" "Virtual text for variable content when debugging"
  "theHamsta/nvim-dap-virtual-text"
  :branch "master"
  :commit "57f1dbd0458dd84a286b27768c142e1567f3ce3b"
  :optional true)

; [which-key.nvim](https://github.com/folke/which-key.nvim)
; BUG conflicts with dressing.nvim
(paq.paq-add "which-key" "Display popup with possible keybindings"
  "folke/which-key.nvim"
  :commit "7ccf476ebe0445a741b64e36c78a682c1c6118b7"
  :opts {}
  :optional true
  :event "VeryLazy"
  :setup (do
          (set vim.o.timeout true)
          (set vim.o.timeoutlen 300))
  :config true)

; [headlines.nvim](https://github.com/lukas-reineke/headlines.nvim)
(paq.paq-add "headlines" "Horizontal highlights for headings"
  "lukas-reineke/headlines.nvim"
  :branch "master"
  :commit "74a083a3c32a08be24f7dfcc6f448ecf47857f46"
  :requires ["nvim-treesitter/nvim-treesitter"]
  :opts {}
  :optional true
  :config true
  :filetype ["norg" "markdown"])

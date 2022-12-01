(module plugins)

; [plenary](https://github.com/nvim-lua/plenary.nvim))
(paq "plenary" "Common lua functions for nvim plugins"
  "nvim-lua/plenary.nvim"
  :branch "master"
  :commit "4b7e52044bbb84242158d977a50c4cbcd85070c7")

; [aniseed](https://github.com/Olical/aniseed))
(paq "aniseed" "Fennel support"
  "Olical/aniseed"
  :branch "master"
  :commit "9892a40d4cf970a2916a984544b7f984fc12f55c"
  :config (do
           ((. (require :aniseed.env) :init))))

; [kommentary](https://github.com/b3nj5m1n/kommentary))
; This is a plugin I wrote a while back, it's similar to tpope's [vim-commentary](https://github.com/tpope/vim-commentary), but written in lua and with more functionality. About a year after I wrote this plugin, we also got [Comment.nvim](https://github.com/numToStr/Comment.nvim), which has a bit more functionality than kommentary and is definitely worth checking out if you don't already have a commenting plugin.
(paq "kommentary" "Comment out text"
  "b3nj5m1n/kommentary"
  :commit "533d768a140b248443da8346b88e88db704212ab"
  :event "VimEnter"
  :module "kommentary"
  :setup (_G.config.var.set-var :kommentary_create_default_mappings false)
  :config (do
           (set-keymap "Normal: Toggle comment on current line"
             "gcc" "<Plug>kommentary_line_default")
           (set-keymap "Normal: Toggle comment on motion"
             "gc" "<Plug>kommentary_motion_default")
           (set-keymap "Visual: Toggle comment on visual selection"
             "gc" "<Plug>kommentary_visual_default")
           ((. (require :kommentary.config) :configure_language) [:norg]
             {:single_line_comment_string :auto
              :multi_line_comment_strings :auto})))
              ; :hook_function (. (require :ts_context_commentstring.internal) :update_commentstring)

; [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring))
; (paq "nvim-ts-context-commentstring" "Change commentstring in nested languages"
;   "JoosepAlviste/nvim-ts-context-commentstring"
;   :commit "32d9627123321db65a4f158b72b757bcaef1a3f4")
       
; [neorg](https://github.com/nvim-neorg/neorg))
(paq "neorg" "Org-mode equivalent for neovim"
  "nvim-neorg/neorg"
  :commit "10cd28e3bec3f6583f545ba0d504e65f63a64aae"
  :requires ["nvim-lua/plenary.nvim" "nvim-treesitter/nvim-treesitter"]
  :ft "norg"
  :module "neorg"
  :config ((. (require :neorg) :setup) {:load {
                                               :core.defaults {}
                                               :core.norg.concealer {:config {:preset :icons}}
                                               :core.norg.completion {:config {:engine :nvim-cmp}}
                                               :core.norg.esupports.metagen {:config {:type :auto}}}}))

; [dracula](https://github.com/Mofiqul/dracula.nvim))
; (paq "dracula" "Dracula colorscheme with treesitter support"
;  "Mofiqul/dracula.nvim"
;  :commit "55f24e76a978c73c63d22951b0700823f21253b7"
;  :event "UiEnter"
;  :config (vim.cmd "colorscheme dracula"))

; [gruvbox](https://github.com/ellisonleao/gruvbox.nvim))
; (paq "gruvbox" "Gruvbox colorscheme"
;   "ellisonleao/gruvbox.nvim"
;   :commit "2fc4980dfa17e76f7c7e963caa69599051d2e75e"
;   ; :event "UiEnter"
;   :config (do
;            (local gruvbox (require :gruvbox))
;            (vim.cmd "colorscheme gruvbox")))
     
; [catppuccin](https://github.com/catppuccin/nvim))
(paq "catppuccin" "Catppuccin colorscheme"
  "catppuccin/nvim"
  ; :as "colorscheme"
  :commit "e695645298320e9714d10897aadee3cb5951567a"
  :config (do
           (local catppuccin (require :catppuccin))
           (catppuccin.setup {
                              :flavour "macchiato"})
           (vim.cmd "colorscheme catppuccin")))

; [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim))
(paq "indent-blankline" "Show indent guides"
  "lukas-reineke/indent-blankline.nvim"
  :branch "master"
  :commit "db7cbcb40cc00fc5d6074d7569fb37197705e7f6"
  ; :after "colorscheme"
  ; :module "indent_blankline"
  :event "UiEnter"
  :config ((. (require :indent_blankline) :setup) {
                                                   :char "|"
                                                   :space_char_blankline " "
                                                   :show_current_context true
                                                   :buftype_exclude {1 :terminal}}))
   
; [leap.nvim](https://github.com/ggandor/leap.nvim))
(paq "leap" "Smooth af navigation plugin"
  "ggandor/leap.nvim"
  :branch "main"
  :commit "847a1dcfb1a3a576860151754d95fb3b0014663e"
  :config ((. (require :leap) :add_default_mappings)))
  ; :event "UiEnter")

; [nvim-parinfer](https://github.com/gpanders/nvim-parinfer))
(paq "parinfer" "Parinfer plugin written in lua"
  "gpanders/nvim-parinfer"
  :branch "master"
  :commit "82bce5798993f4fe5ced20e74003b492490b4fe8")
  ; :event "UiEnter")

; [telescope](https://github.com/nvim-telescope/telescope.nvim))
(paq "telescope" "Fuzzy finder"
  "nvim-telescope/telescope.nvim"
  :branch "master"
  :commit "97847309cbffbb33e442f07b8877d20322a26922"
  :requires "nvim-lua/plenary.nvim"
  ; :event "UiEnter"
  :config (do
           (set-keymap "Normal: Open fuzzy file finder"
             "<leader>tf" (. (require :telescope.builtin) :find_files))
           (set-keymap "Normal: Open live grep"
             "<leader>tg" (. (require :telescope.builtin) :live_grep))
           (set-keymap "Normal: Open buffer list"
             "<leader>tb" (. (require :telescope.builtin) :buffers))))
   
; [nvim-autopairs](https://github.com/windwp/nvim-autopairs))
(paq "autopairs" "Autopairs"
  "windwp/nvim-autopairs"
  :branch "master"
  :commit "6b6e35fc9aca1030a74cc022220bc22ea6c5daf4"
  :event "InsertEnter"
  :module "nvim-autopairs"
  :config ((. (require :nvim-autopairs) :setup)))

; [vim-repeat](https://github.com/tpope/vim-repeat))
(paq "vim-repeat" "Repeat plugin commands using dot"
  "tpope/vim-repeat"
  :branch "master"
  :commit "24afe922e6a05891756ecf331f39a1f6743d3d5a"
  :event "BufEnter")

; [nvim-surround](https://github.com/kylechui/nvim-surround))
(paq "nvim-surround" "Surround text objects"
  "kylechui/nvim-surround"
  :branch "main"
  :commit "7e5096b736ae252d04d543af6a13280125dc6d0f"
  :event "InsertEnter"
  :config ((. (require :nvim-surround) :setup)))

; [nvim-colorizer](https://github.com/nvchad/nvim-colorizer.lua))
(paq "nvim-colorizer" "Highlight color codes"
  "nvchad/nvim-colorizer.lua"
  :branch "master"
  :commit "760e27df4dd966607e8fb7fd8b6b93e3c7d2e193"
  :event "BufEnter"
  :module "colorizer"
  :config ((. (require :colorizer) :setup)))
   
; [editorconfig](https://github.com/editorconfig/editorconfig-vim))
(paq "editorconfig" "Automatically load some configuration options based on project"
  "editorconfig/editorconfig-vim"
  :branch "master"
  :commit "a8e3e66deefb6122f476c27cee505aaae93f7109")

; [feline.nvim](https://github.com/feline-nvim/feline.nvim))
(paq "feline" "Statusline"
  "feline-nvim/feline.nvim"
  :branch "master"
  :commit "6d4e3f934bffaa1893a690cd9b8f8b584ef0a7ea")

; [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons))
(paq "web-deviconds" "File icons"
   "kyazdani42/nvim-web-devicons"
   :branch "master"
   :commit "9061e2d355ecaa2b588b71a35e7a11358a7e51e1")

; [vim-vinegar](https://github.com/tpope/vim-vinegar))
(paq "vim-vinegar" "Netrw improvements"
  "tpope/vim-vinegar"
  :branch "master"
  :commit "bb1bcddf43cfebe05eb565a84ab069b357d0b3d6")

; [conjure](https://github.com/Olical/conjure))
(paq "conjure" "Interactive evaluation"
  "Olical/conjure"
  :branch "master"
  :commit "839fe23a7746f03aa9ef1ebf087501cd6126cf0f"
  :config (do))

; [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter))
(paq "nvim-treesitter" "Treesitter abstraction layer"
     "nvim-treesitter/nvim-treesitter"
     :branch "master"
     :commit "c155b6bb308269ca4a376777a8621261efbd17cb"
     :config 
     (do
       (local parser-configs ((. (require :nvim-treesitter.parsers)
                                 :get_parser_configs)))
       (set parser-configs.norg 
            {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg"
                            :files {1 :src/parser.c 2 :src/scanner.cc}
                            :branch :main}})
       ((. (require :nvim-treesitter.configs) :setup) 
        {; :ensure_installed :all
         :highlight {:enable true}
         :indent {:enable true}
         ; :context_commentstring {:enable true :enable_autocmd false}
         :rainbow
         {:enable true
          :colors [ "#bd93f9" "#50fa7b" "#ffb86c" "#ff79c6" "#8be9fd" "#f1fa8c"]}
         :textobjects 
         {:select {
                   :enable true
                   :keymaps {
                             :af "@function.outer"
                             :if "@function.inner"
                             :ac "@class.outer"
                             :ic "@class.inner"}}
          :move {
                 :enable true
                 :goto_next_start {"]m" "@function.outer" "]]" "@class.outer"}
                 :goto_next_end {"]M" "@function.outer" "][" "@class.outer"}
                 :goto_previous_start {"[m" "@function.outer" "[[" "@class.outer"}
                 :goto_previous_end {"[M" "@function.outer" "[]" "@class.outer"}}}})))

; [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects))
(paq "treesitter-textobjects" "Textobjects like functions from treesitter"
  "nvim-treesitter/nvim-treesitter-textobjects"
  :branch "master"
  :commit "13739a5705d9592cbe7da372576363dc8ea5f723"
  :event "UiEnter")

; [nvim-ts-rainbow](https://github.com/p00f/nvim-ts-rainbow))
(paq "rainbow-parens" "Color nested parens using treesitter"
  "p00f/nvim-ts-rainbow"
  :branch "master"
  :commit "1ec3f880585c644ddd50a51502c59f4e36f03e62"
  :event "UiEnter")

; [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig))
(paq "lspconfig" "Lsp abstraction layer"
  "neovim/nvim-lspconfig"
  :branch "master"
  :commit "2315a397fd5057e3a74a09a240f606af28447ebf"
  ; :event "VimEnter"
  :config (do
           (local lspconfig (require :lspconfig))
          ; (var capabilities (vim.lsp.protocol.make_client_capabilities))
          ; (set capabilities
          ;      (. (require :cmp_nvim_lsp) :default_capabilities))
           (local capabilities ((. (require :cmp_nvim_lsp) :default_capabilities)))
           (local servers [:bashls :cmake :jedi_language_server
                           :cssls :elmls :html :jsonls :clojure_lsp
                           :tsserver :tsserver :yamlls :hls :rnix])
           (each [_ server (pairs servers)]
             ((. (. lspconfig server) :setup) { :capabilities capabilities}))
           (lspconfig.clangd.setup 
            {:capabilities capabilities
             :single_file_support true
             :cmd [:clangd :--completion-style=detailed "-fallback-style=LLVM"]})
           (set-keymap "Normal: Format buffer"
             "<leader>ll" vim.lsp.buf.format)))

; [rust-tools.nvim](https://github.com/simrat39/rust-tools.nvim))
(paq "rust-tools" "More support for rust analyzer"
  "simrat39/rust-tools.nvim"
  :branch "master"
  :commit "99fd1238c6068d0637df30b6cee9a264334015e9")

; [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls))
(paq "nvim-jdtls" "More support for java lsp"
  "mfussenegger/nvim-jdtls"
  :branch "master"
  :commit "f39efa0e823bcc876d18a7b44d3b61191c42e61c")

; [lspsaga.nvim](https://github.com/glepnir/lspsaga.nvim))
(paq "lspsaga" "Better lsp ui"
  "glepnir/lspsaga.nvim"
  :commit "391cf74475ad094ccad7c5501710b27fcdb9b883"
  :event "VimEnter"
  :module "lspsaga"
  :config (do (. (require :lspsaga) :init_lsp_saga)
            (set-keymap "Normal: Code action"
              "<leader>la" "<cmd>Lspsaga code_action<CR>")
            (set-keymap "Normal: Hover doc"
              "<leader>lh" "<cmd>Lspsaga hover_doc<CR>")
            (set-keymap "Normal: Rename symbol under cursor"
              "<leader>lr" "<cmd>Lspsaga rename<CR>")
            (set-keymap "Normal: Peek definition"
              "<leader>ld" "<cmd>Lspsaga peek_definition<CR>")))
    
; [trouble.nvim](https://github.com/folke/trouble.nvim))
(paq "trouble" "Better diagnostics ui"
  "folke/trouble.nvim"
  :commit "ed65f84abc4a1e5d8f368d7e02601fc0357ea15e"
  :event "BufEnter"
  :config (do
           ((. (require :trouble) :setup) {})
           (set-keymap "Normal: Open Trouble window"
             "<leader>xx" "<cmd>Trouble<cr>")))

; [nvim-cmp](https://github.com/hrsh7th/nvim-cmp))
(paq "nvim-cmp" "Completion plugin"
  "hrsh7th/nvim-cmp"
  :commit "9bb8ee6e2d6ab3c8cc53323b79f05886bc722faa"
  :config 
  (do
   (local cmp (require :cmp))
   (cmp.setup
     {:snippet {}
      :expand (fn [args]
               ((. (require :luasnip) :lsp_expand) args.body))
      :window
      {:completion
       {:winhighlight "Normal:Pmenu,FloatBorder:Pmenu,Search:None"
        :col_offset (- 3)
        :side_padding 0}}
      :formatting
      {:fields [:kind :abbr :menu]
       :format (fn [entry vim-item]
                (local kind (((. (require :lspkind) :cmp_format) {:mode :symbol_text :maxwidth 50}) entry vim-item))
                (local strings (vim.split kind.kind "%s" {:trimempty true}))
                (set kind.kind (.. " " (. strings 1) " "))
                (set kind.menu (.. "    (" (. strings 2) ")"))
                kind)}
      :mapping (cmp.mapping.preset.insert {
                                           :<C-n> (cmp.mapping.select_next_item ["i" "c"])
                                           :<C-p> (cmp.mapping.select_prev_item ["i" "c"])
                                           :<C-b> (cmp.mapping.scroll_docs (- 4) ["i" "c"])
                                           :<C-d> (cmp.mapping.scroll_docs 4 ["i" "c"])
                                           :<C-f> (cmp.mapping.complete ["i" "c"])
                                           :<C-e> (cmp.mapping.abort ["i" "c"])
                                           :<CR> (cmp.mapping.confirm {:select true} ["i" "c"])})
      :sources (cmp.config.sources [
                                    {:name :nvim_lsp}
                                    {:name :nvim_lsp_signature_help}
                                    {:name :neorg}
                                    {:name :luasnip}
                                    {:name :path}
                                    {:name :omni}
                                    {:name :buffer}])
      :sorting {
                :comparators [cmp.config.compare.score]}})
   (cmp.setup.cmdline [ "/" "?" ] {
                                   :mapping (cmp.mapping.preset.cmdline)
                                   :sources (cmp.config.sources [{:name :buffer}])})
   (cmp.setup.cmdline ":" {
                           :mapping (cmp.mapping.preset.cmdline)
                           :sources (cmp.config.sources [{:name :path}] [{:name :cmdline}])})))

; [lspkind.nvim](https://github.com/onsails/lspkind.nvim))
(paq "lspkind" "vscode-like pictograms for neovim lsp completion items "
  "onsails/lspkind.nvim"
  :branch "master"
  :commit "c68b3a003483cf382428a43035079f78474cd11e")

; [nvim-cmp-lsp](https://github.com/hrsh7th/cmp-nvim-lsp))
(paq "cmp-lsp" "Cmp provider for lsp"
  "hrsh7th/cmp-nvim-lsp"
  :commit "3cf38d9c957e95c397b66f91967758b31be4abe6")

; [nvim-cmp-lsp-signature-help](https://github.com/hrsh7th/cmp-nvim-lsp-signature-help))
(paq "cmp-lsp-signature" "Cmp provider for lsp signatures"
  "hrsh7th/cmp-nvim-lsp-signature-help"
  :commit "d2768cb1b83de649d57d967085fe73c5e01f8fd7")

; [nvim-cmp-buffer](https://github.com/hrsh7th/cmp-buffer))
(paq "cmp-buffer" "Cmp provider for buffer words"
  "hrsh7th/cmp-buffer"
  :commit "3022dbc9166796b644a841a02de8dd1cc1d311fa")

; [nvim-cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline))
(paq "cmp-cmdline" "Cmp provider for commandline"
  "hrsh7th/cmp-cmdline"
  :commit "c66c379915d68fb52ad5ad1195cdd4265a95ef1e")

; [nvim-cmp-path](https://github.com/hrsh7th/cmp-path))
(paq "cmp-path" "Cmp provider for filepaths"
  "hrsh7th/cmp-path"
  :commit "91ff86cd9c29299a64f968ebb45846c485725f23")

; [nvim-cmp-luasnip](https://github.com/saadparwaiz1/cmp_luasnip))
(paq "cmp-luasnip" "Cmp provider for luasnip"
  "saadparwaiz1/cmp_luasnip"
  :branch "master"
  :commit "a9de941bcbda508d0a45d28ae366bb3f08db2e36")

; [LuaSnip](https://github.com/L3MON4D3/LuaSnip))
(paq "luasnip" "Snippet engine"
  "L3MON4D3/LuaSnip"
  :branch "master"
  :commit "663d54482b11bca1ce94f56993b9f6ab485a13dc"
  :config (do
           (local luasnip (require :luasnip))
           ((. (require :luasnip.loaders.from_vscode) :lazy_load))
           (luasnip.config.setup 
             {:history true
              :enable_autosnippets false})))

; [friendly-snippets](https://github.com/rafamadriz/friendly-snippets))
(paq "friendly-snippets" "Snippet collection"
  "rafamadriz/friendly-snippets"
  :commit "bb318c455e4e8946d64c79753f5bb07f7c27d711")

; [neogit](https://github.com/TimUntersberger/neogit))
(paq "neogit" "Magit for neovim"
  "TimUntersberger/neogit"
  :branch "master"
  :commit "1acb13c07b34622fe1054695afcecff537d9a00a"
  :requires "nvim-lua/plenary.nvim"
  :after "plenary.nvim"
  :config ((. (require :neogit) :setup) {}))

; [vim-fugitive](https://github.com/tpope/vim-fugitive))
(paq "fugitive" "Basic git integration"
  "tpope/vim-fugitive"
  :branch "master"
  :commit "4b0f2b604562e9681ae3b80c2665f168ac637cea"
  :event "BufEnter")

; [gitsigns](https://github.com/lewis6991/gitsigns.nvim))
(paq "gitsigns" "Show added/removed/changed lines"
  "lewis6991/gitsigns.nvim"
  :commit "851cd32caaea84f303c4fdf51d72dfa5fcd795bb"
  :requires "nvim-lua/plenary.nvim"
  :event "BufEnter"
  :config ((. (require :gitsigns) :setup) 
           {:signs {}
            :add
            {:hl :GitSignsAdd
             :text "▌"
             :numhl :GitSignsAddNr
             :linehl :GitSignsAddLn}
            :change
            {:hl :GitSignsChange
             :text "▌"
             :numhl :GitSignsChangeNr
             :linehl :GitSignsChangeLn}
            :current_line_blame true
            :current_line_blame_opts
            {:virt_text true
             :virt_text_pos :eol
             :delay 5000
             :ignore_whitespace false}
            :on_attach (fn _G.config.plugin-configs.gitsigns-on-attach [bufnr]
                        (vim.api.nvim_exec "highlight GitSignsCurrentLineBlame guifg=#5a5e7a"
                          false))}))
    

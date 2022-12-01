(module plugin-config
  {require
   {util util}})

(defn colorscheme []
      (local catppuccin (require :catppuccin))
      (catppuccin.setup 
        {:flavour "macchiato"})
      (vim.cmd "colorscheme catppuccin"))

; (defn aniseed []
;       ((. (require :aniseed.env) :init)))

(defn kommentary []
      (util.set-keymap "Normal: Toggle comment on current line"
        "gcc" "<Plug>kommentary_line_default")
      (util.set-keymap "Normal: Toggle comment on motion"
        "gc" "<Plug>kommentary_motion_default")
      (util.set-keymap "Visual: Toggle comment on visual selection"
        "gc" "<Plug>kommentary_visual_default")
      (local kommentary (require :kommentary.config))
      (kommentary.configure_language) [:norg]
        {:single_line_comment_string :auto
         :multi_line_comment_strings :auto})
         ; :hook_function (. (require :ts_context_commentstring.internal) :update_commentstring)

(defn neorg []
      (. (require :neorg) :setup) {:load {}
                                         :core.defaults {}
                                         :core.norg.concealer {:config {:preset :icons}}
                                         :core.norg.completion {:config {:engine :nvim-cmp}}
                                         :core.norg.esupports.metagen {:config {:type :auto}}})

(defn indent-blankline []
      (. (require :indent_blankline) :setup) {
                                              :char "|"
                                              :space_char_blankline " "
                                              :show_current_context true
                                              :buftype_exclude {1 :terminal}})

(defn leap []
      ((. (require :leap) :add_default_mappings)))

(defn autopairs []
      ((. (require :nvim-autopairs) :setup)))

(defn nvim-surround []
      ((. (require :nvim-surround) :setup)))

(defn nvim-colorizer []
      ((. (require :colorizer) :setup)))

(defn nvim-treesitter []
      (local parser-configs ((. (require :nvim-treesitter.parsers) :get_parser_configs)))
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
                :goto_previous_end {"[M" "@function.outer" "[]" "@class.outer"}}}}))

(defn lspconfig []
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
        :cmd [:clangd :--completion-style=detailed "-fallback-style=LLVM"]}))

(defn lspsaga []
      ((. (require :lspsaga) :init_lsp_saga)))

(defn trouble []
      ((. (require :trouble) :setup) {})
      (util.set-keymap "Normal: Open Trouble window"
                       "<leader>xx" "<cmd>Trouble<cr>"))
(defn nvim-cmp []
      (local cmp (require :cmp))
      (cmp.setup
        {:snippet 
         {:expand (fn [args]
                    ((. (require :luasnip) :lsp_expand) args.body))}
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
                              :sources (cmp.config.sources [{:name :path}] [{:name :cmdline}])}))

(defn luasnip []
      (local luasnip (require :luasnip))
      ((. (require :luasnip.loaders.from_vscode) :lazy_load))
      (luasnip.config.setup 
        {:history true
         :enable_autosnippets false}))

(defn neogit []
      (local ng (require :neogit))
      (ng.setup {}))

(defn gitsigns []
      (local gs (require :gitsigns))
      (gs.setup 
         {:signs {
                  :add
                  {:hl :GitSignsAdd
                   :text "▌"
                   :numhl :GitSignsAddNr
                   :linehl :GitSignsAddLn}
                  :change
                  {:hl :GitSignsChange
                   :text "▌"
                   :numhl :GitSignsChangeNr
                   :linehl :GitSignsChangeLn}}
          :current_line_blame true
          :current_line_blame_opts
          {:virt_text true
           :virt_text_pos :eol
           :delay 5000
           :ignore_whitespace false}
          :on_attach (fn _G.config.plugin-configs.gitsigns-on-attach [bufnr]
                       (vim.api.nvim_exec "highlight GitSignsCurrentLineBlame guifg=#5a5e7a"
                                          false))}))

(defn conjure []
  (util.set-var "conjure#highlight#enabled" true)
  (util.set-var "conjure#highlight#group" "IncSearch")
  (util.set-var "conjure#highlight#timeout" "200"))

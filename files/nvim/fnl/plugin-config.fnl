(module plugin-config
  {require
   {util util
    lsp-util lsp-util}})

(defn colorscheme []
      (local catppuccin (require :catppuccin))
      (catppuccin.setup 
        {:flavour "macchiato"})
      (vim.cmd "colorscheme catppuccin"))

(defn mode-changed []
  (let [mode (match (. (vim.api.nvim_get_mode) :mode)
               "n" "normal"
               "i" "insert")
        hl (. (require "fennel-config") :highlight)]
    (hl.create-groups-telescope mode)
    (hl.create-groups-cursor-line mode)))

(defn watch-mode-changes []
  (vim.api.nvim_create_augroup "ModeChanges" {:clear true})
  (vim.api.nvim_create_autocmd "ModeChanged"
                               {:group "ModeChanges"
                                :pattern []
                                :callback mode-changed}))

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

(defn dressing []
      ((. (require :dressing) :setup)
       {:input {
                :enabled true
                :default_prompt "Input:"
                :prompt_align :left
                :insert_only true
                :start_in_insert true
                ; :anchor :SW
                :border :rounded
                :relative :cursor
                :win_options {:winblend 10
                              :wrap false}}
        :select {:enabled true
                 :backend [:telescope
                           :builtin]
                 :trim_prompt true}}))

(defn neorg [])
  ; (. (require :neorg) :setup) {:load {
  ;                                          :core.defaults {}
  ;                                          :core.concealer {:config {:preset :icons}}
  ;                                          :core.completion {:config {:engine :nvim-cmp}}
  ;                                          :core.esupports.metagen {:config {:type :auto}}}})

(defn indent-blankline [])
      ; (def highlight (require "highlight"))
      ; (highlight.create-groups-indent-blankline)
      ; (. (require :ibl) :setup) {}
       ; :char "|"
       ; :space_char_blankline " "
       ; :show_current_context true
       ; :buftype_exclude {1 :terminal}
       ; :indent
       ; { :highlight
       ;  [:RainbowRed
       ;   :RainbowYellow
       ;   :RainbowBlue
       ;   :RainbowOrange
       ;   :RainbowGreen
       ;   :RainbowViolet
       ;   :RainbowCyan]}}
      ; (print "askldf\nasdfkljasd"))


(defn leap []
      ((. (require :leap) :add_default_mappings)))

; (defn autopairs []
;       ((. (require :nvim-autopairs) :setup)))

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
       {:ensure_installed ["markdown" "rust" "lua" "fennel" "python"]
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
      (local capabilities (lsp-util.get-capabilities))
      (local servers [:bashls :cmake :jedi_language_server
                      :cssls :elmls :html :jsonls :clojure_lsp
                      :ts_ls :yamlls :hls :nil_ls
                      :fennel_language_server]) ; :typst_lsp])
      (each [_ server (pairs servers)]
        ((. (. lspconfig server) :setup)
         {:capabilities capabilities
          :handlers (lsp-util.get-handlers)}))
      (lspconfig.clangd.setup
       {:capabilities capabilities
        :single_file_support true
        :cmd [:clangd :--completion-style=detailed "-fallback-style=LLVM"]})
      (lspconfig.ltex.setup
       {:capabilities capabilities
        :single_file_support true
        :settings {
                   :ltex {
                          :language "de-DE"}}})
      (lspconfig.texlab.setup
        {:capabilities capabilities
         :handlers (lsp-util.get-handlers)
         :settings {
                    :bibtexFormatter :texlab
                    ; :build {:args [:-pdf
                    ;                :-interaction=nonstopmode
                    ;                :-synctex=1
                    ;                "%f"]
                    ;         :executable :latexmk
                    ;         :forwardSearchAfter false
                    ;         :onSave false}
                    :chktex {:onEdit false :onOpenAndSave false}
                    :diagnosticsDelay 300
                    :formatterLineLength 80
                    :forwardSearch {:args {}}
                    :latexFormatter :latexindent
                    :latexindent {:local "../../latexindent.yaml" :modifyLineBreaks false}}})
      (vim.api.nvim_create_augroup "hover" {:clear true})
      (vim.api.nvim_create_autocmd "CursorHold"
                             {:group "hover"
                              :command "lua vim.diagnostic.open_float({ scope = \"cursor\" })"}))

; (defn lspsaga []
;       ((. (require :lspsaga) :init_lsp_saga)))

(defn lsp-lines []
      ((. (require :lsp_lines) :setup))
      (vim.diagnostic.config {:virtual_text false}))

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
      ; ((. (require :luasnip.loaders.from_vscode) :lazy_load))

      (local ls (require :luasnip))
      (local s ls.snippet)
      (local sn ls.snippet_node)
      (local isn ls.indent_snippet_node)
      (local t ls.text_node)
      (local i ls.insert_node)
      (local f ls.function_node)
      (local c ls.choice_node)
      (local d ls.dynamic_node)
      (local r ls.restore_node)
      (local events (require :luasnip.util.events))
      (local ai (require :luasnip.nodes.absolute_indexer))
      (local extras (require :luasnip.extras))
      (local l extras.lambda)
      (local rep extras.rep)
      (local p extras.partial)
      (local m extras.match)
      (local n extras.nonempty)
      (local dl extras.dynamic_lambda)
      (local fmt (. (require :luasnip.extras.fmt) :fmt))
      (local fmta (. (require :luasnip.extras.fmt) :fmta))
      (local conds (require :luasnip.extras.expand_conditions))
      (local postfix (. (require :luasnip.extras.postfix) :postfix))
      (local types (require :luasnip.util.types))
      (local parse (. (require :luasnip.util.parser) :parse_snippet))
      (local ms ls.multi_snippet)
      (local k (. (require :luasnip.nodes.key_indexer) :new_key))

      (ls.add_snippets :all
                       [
                        (s :TODAY
                          (f (fn [] (os.date "%Y/%m/%d"))))

                        (s :NOW
                          (f (fn [] (os.date "%H:%M"))))])

      (ls.add_snippets :tex
                       [
                        (s :frac
                          (fmt "\\frac{{{}}}{{{}}}" [(i 1) (i 2)]))])

      (ls.add_snippets :lua
                       [
                        (s :req
                          (fmt "local {} = require('{}')" [(i 1 :default) (rep 1)]))])
                        

                        
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
                  {
                   ; :hl :GitSignsAdd
                   :text "▌"}
                   ; :numhl :GitSignsAddNr
                   ; :linehl :GitSignsAddLn}
                  :change
                  {
                   ; :hl :GitSignsChange
                   :text "▌"}}
                   ; :numhl :GitSignsChangeNr
                   ; :linehl :GitSignsChangeLn}}
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

(defn netrw []
  (local nrw (require :netrw))
  (nrw.setup {}))

(defn murmur []
  (local mm (require :murmur))
  (mm.setup {
             :cursor_rgb "#494d64"}))

(defn ufo []
  (local ufo (require :ufo))
  (ufo.setup {}))

(defn get-executable []
  (coroutine.create 
    (fn [dap-run-co]
      (local scan (require "plenary.scandir"))
      (let [files (scan.scan_dir "." {})]
        (vim.ui.select files { :prompt "Select executable:"} 
                       (fn [choice]
                         (coroutine.resume dap-run-co choice)))))))

(defn dap []
  (local dap (require :dap))
  (set dap.adapters.codelldb
     {:type "server"
      :port "${port}"
      :executable {:command "/usr/bin/codelldb"
                   :args [:--port "${port}"]}})
  (local codelldb {:name "Launch file"
                   :type "codelldb"
                   :request "launch"
                   :program get-executable
                   :cwd "${workspaceFolder}"
                   :stopOnEntry false
                   :args {}
                   :runInTerminal true
                   :console "integratedTerminal"})
  (local configurations { 
                         :c [codelldb]})
  (set dap.configurations configurations)

  (local dap-ui (require :dapui))
  (dap-ui.setup))

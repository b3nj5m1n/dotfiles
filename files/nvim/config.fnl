
; * Introduction
;  This is a literate neovim configuration written in fennel. The goal is a fast and maintainable configuration with as few dependencies as possible.

;  This document is written in [norg](https://github.com/nvim-neorg/neorg), the code blocks are extracted using treesitter. The makefile in this directory automatcially extracts the fennel code from this document to a file called `config.fnl` in the `./build` directory, then compiles that to a lua file. When running the the default target, it will also copy the compiled lua file to nvim's config directory and create an `init.lua` file in the `./build` directory. You can run nvim with the `-u` flag to test the config out, i.e. `nvim -u build/init.lua`.

; * Definitions
;   Any functions or variables we define in here won't be accesible by neovim, but in certain instances we need to have access to these functions. For example, we use packer to manage plugins, and packer accepts a `config` field for any plugin with a function to run as configuration for the given plugin. If we want to set a keymap as part of a plugins configuration, we need to expose the function we create to handle keymaps to neovim.

;   We achieve this by creating any definitions and variables und a global `config` table. It will hold serveral sub-tables, such as `plugin-configs` for the plugin configuration function, `fn` for all general-purpose function we define (such as those for settings keymaps), etc.
;   @code fennel
  (tset _G :config { :plugins {} :plugin-configs {} :plugin-setups {} :fn {} :var {} } )
;   @end
;   Since we don't want to have to prefix every function call in this document with `_G.config.fn.`, we also want to create a local variable pointing to the global function. Let's create a macro for automating this process:
;   @code fennel
  (macro def-fn [fn-name fn-args ...]
    '(local ,fn-name (let [f# (fn ,(sym (.. "_G.config.fn." (. fn-name 1))) ,fn-args ,[...])]
                    (set ,(sym (.. "_G.config.fn." (. fn-name 1))) f#)
                    f#)))
  (macro def-var [var-name var-value]
    '(local ,var-name (do
                    (set ,(sym (.. "_G.config.var." (. var-name 1))) ,var-value)
                    ,var-value)))
;   @end
;   We can now use `def-fn` in place of `fn` to create a function under `_G.config.fn` and add a local variable pointing to that global function. The same goes for variables using the `def-var` macro in place of `local`.

; ** Common functions from the neovim API
;    When calling functions from the internal neovim lua api, I don't want to have to prefix everything with `vim.api.`, so we'll create some "aliases" to these functions.
;    @code fennel
   (def-var set-var vim.api.nvim_set_var)

   (def-var get-opt vim.api.nvim_get_option)

   (def-var expand vim.fn.expand) ; Expand enviornment variables in string
;    @end
;    We won't be calling some functions directly, for example, we'll define a macro for handling keymaps, I'll prefix these functions with `nvim` to indicate this.
;    @code fennel
   (def-var nvim-set-keymap vim.api.nvim_set_keymap)

   (def-var nvim-set-opt vim.api.nvim_set_option_value)
;    @end
; ** Custom Functions & Macros

; *** Option management
;     `nvim-set-option` requires an option table, however, I don't need to set any of these options, so I'll create a wrapper function that will automatcially pass an empty option table.
;     @code fennel
    (def-fn set-opt [option-name option-value]
      "Set nvim option with an empty options table. Wrapper around nvim-set-opt."
      (nvim-set-opt option-name option-value {}))
;     @end
;     This is a convenience function to allow me to set multiple options with one function call.
;     @code fennel
    (def-fn set-opts [...]
      "Set multiple options."
      (for [i 1 (length [...]) 2]
        (set-opt (. [...] i) (. [...] (+ 1 i)))))
;     @end
; *** Keymap management
;     Keymaps can take two forms, they either map some left-side to a right-side, for example, the key `t` to the keys `itest` (which will insert the text test when you press t), or they map some left-side to a lua callback, for example the key `t` to the function `print("test")`, which will print "test" when you press t.

;     When you use the lua api to create the keymaps, though, you always have to specify a right-side, it's just ignored when you pass a callback in the options table. Let's define some functions to make this a little easier for ourselves.
;     @code fennel
    (def-fn set-keymap-pure [description mode left-side right-side]
      "Set a 'pure' keymap, i.e. no callback"
      (let [opts { :noremap true :silent true :desc description }]
        (nvim-set-keymap mode left-side right-side opts)))

    (def-fn set-keymap-callback [description mode left-side callback]
      "Set a keymap with a callback."
      (let [opts { :noremap true :silent true :desc description :callback callback }]
        (nvim-set-keymap mode left-side "" opts)))
;     @end
;     When you specify a keymap, you have to tell neovim for what mode it is, for example normal mode or insert mode. You can also specify an optional description for what the mapping does. I want to combine this, so I can just specify mode and description in one string, something like this: /Normal: Execute that one command/. Let's write a macro to do just that, and while we're at it, let's make it figure out whether the third argument is a string or a function, and based on that decide whether to call `set-keymap-pure` or `set-keymap-callback`.
;     @code fennel
    (macro set-keymap [description left-side right-side-or-callback]
      "Set keymap with description, default options and either left-side or callback."
      (fn get-description-prefix [s]
        "If description is 'Normal: text text', this function will return 'normal'"
        (string.lower (string.sub s 1 (- (string.find s ":" 1 true) 1))))
      (fn get-description [s]
        "If description is 'Normal: text text', this function will return 'text text'"
        (string.sub s (+ (string.find s ":" 1 true) 2)))
      (local mode (match (get-description-prefix description)
        "normal" "n"
        "visual" "v"
        "insert" "i"
        "terminal" "t"
        ))
      (local description (get-description description))
      (match (type right-side-or-callback)
          "string" '(_G.config.fn.set-keymap-pure ,description ,mode ,left-side ,right-side-or-callback)
          "table" '(_G.config.fn.set-keymap-callback ,description ,mode ,left-side ,right-side-or-callback)))
;     @end
; *** Plugin management
;     Neovim doesn't /really/ have a built-in plugin manager, and there are tons of available options. I'm currently using [packer](https://github.com/wbthomason/packer.nvim), but I don't want to be dependendent on that, so my approach to plugin management is built to allow for easily switching out the plugin manager without having to make changes to my plugin declarations.

;     There's a `plugins` table in our global `config` table, this will store a list of plugins containing all the information we need, such as the github url, configuration, etc. Then, there's a separate function which will build a packer configuration from that global table. In theory, I could also write a function to build a vim-plug configuration. (a package manager I've used in the past)

;     You'll definitely see packer's influence on the available values, though. Here's a function which will insert a new plugin into this table with all possible parameters:
;     @code fennel
    (def-fn add-plugin [name path config setup branch commit optional command requires filetype event after disable description as]
      "Add plugin to config-local plugin-store."
      (table.insert config.plugins {
        :name name :path path :config config :setup setup
        :branch branch :commit commit :optional optional
        :command command :requires requires :filetype filetype
        :event event :after after :disable disable
        :description description :as as
      }))
;     @end

;     I don't want to have to set all possible parameters, though. And there's some other things I'd like automated.

;     - I like my plugins pinned to a specific version. In practice, I always specify the hash of the commit I want to use. This doesn't give me automatic updates, but it also guarantees (more or less) that my plugins will never break. When I want to update a plugin, I manually replace the commit hash with a newer one. I also always specify the branch name to use. Since I always want to do this, we can assume that when I don't explicitly specify the branch name, it's the default of "main".
;     - We can also assume that when we don't explicitly set the optional or disable parameters, the plugin is neither optional, nor disabled.
;     - `config` and `setup` are both functions, and I want them to be in the `_G.config.plugin-configs` and `_G.config.plugin-setups` table, respectively.
;     -- I don't want to type out the whole `(fn _G.config.plugin-x.y)
;     -- When I don't pass a function explicity, I want to set it to a function returning `nil`, since packer will always call the function and I don't want it to error when I don't specify a function.

;     Again, let's define a macro to take care of all this:
;     @code fennel
    (macro paq [name description path ...]
      (local plugin-config {
        :name name :path path :config nil :setup nil :branch nil :commit nil :optional nil
        :command nil :requires nil :filetype nil :event nil :after nil :disable nil :description description :as nil })
      (for [i 1 (length [...]) 2]
        (let [key (. [...] i) value (. [...] (+ 1 i))]
          (tset plugin-config key value)))
      (if (= (. plugin-config :branch) nil) (tset plugin-config :branch "main"))
      (if (= (. plugin-config :optional) nil) (tset plugin-config :optional false))
      (if (= (. plugin-config :disable) nil) (tset plugin-config :disable false))
      (if (not (= (. plugin-config :config) nil))
        (tset plugin-config :config '(fn ,(sym (.. "_G.config.plugin-configs." name)) [] ,(. plugin-config :config)))
        (tset plugin-config :config '(fn ,(sym (.. "_G.config.plugin-configs." name)) [] nil)))
      (if (not (= (. plugin-config :setup) nil))
        (tset plugin-config :setup '(fn ,(sym (.. "_G.config.plugin-setups." name)) [] ,(. plugin-config :setup)))
        (tset plugin-config :setup '(fn ,(sym (.. "_G.config.plugin-setups." name)) [] nil)))
      '(table.insert (. config :plugins) ,plugin-config))
;     @end

;     Finally, let's define the function I've been talking about that will build a packer config from our global plugin table:
;     @code fennel
    (def-fn init-packer []
      (do 
        (paq "packer" "Plugin manager"
          "wbthomason/packer.nvim"
          :branch "master"
          :commit "6afb67460283f0e990d35d229fd38fdc04063e0a"
          :optional true
          :command [ "PackerSync" ])
        (vim.cmd "packadd packer.nvim")
        ((. (require :packer) :startup) {1 (fn []
          (each [_ plugin (ipairs (. config :plugins))]
            (use {
              1 (. plugin :path)
              :config (. plugin :config)
              :setup (. plugin :setup)
              :branch (. plugin :branch)
              :commit (. plugin :commit)
              :opt (. plugin :optional)
              :cmd (. plugin :command)
              :requires (. plugin :requires)
              :ft (. plugin :filetype)
              :event (. plugin :event)
              :after (. plugin :after)
              :disable (. plugin :disable)
              :as (. plugin :as)})))
          :config {:compile_path (.. (vim.fn.stdpath :config) :/lua/packer_compiled.lua)}})
        (require :packer_compiled)))
;     @end


; * Options
; ** Sane defaults
;    These are what I would set as the defaults for nvim. Nothing specific to me.
;    @code fennel
   (set-var :syntax true)
   (set-opts
     :termguicolors  true  ; Enable 24-bit color
     :backup         false ; Don't create a backup file before overwriting a file
     :completeopt    "noinsert,menuone,noselect" ; Do not insert anything until the user selects it; Show the menu when there is just one match; Force the user to select something from the menu
     :encoding       "UTF-8" ; Set encoding to UTF-8
     :errorbells     false ; Disable error bell & screen flashing
     :guicursor      "n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor" ; Cursor shapes
     :hidden         true ; Don't kill buffers, when exiting, keep them around in the background
     :hlsearch       false ; No highlighting on search
     :ignorecase     true ; Ignore case in searches
     :inccommand     :split ; Show preview of substitute
     :incsearch      true ; Directly jump to next match when searching
     :mouse          :a ; Enable mouse support
     :pumheight      20 ; Max completion menu height
     :sessionoptions "blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal" ; Session management options
     :shortmess      (.. (get-opt :shortmess) :c) ; Avoid prompts for auto-complete
     :showmode       false ; Hide the -- INSERT -- at the bottom
     :smartcase      true ; Don't ignore case in searches when using case in search
     :swapfile       false ; Don't create swapfiles
     :undodir        (expand "$XDG_DATA_HOME/nvim/undodir") ; File to store undo stacks in
     :cursorcolumn   false ; Indicate current column
     :cursorline     true ; Indicate current line
     :foldexpr       "nvim_treesitter#foldexpr()" ; Auto fold based on treesitter
     :foldmethod     "expr" ; Auto fold method set to syntax (Determine folds based on file specific syntax)
     :foldnestmax    20 ; Deepest possible fold
     :number         true ; Enable line numbers
     :smartindent    true ; Automatically indent on a new line
     :undofile       true ; Keep a file with the undo stack
     :shiftwidth     4 ; Affects <<, >>, and auto indent
     :softtabstop    4 ; Number of spaces a <Tab> accounts for when editing
     :tabstop        4 ; How many spaces a <Tab> in a file accounts for
     :scrolloff      2 ; Start scrolling when 2 lines from top/bottom, i.e. always show 2 lines of context
     :sidescrolloff  4 ; Same as above but for horizontal scrolling
     :signcolumn     "yes" ; Always dispaly the signcolumn at the left side
   )
;    @end
; ** Preferences
;    @code fennel
   (set-var :mapleader " ")
   (set-opts
     :foldlevel      99 ; The higher, the more folded regions are open (0 = all folds closed)
     :foldlevelstart 99 ; Inital fold level; close all folds when opening a new buffer
     :laststatus     3 ; Global statusbar
     :wrap           false ; Long lines are displayed as one line (Horizontal scrolling required)
     :relativenumber true ; Enable relative line numbers
     :expandtab      true ; Insert spaces instead of tab
     :spelllang      "en_GB,de,es,cjk" ; Dictionarys to use for checking spelling
     :list           true ; Show invisible characters
     :listchars     "eol:↴,nbsp:+,space:⋅,tab:⟼ ,trail:-" ; Invisible character and what character to show for it
     ;:diffopt     "vertical" ; Options for viewing (git) diffs
   )
;    @end

; * Keymaps
; ** General
;    @code fennel
   (set-keymap "Visual: Keep visual selection after indenting"
     ">" ">gv")
   (set-keymap "Visual: Keep visual selection after indenting"
     "<" "<gv")
   (set-keymap "Terminal: Exit to normal mode"
     "<C-g>" "<C-\\><C-n>")
   (set-keymap "Normal: Source current file"
     "<C-s>" ":source %<CR>")
;    @end
; ** Tabs
;    @code fennel
   (set-keymap "Normal: Switch to previous tab"
     "<C-h>" ":tabprevious<CR>")
   (set-keymap "Normal: Switch to next tab"
     "<C-l>" ":tabnext<CR>")
;    @end
; ** Splits
;    @code fennel
   (set-keymap "Normal: Create vertical split"
     "<leader>wv" ":vsplit<CR>")
   (set-keymap "Normal: Create horizontal split"
     "<leader>ws" ":split<CR>")
   (set-keymap "Normal: Move to split on the left"
     "<leader>wh" "<C-W>h")
   (set-keymap "Normal: Move to split on the bottom"
     "<leader>wj" "<C-W>j")
   (set-keymap "Normal: Move to split on the top"
     "<leader>wk" "<C-W>k")
   (set-keymap "Normal: Move to split on the right"
     "<leader>wl" "<C-W>l")
;    @end
; ** Line highlighting
;    @code fennel
   (set-keymap "Normal: Toggle highlight on the current line"
     "<leader>hl" ":set cursorline!<CR>")
   (set-keymap "Normal: Toggle highlight on the current line"
     "<leader>hc" ":set cursorcolumn!<CR>")
;    @end
; ** Snippets
;    @code fennel
   (set-keymap "Insert: Expand Snippet"
     "<C-e>" "<Plug>luasnip-expand-snippet")
   (set-keymap "Insert: Jump to next point in snippet"
     "<C-j>" "<Plug>luasnip-jump-next")
   (set-keymap "Insert: Jump to previous point in snippet"
     "<C-k>" "<Plug>luasnip-jump-prev")
;    @end

; * Plugins
; ** [plenary](https://github.com/nvim-lua/plenary.nvim)
;    @code fennel
   (paq "plenary" "Common lua functions for nvim plugins"
     "nvim-lua/plenary.nvim"
     :branch "master"
     :commit "4b7e52044bbb84242158d977a50c4cbcd85070c7")
;    @end
; ** [kommentary](https://github.com/b3nj5m1n/kommentary)
;    This is a plugin I wrote a while back, it's similar to tpope's [vim-commentary](https://github.com/tpope/vim-commentary), but written in lua and with more functionality. About a year after I wrote this plugin, we also got [Comment.nvim](https://github.com/numToStr/Comment.nvim), which has a bit more functionality than kommentary and is definitely worth checking out if you don't already have a commenting plugin.
;    @code fennel
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
          :multi_line_comment_strings :auto
          :hook_function (. (require :ts_context_commentstring.internal) :update_commentstring)}))
   )
;    @end
; ** [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
;    @code fennel
   (paq "nvim-ts-context-commentstring" "Change commentstring in nested languages"
     "JoosepAlviste/nvim-ts-context-commentstring"
     :commit "32d9627123321db65a4f158b72b757bcaef1a3f4"
   )
;    @end
; ** [neorg](https://github.com/nvim-neorg/neorg)
;    @code fennel
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
              :core.norg.esupports.metagen {:config {:type :auto}}}})
   )
;    @end
; ** [dracula](https://github.com/Mofiqul/dracula.nvim)
;    @code fennel
   ;(paq "dracula" "Dracula colorscheme with treesitter support"
   ;  "Mofiqul/dracula.nvim"
   ;  :commit "55f24e76a978c73c63d22951b0700823f21253b7"
   ;  :event "UiEnter"
   ;  :config (vim.cmd "colorscheme dracula")
   ;)
;    @end
; ** [gruvbox](https://github.com/ellisonleao/gruvbox.nvim)
;    @code fennel
   ; (paq "gruvbox" "Gruvbox colorscheme"
   ;   "ellisonleao/gruvbox.nvim"
   ;   :commit "2fc4980dfa17e76f7c7e963caa69599051d2e75e"
   ;   ; :event "UiEnter"
   ;   :config (do
   ;     (local gruvbox (require :gruvbox))
   ;     (vim.cmd "colorscheme gruvbox")
   ;   )
   ; )
;    @end
; ** [catppuccin](https://github.com/catppuccin/nvim)
;    @code fennel
   (paq "catppuccin" "Catppuccin colorscheme"
     "catppuccin/nvim"
     ; :as "colorscheme"
     :commit "e695645298320e9714d10897aadee3cb5951567a"
     :config (do
       (local catppuccin (require :catppuccin))
       (catppuccin.setup {
         :flavour "macchiato"
       })
       (vim.cmd "colorscheme catppuccin")
     )
   )
;    @end
; ** [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
;    @code fennel
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
       :buftype_exclude {1 :terminal}})
   )
;    @end
; ** [leap.nvim](https://github.com/ggandor/leap.nvim)
;    @code fennel
   (paq "leap" "Smooth af navigation plugin"
     "ggandor/leap.nvim"
     :branch "main"
     :commit "847a1dcfb1a3a576860151754d95fb3b0014663e"
     :config ((. (require :leap) :add_default_mappings)))
     ; :event "UiEnter")
;    @end
; ** [nvim-parinfer](https://github.com/gpanders/nvim-parinfer)
;    @code fennel
   (paq "parinfer" "Parinfer plugin written in lua"
     "gpanders/nvim-parinfer"
     :branch "master"
     :commit "82bce5798993f4fe5ced20e74003b492490b4fe8")
     ; :event "UiEnter")
;    @end
; ** [telescope](https://github.com/nvim-telescope/telescope.nvim)
;    @code fennel
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
         "<leader>tb" (. (require :telescope.builtin) :buffers)))
   )
;    @end
; ** [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
;    @code fennel
   (paq "autopairs" "Autopairs"
     "windwp/nvim-autopairs"
     :branch "master"
     :commit "6b6e35fc9aca1030a74cc022220bc22ea6c5daf4"
     :event "InsertEnter"
     :module "nvim-autopairs"
     :config ((. (require :nvim-autopairs) :setup))
   )
;    @end
; ** [vim-repeat](https://github.com/tpope/vim-repeat)
;    @code fennel
   (paq "vim-repeat" "Repeat plugin commands using dot"
     "tpope/vim-repeat"
     :branch "master"
     :commit "24afe922e6a05891756ecf331f39a1f6743d3d5a"
     :event "BufEnter")
;    @end
; ** [nvim-surround](https://github.com/kylechui/nvim-surround)
;    @code fennel
   (paq "nvim-surround" "Surround text objects"
     "kylechui/nvim-surround"
     :branch "main"
     :commit "7e5096b736ae252d04d543af6a13280125dc6d0f"
     :event "InsertEnter"
     :config ((. (require :nvim-surround) :setup))
   )
;    @end
; ** [nvim-colorizer](https://github.com/norcalli/nvim-colorizer.lua)
;    @code fennel
   (paq "nvim-colorizer" "Highlight color codes"
     "norcalli/nvim-colorizer.lua"
     :branch "master"
     :commit "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6"
     :event "BufEnter"
     :module "colorizer"
     :config ((. (require :colorizer) :setup))
   )
;    @end
; ** [editorconfig](https://github.com/editorconfig/editorconfig-vim)
;    @code fennel
   (paq "editorconfig" "Automatically load some configuration options based on project"
     "editorconfig/editorconfig-vim"
     :branch "master"
     :commit "a8e3e66deefb6122f476c27cee505aaae93f7109")
;    @end
; ** [statusline.lua](https://github.com/beauwilliams/statusline.lua)
;    @code fennel
   (paq "statusline" "Statusline"
     "beauwilliams/statusline.lua"
     :branch "master"
     :commit "20ad26912935f91918da9f428761b6d1b651d632")
;    @end
; ** [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)
;    @code fennel
   (paq "web-deviconds" "File icons"
     "kyazdani42/nvim-web-devicons"
     :branch "master"
     :commit "9061e2d355ecaa2b588b71a35e7a11358a7e51e1")
;    @end
; ** [iron.nvim](https://github.com/hkupty/iron.nvim)
;    @code fennel
   (paq "iron" "Repl integration"
     "hkupty/iron.nvim"
     :branch "master"
     :commit "6cb2416adf8e20c8316f774bc8d0c91ab3feab41"
     :config (do
       (local iron (require :iron.core))
       (local view (require :iron.view))
       (iron.setup {
         :config {
           :close_window_on_exit true
           :scratch_repl true
           :repl_open_cmd (view.split.vertical.botright 50)}
         :keymaps {
           :send_motion "<leader>s"
           :visual_send "<leader>s"
           :send_line "<leader>ss"
           :clear "<leader>sc"}})
   ))
;    @end
; ** Treesitter
; *** [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
;     @code fennel
    (paq "nvim-treesitter" "Treesitter abstraction layer"
      "nvim-treesitter/nvim-treesitter"
      :branch "master"
      :commit "c155b6bb308269ca4a376777a8621261efbd17cb"
      :config (do
        (local parser-configs ((. (require :nvim-treesitter.parsers)
          :get_parser_configs)))
        (set parser-configs.norg {
          :install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg"
          :files {1 :src/parser.c 2 :src/scanner.cc}
          :branch :main}})
        ((. (require :nvim-treesitter.configs) :setup) {
          ; :ensure_installed :all
          :highlight {:enable true}
          :indent {:enable true}
          :context_commentstring {:enable true :enable_autocmd false}
          :rainbow {
            :enable true
            :colors [ "#bd93f9" "#50fa7b" "#ffb86c" "#ff79c6" "#8be9fd" "#f1fa8c" ]}
          :textobjects {
            :select {
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
    )
;     @end
; *** [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
;     @code fennel
    (paq "treesitter-textobjects" "Textobjects like functions from treesitter"
      "nvim-treesitter/nvim-treesitter-textobjects"
      :branch "master"
      :commit "13739a5705d9592cbe7da372576363dc8ea5f723"
      :event "UiEnter")
;     @end
; *** [nvim-ts-rainbow](https://github.com/p00f/nvim-ts-rainbow)
;     @code fennel
    (paq "rainbow-parens" "Color nested parens using treesitter"
      "p00f/nvim-ts-rainbow"
      :branch "master"
      :commit "1ec3f880585c644ddd50a51502c59f4e36f03e62"
      :event "UiEnter")
;     @end
; ** LSP
; *** [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
;     @code fennel
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
              (local servers [:bashls :clangd :clangd :cmake :jedi_language_server
                              :cssls :elmls :html :jsonls :rust_analyzer :clojure_lsp
                              :tsserver :tsserver :yamlls :hls :rnix])
              (each [_ server (pairs servers)]
                ((. (. lspconfig server) :setup) { :capabilities capabilities }))
              (set-keymap "Normal: Format buffer"
                "<leader>ll" vim.lsp.buf.format))
    )
;     @end
; *** [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls)
;     @code fennel
    (paq "nvim-jdtls" "More support for java lsp"
      "mfussenegger/nvim-jdtls"
      :branch "master"
      :commit "f39efa0e823bcc876d18a7b44d3b61191c42e61c"
    )
;     @end
; *** [lspsaga.nvim](https://github.com/glepnir/lspsaga.nvim)
;     @code fennel
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
                  "<leader>ld" "<cmd>Lspsaga peek_definition<CR>"))
    )
;     @end
; *** [trouble.nvim](https://github.com/folke/trouble.nvim)
;     @code fennel
    (paq "trouble" "Better diagnostics ui"
      "folke/trouble.nvim"
      :commit "ed65f84abc4a1e5d8f368d7e02601fc0357ea15e"
      :event "BufEnter"
      :config (do
        ((. (require :trouble) :setup) {})
        (set-keymap "Normal: Open Trouble window"
          "<leader>xx" "<cmd>Trouble<cr>"))
    )
;     @end
; ** Completion
; *** [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
;     @code fennel
    (paq "nvim-cmp" "Completion plugin"
      "hrsh7th/nvim-cmp"
      :commit "9bb8ee6e2d6ab3c8cc53323b79f05886bc722faa"
      :config (do
        (local cmp (require :cmp))
        (cmp.setup {
          :snippet {
            :expand (fn [args]
              ((. (require :luasnip) :lsp_expand) args.body))}
          :window {:completion {:winhighlight "Normal:Pmenu,FloatBorder:Pmenu,Search:None"
            :col_offset (- 3)
            :side_padding 0}}
          :formatting {:fields [:kind :abbr :menu]
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
    )
;     @end
; *** [lspkind.nvim](https://github.com/onsails/lspkind.nvim)
;     @code fennel
    (paq "lspkind" "vscode-like pictograms for neovim lsp completion items "
      "onsails/lspkind.nvim"
      :branch "master"
      :commit "c68b3a003483cf382428a43035079f78474cd11e")
;     @end
; *** [nvim-cmp-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
;     @code fennel
    (paq "cmp-lsp" "Cmp provider for lsp"
      "hrsh7th/cmp-nvim-lsp"
      :commit "3cf38d9c957e95c397b66f91967758b31be4abe6")
;     @end
; *** [nvim-cmp-lsp-signature-help](https://github.com/hrsh7th/cmp-nvim-lsp-signature-help)
;     @code fennel
    (paq "cmp-lsp-signature" "Cmp provider for lsp signatures"
      "hrsh7th/cmp-nvim-lsp-signature-help"
      :commit "d2768cb1b83de649d57d967085fe73c5e01f8fd7")
;     @end
; *** [nvim-cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
;     @code fennel
    (paq "cmp-buffer" "Cmp provider for buffer words"
      "hrsh7th/cmp-buffer"
      :commit "3022dbc9166796b644a841a02de8dd1cc1d311fa")
;     @end
; *** [nvim-cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline)
;     @code fennel
    (paq "cmp-cmdline" "Cmp provider for commandline"
      "hrsh7th/cmp-cmdline"
      :commit "c66c379915d68fb52ad5ad1195cdd4265a95ef1e")
;     @end
; *** [nvim-cmp-path](https://github.com/hrsh7th/cmp-path)
;     @code fennel
    (paq "cmp-path" "Cmp provider for filepaths"
      "hrsh7th/cmp-path"
      :commit "91ff86cd9c29299a64f968ebb45846c485725f23")
;     @end
; *** [nvim-cmp-luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
;     @code fennel
    (paq "cmp-luasnip" "Cmp provider for luasnip"
      "saadparwaiz1/cmp_luasnip"
      :branch "master"
      :commit "a9de941bcbda508d0a45d28ae366bb3f08db2e36")
;     @end
; ** Snippets
; *** [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
;     @code fennel
    (paq "luasnip" "Snippet engine"
      "L3MON4D3/LuaSnip"
      :branch "master"
      :commit "663d54482b11bca1ce94f56993b9f6ab485a13dc"
      :config (do
        (local luasnip (require :luasnip))
        ((. (require :luasnip.loaders.from_vscode) :lazy_load))
        (luasnip.config.setup {
          :history true
          :enable_autosnippets false
        })))
;     @end
; *** [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
;     @code fennel
    (paq "friendly-snippets" "Snippet collection"
      "rafamadriz/friendly-snippets"
      :commit "bb318c455e4e8946d64c79753f5bb07f7c27d711")
;     @end
; ** Git Integration
; *** [neogit](https://github.com/TimUntersberger/neogit)
;     @code fennel
    (paq "neogit" "Magit for neovim"
      "TimUntersberger/neogit"
      :branch "master"
      :commit "1acb13c07b34622fe1054695afcecff537d9a00a"
      :requires "nvim-lua/plenary.nvim"
      :after "plenary.nvim"
      :config ((. (require :neogit) :setup) {})
    )
;     @end
; *** [vim-fugitive](https://github.com/tpope/vim-fugitive)
;     @code fennel
    (paq "fugitive" "Basic git integration"
      "tpope/vim-fugitive"
      :branch "master"
      :commit "4b0f2b604562e9681ae3b80c2665f168ac637cea"
      :event "BufEnter")
;     @end
; *** [gitsigns](https://github.com/lewis6991/gitsigns.nvim)
;     @code fennel
    (paq "gitsigns" "Show added/removed/changed lines"
      "lewis6991/gitsigns.nvim"
      :commit "851cd32caaea84f303c4fdf51d72dfa5fcd795bb"
      :requires "nvim-lua/plenary.nvim"
      :event "BufEnter"
      :config ((. (require :gitsigns) :setup) {
        :signs {
          :add {
            :hl :GitSignsAdd
            :text "▌"
            :numhl :GitSignsAddNr
            :linehl :GitSignsAddLn}
          :change {
            :hl :GitSignsChange
            :text "▌"
            :numhl :GitSignsChangeNr
            :linehl :GitSignsChangeLn}}
        :current_line_blame true
        :current_line_blame_opts {
          :virt_text true
          :virt_text_pos :eol
          :delay 5000
          :ignore_whitespace false}
        :on_attach (fn _G.config.plugin-configs.gitsigns-on-attach [bufnr]
          (vim.api.nvim_exec "highlight GitSignsCurrentLineBlame guifg=#5a5e7a"
            false))})
    )
    (init-packer)
;     @end

; * Highlight Groups
; ** Completion menu
;    @code fennel
   (local groups {
     :PmenuSel {:bg "#282C34" :fg :NONE}
     :Pmenu {:fg "#C5CDD9" :bg "#22252A"}
     :CmpItemAbbrDeprecated {:fg "#7E8294" :bg :NONE :strikethrough true}
     :CmpItemAbbrMatch {:fg "#82AAFF" :bg :NONE :bold true}
     :CmpItemAbbrMatchFuzzy {:fg "#82AAFF" :bg :NONE :bold true}
     :CmpItemMenu {:fg "#C792EA" :bg :NONE :italic true}
     :CmpItemKindField {:fg "#EED8DA" :bg "#B5585F"}
     :CmpItemKindProperty {:fg "#EED8DA" :bg "#B5585F"}
     :CmpItemKindEvent {:fg "#EED8DA" :bg "#B5585F"}
     :CmpItemKindText {:fg "#C3E88D" :bg "#9FBD73"}
     :CmpItemKindEnum {:fg "#C3E88D" :bg "#9FBD73"}
     :CmpItemKindKeyword {:fg "#C3E88D" :bg "#9FBD73"}
     :CmpItemKindConstant {:fg "#FFE082" :bg "#D4BB6C"}
     :CmpItemKindConstructor {:fg "#FFE082" :bg "#D4BB6C"}
     :CmpItemKindReference {:fg "#FFE082" :bg "#D4BB6C"}
     :CmpItemKindFunction {:fg "#EADFF0" :bg "#A377BF"}
     :CmpItemKindStruct {:fg "#EADFF0" :bg "#A377BF"}
     :CmpItemKindClass {:fg "#EADFF0" :bg "#A377BF"}
     :CmpItemKindModule {:fg "#EADFF0" :bg "#A377BF"}
     :CmpItemKindOperator {:fg "#EADFF0" :bg "#A377BF"}
     :CmpItemKindVariable {:fg "#C5CDD9" :bg "#7E8294"}
     :CmpItemKindFile {:fg "#C5CDD9" :bg "#7E8294"}
     :CmpItemKindUnit {:fg "#F5EBD9" :bg "#D4A959"}
     :CmpItemKindSnippet {:fg "#F5EBD9" :bg "#D4A959"}
     :CmpItemKindFolder {:fg "#F5EBD9" :bg "#D4A959"}
     :CmpItemKindMethod {:fg "#DDE5F5" :bg "#6C8ED4"}
     :CmpItemKindValue {:fg "#DDE5F5" :bg "#6C8ED4"}
     :CmpItemKindEnumMember {:fg "#DDE5F5" :bg "#6C8ED4"}
     :CmpItemKindInterface {:fg "#D8EEEB" :bg "#58B5A8"}
     :CmpItemKindColor {:fg "#D8EEEB" :bg "#58B5A8"}
     :CmpItemKindTypeParameter {:fg "#D8EEEB" :bg "#58B5A8"}})
   (each [group config (pairs groups)]
     (vim.api.nvim_set_hl 0 group config))
;    @end


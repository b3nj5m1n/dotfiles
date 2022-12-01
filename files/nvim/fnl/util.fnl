(module util)
; --- Introduction ---

; Any functions or variables we define in here won't be accesible by neovim, but in certain instances we need to have access to these functions. For example, we use packer to manage plugins, and packer accepts a `config` field for any plugin with a function to run as configuration for the given plugin. If we want to set a keymap as part of a plugins configuration, we need to expose the function we create to handle keymaps to neovim.

; We achieve this by creating any definitions and variables und a global `config` table. It will hold serveral sub-tables, such as `plugin-configs` for the plugin configuration function, `fn` for all general-purpose function we define (such as those for settings keymaps), etc.
(tset _G :config { :plugins {} :plugin-configs {} :plugin-setups {} :fn {} :var {}})

; ; Since we don't want to have to prefix every function call in this document with `_G.config.fn.`, we also want to create a local variable pointing to the global function. Let's create a macro for automating this process:)
; (macro def-fn [fn-name fn-args ...]
;   '(local ,fn-name (let [f# (fn ,(sym (.. "_G.config.fn." (. fn-name 1))) ,fn-args ,[...])]
;                      (set ,(sym (.. "_G.config.fn." (. fn-name 1))) f#)
;                      f#)))
; (macro def-var [var-name var-value]
;   '(local ,var-name (do
;                       (set ,(sym (.. "_G.config.var." (. var-name 1))) ,var-value)
;                       ,var-value)))
; ; We can now use `def-fn` in place of `fn` to create a function under `_G.config.fn` and add a local variable pointing to that global function. The same goes for variables using the `def-var` macro in place of `local`.)

; --- Common functions from the neovim API ---

; When calling functions from the internal neovim lua api, I don't want to have to prefix everything with `vim.api.`, so we'll create some "aliases" to these functions.)
(def set-var vim.api.nvim_set_var)
(def get-opt vim.api.nvim_get_option)
(def expand vim.fn.expand) ; Expand enviornment variables in string

; We won't be calling some functions directly, for example, we'll define a macro for handling keymaps, I'll prefix these functions with `nvim` to indicate this.)
(def nvim-set-keymap vim.api.nvim_set_keymap)
(def nvim-set-opt vim.api.nvim_set_option_value)

; --- Custom Functions & Macros ---

; ** Option management **

; `nvim-set-option` requires an option table, however, I don't need to set any of these options, so I'll create a wrapper function that will automatcially pass an empty option table.)
(defn set-opt [option-name option-value]
  "Set nvim option with an empty options table. Wrapper around nvim-set-opt."
  (nvim-set-opt option-name option-value {}))

; This is a convenience function to allow me to set multiple options with one function call.
(defn set-opts [...]
  "Set multiple options."
  (for [i 1 (length [...]) 2]
    (set-opt (. [...] i) (. [...] (+ 1 i)))))

; ** Keymap management **


; Keymaps can take two forms, they either map some left-side to a right-side, for example, the key `t` to the keys `itest` (which will insert the text test when you press t), or they map some left-side to a lua callback, for example the key `t` to the function `print("test")`, which will print "test" when you press t.

; When you use the lua api to create the keymaps, though, you always have to specify a right-side, it's just ignored when you pass a callback in the options table. Let's define some functions to make this a little easier for ourselves.
(defn set-keymap-pure [description mode left-side right-side]
  "Set a 'pure' keymap, i.e. no callback"
  (let [opts { :noremap true :silent true :desc description}]
    (nvim-set-keymap mode left-side right-side opts)))
(defn set-keymap-callback [description mode left-side callback]
  "Set a keymap with a callback."
  (let [opts { :noremap true :silent true :desc description :callback callback}]
    (nvim-set-keymap mode left-side "" opts)))

; When you specify a keymap, you have to tell neovim for what mode it is, for example normal mode or insert mode. You can also specify an optional description for what the mapping does. I want to combine this, so I can just specify mode and description in one string, something like this: /Normal: Execute that one command/. Let's write a macro to do just that, and while we're at it, let's make it figure out whether the third argument is a string or a function, and based on that decide whether to call `set-keymap-pure` or `set-keymap-callback`.
(defn get-description-prefix [s]
  "If description is 'Normal: text text', this function will return 'normal'"
  (string.lower (string.sub s 1 (- (string.find s ":" 1 true) 1))))
(defn get-description [s]
  "If description is 'Normal: text text', this function will return 'text text'"
  (string.sub s (+ (string.find s ":" 1 true) 2)))
(defn set-keymap [description left-side right-side-or-callback]
  "Set keymap with description, default options and either left-side or callback."
  (local mode (match (get-description-prefix description)
               "normal" "n"
               "visual" "v"
               "insert" "i"
               "terminal" "t"))
  (local description (get-description description))
  (match (type right-side-or-callback)
      "string" (set-keymap-pure description mode left-side right-side-or-callback)
      "table" (set-keymap-callback description mode left-side right-side-or-callback)))

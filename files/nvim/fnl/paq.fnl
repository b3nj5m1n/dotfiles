(module paq
  {require {util util}})
; --- Plugin Management ---

; Neovim doesn't /really/ have a built-in plugin manager, and there are tons of available options. I'm currently using [packer](https://github.com/wbthomason/packer.nvim), but I don't want to be dependendent on that, so my approach to plugin management is built to allow for easily switching out the plugin manager without having to make changes to my plugin declarations.

; There's a `plugins` table in our global `config` table, this will store a list of plugins containing all the information we need, such as the github url, configuration, etc. Then, there's a separate function which will build a packer configuration from that global table. In theory, I could also write a function to build a vim-plug configuration. (a package manager I've used in the past)

; You'll definitely see packer's influence on the available values, though. Here's a function which will insert a new plugin into this table with all possible parameters:
(defn add-plugin [name path config setup branch commit optional command requires filetype event after disable description as]
  "Add plugin to config-local plugin-store."
  (table.insert _G.config.plugins {
                                   :name name :path path :config config :setup setup
                                   :branch branch :commit commit :optional optional
                                   :command command :requires requires :filetype filetype
                                   :event event :after after :disable disable
                                   :description description :as as}))
      
; I don't want to have to set all possible parameters, though. And there's some other things I'd like automated.

; - I like my plugins pinned to a specific version. In practice, I always specify the hash of the commit I want to use. This doesn't give me automatic updates, but it also guarantees (more or less) that my plugins will never break. When I want to update a plugin, I manually replace the commit hash with a newer one. I also always specify the branch name to use. Since I always want to do this, we can assume that when I don't explicitly specify the branch name, it's the default of "main".
; - We can also assume that when we don't explicitly set the optional or disable parameters, the plugin is neither optional, nor disabled.
;    - `config` and `setup` are both functions, and I want them to be in the `_G.config.plugin-configs` and `_G.config.plugin-setups` table, respectively.
; -- I don't want to type out the whole `(fn _G.config.plugin-x.y)
; -- When I don't pass a function explicity, I want to set it to a function returning `nil`, since packer will always call the function and I don't want it to error when I don't specify a function.))

; Again, let's define a macro to take care of all this:))
(defn paq-add [name description path ...]
  (local plugin-config {
                        :name name :path path :config nil :setup nil :branch nil :commit nil :optional nil
                        :command nil :requires nil :filetype nil :event nil :after nil :disable nil :description description :as nil})
  (for [i 1 (length [...]) 2]
    (let [key (. [...] i) value (. [...] (+ 1 i))]
      (tset plugin-config key value)))
  (if (= (. plugin-config :branch) nil) (tset plugin-config :branch "main"))
  (if (= (. plugin-config :optional) nil) (tset plugin-config :optional false))
  (if (= (. plugin-config :disable) nil) (tset plugin-config :disable false))
  (if (not (= (. plugin-config :config) nil))
    (tset plugin-config :config (fn [] (. plugin-config :config))))
    ; (tset plugin-config :config (fn [] nil)))
  (if (not (= (. plugin-config :setup) nil))
    (tset plugin-config :setup (fn [] (. plugin-config :setup))))
    ; (tset plugin-config :setup (fn [] nil)))
  (table.insert (. config :plugins) plugin-config))

; Finally, let's define the function I've been talking about that will build a packer config from our global plugin table:
(defn init-packer []
  (paq-add "packer" "Plugin manager"
    "wbthomason/packer.nvim"
    :branch "master"
    :commit "dcd2f380bb49ec2dfe208f186236dd366434a4d5"
    :optional false
    :command ["PackerSync"])
  ; (vim.cmd "packadd packer.nvim")
  (local packer (require :packer))
  (packer.init {:config {:compile_path (.. (vim.fn.stdpath :config) :/lua/packer_compiled.lua)}})
  (each [_ plugin (ipairs (. config :plugins))]
    (packer.use {
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
  ; ((. (require :packer) :startup) {1 (fn []
  ;                                       (each [_ plugin (ipairs (. config :plugins))]
  ;                                         {
  ;                                          1 (. plugin :path)
  ;                                          :config (. plugin :config)
  ;                                          :setup (. plugin :setup)
  ;                                          :branch (. plugin :branch)
  ;                                          :commit (. plugin :commit)
  ;                                          :opt (. plugin :optional)
  ;                                          :cmd (. plugin :command)
  ;                                          :requires (. plugin :requires)
  ;                                          :ft (. plugin :filetype)
  ;                                          :event (. plugin :event)
  ;                                          :after (. plugin :after)
  ;                                          :disable (. plugin :disable)
  ;                                          :as (. plugin :as)}))
  ;                                  :config {:compile_path (.. (vim.fn.stdpath :config) :/lua/packer_compiled.lua)}}))
  ; (require :packer_compiled))


(module fennel-config
  {
   require
   {
    util util
    paq paq}})

(def options (require "options"))
(def plugins (require "plugins"))

(paq.init-packer)

(def keymaps (require "keymaps"))

(def feline-config (require "feline-config"))

(def plugin-config (require "plugin-config"))

(def lsp-util (require "lsp-util"))

(plugin-config.colorscheme)
(plugin-config.watch-mode-changes)
(plugin-config.kommentary)
(plugin-config.dressing)
; (plugin-config.neorg)
(plugin-config.indent-blankline)
(plugin-config.leap)
(plugin-config.autopairs)
(plugin-config.nvim-surround)
(plugin-config.nvim-colorizer)
(plugin-config.nvim-treesitter)
(plugin-config.lspconfig)
; (plugin-config.lspsaga)
(plugin-config.lsp-lines)
(plugin-config.trouble)
(plugin-config.nvim-cmp)
(plugin-config.luasnip)
; (plugin-config.neogit)
(plugin-config.gitsigns)
(plugin-config.conjure)
(plugin-config.netrw)
(plugin-config.murmur)
(plugin-config.ufo)
(plugin-config.dap)

(def highlight (require "highlight"))

(highlight.create-groups-telescope "normal")
(highlight.create-groups-ufo "normal")
(highlight.create-groups-cmp)


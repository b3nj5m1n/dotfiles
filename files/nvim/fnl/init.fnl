
(module fennel-config
  {
   require
   {
    util util
    paq paq}})

(def options (require "options"))
(def keymaps (require "keymaps"))
(def plugins (require "plugins"))

(paq.init-packer)

(def feline-config (require "feline-config"))

(def plugin-config (require "plugin-config"))

(plugin-config.colorscheme)
(plugin-config.kommentary)
; (plugin-config.neorg)
(plugin-config.indent-blankline)
(plugin-config.leap)
(plugin-config.telescope)
(plugin-config.autopairs)
(plugin-config.nvim-surround)
(plugin-config.nvim-colorizer)
(plugin-config.nvim-treesitter)
(plugin-config.lspconfig)
(plugin-config.lspsaga)
(plugin-config.trouble)
(plugin-config.nvim-cmp)
(plugin-config.luasnip)
; (plugin-config.neogit)
(plugin-config.gitsigns)

(def highlight (require "highlight"))


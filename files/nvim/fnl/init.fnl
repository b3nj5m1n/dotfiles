
(module fennel-config
  {
   require
   {
    ; feline-config feline-config
    util util
    ; options options
    ; keymaps keymaps}})
    paq paq}})

(def options (require "options"))
(def keymaps (require "keymaps"))
(def plugins (require "plugins"))

(paq.init-packer)

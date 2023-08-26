(local lazypath (.. (vim.fn.stdpath :data) :/lazy/lazy.nvim))
(when (not (vim.loop.fs_stat lazypath))
  (vim.fn.system [:git
                  :clone
                  "--filter=blob:none"
                  "https://github.com/folke/lazy.nvim.git"
                  :--branch=stable
                  lazypath]))
(vim.opt.rtp:prepend lazypath)

(require :init)

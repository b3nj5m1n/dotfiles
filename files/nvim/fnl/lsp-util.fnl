(module lsp-util
  {require
   {util util}})

(defn get-capabilities []
  ((. (require :cmp_nvim_lsp) :default_capabilities)))

(defn get-handlers []
  {
   "textDocument/hover" (vim.lsp.with vim.lsp.handlers.hover {:border "single"})
   "textDocument/signatureHelp" (vim.lsp.with vim.lsp.handlers.signature_help {:border "single"})})
   

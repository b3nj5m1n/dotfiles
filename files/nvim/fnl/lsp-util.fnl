(module lsp-util
  {require
   {util util}})

(defn get-capabilities []
  (var capabilities {})
  (set capabilities ((. (require :cmp_nvim_lsp) :default_capabilities)))
  (tset (. capabilities :textDocument) :foldingRange
        {:dynamicRegistration false
         :lineFoldingOnly true}))

(defn get-handlers []
  {
   "textDocument/hover" (vim.lsp.with vim.lsp.handlers.hover {:border "single"})
   "textDocument/signatureHelp" (vim.lsp.with vim.lsp.handlers.signature_help {:border "single"})})
   

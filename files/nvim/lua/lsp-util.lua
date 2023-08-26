-- [nfnl] Compiled from fnl/lsp-util.fnl by https://github.com/Olical/nfnl, do not edit.
local capabilities = {}
capabilities = (require("cmp_nvim_lsp")).default_capabilities()
do end (capabilities.textDocument)["foldingRange"] = {lineFoldingOnly = true, dynamicRegistration = false}
defn(__fnl_global__get_2dcapabilities, {}, nil, nil, nil)
return defn(__fnl_global__get_2dhandlers, {}, {["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "single"}), ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "single"})})

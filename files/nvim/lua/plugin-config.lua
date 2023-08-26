-- [nfnl] Compiled from fnl/plugin-config.fnl by https://github.com/Olical/nfnl, do not edit.
local catppuccin = require("catppuccin")
defn(colorscheme, {}, nil, catppuccin.setup({flavour = "macchiato"}), vim.cmd("colorscheme catppuccin"))
local function _3_(...)
  local mode
  do
    local _1_ = vim.api.nvim_get_mode().mode
    if (_1_ == "n") then
      mode = "normal"
    elseif (_1_ == "i") then
      mode = "insert"
    else
      mode = nil
    end
  end
  local hl = (require("fennel-config")).highlight
  hl["create-groups-telescope"](mode)
  return hl["create-groups-cursor-line"](mode)
end
defn(__fnl_global__mode_2dchanged, {}, _3_(...))
defn(__fnl_global__watch_2dmode_2dchanges, {}, vim.api.nvim_create_augroup("ModeChanges", {clear = true}), vim.api.nvim_create_autocmd("ModeChanged", {group = "ModeChanges", pattern = {}, callback = __fnl_global__mode_2dchanged}))
local kommentary = require("kommentary.config")
defn(kommentary, {}, util["set-keymap"]("Normal: Toggle comment on current line", "gcc", "<Plug>kommentary_line_default"), util["set-keymap"]("Normal: Toggle comment on motion", "gc", "<Plug>kommentary_motion_default"), util["set-keymap"]("Visual: Toggle comment on visual selection", "gc", "<Plug>kommentary_visual_default"), nil, kommentary.configure_language(), {"norg"}, {single_line_comment_string = "auto", multi_line_comment_strings = "auto"})
defn(dressing, {}, (require("dressing")).setup({input = {enabled = true, default_prompt = "Input:", prompt_align = "left", insert_only = true, start_in_insert = true, border = "rounded", relative = "cursor", win_options = {winblend = 10, wrap = false}}, select = {enabled = true, backend = {"telescope", "builtin"}, trim_prompt = true}}))
defn(neorg, {}, (require("neorg")).setup, {load = {["core.defaults"] = {}, ["core.norg.concealer"] = {config = {preset = "icons"}}, ["core.norg.completion"] = {config = {engine = "nvim-cmp"}}, ["core.norg.esupports.metagen"] = {config = {type = "auto"}}}})
defn(__fnl_global__indent_2dblankline, {}, (require("indent_blankline")).setup, {char = "|", space_char_blankline = " ", show_current_context = true, buftype_exclude = {"terminal"}})
defn(leap, {}, (require("leap")).add_default_mappings())
defn(autopairs, {}, (require("nvim-autopairs")).setup())
defn(__fnl_global__nvim_2dsurround, {}, (require("nvim-surround")).setup())
defn(__fnl_global__nvim_2dcolorizer, {}, (require("colorizer")).setup())
local parser_configs = (require("nvim-treesitter.parsers")).get_parser_configs()
parser_configs.norg = {install_info = {url = "https://github.com/nvim-neorg/tree-sitter-norg", files = {"src/parser.c", "src/scanner.cc"}, branch = "main"}}
defn(__fnl_global__nvim_2dtreesitter, {}, nil, nil, (require("nvim-treesitter.configs")).setup({ensure_installed = {"markdown", "rust", "lua", "fennel", "python"}, highlight = {enable = true}, indent = {enable = true}, rainbow = {enable = true, colors = {"#bd93f9", "#50fa7b", "#ffb86c", "#ff79c6", "#8be9fd", "#f1fa8c"}}, textobjects = {select = {enable = true, keymaps = {af = "@function.outer", ["if"] = "@function.inner", ac = "@class.outer", ic = "@class.inner"}}, move = {enable = true, goto_next_start = {["]m"] = "@function.outer", ["]]"] = "@class.outer"}, goto_next_end = {["]M"] = "@function.outer", ["]["] = "@class.outer"}, goto_previous_start = {["[m"] = "@function.outer", ["[["] = "@class.outer"}, goto_previous_end = {["[M"] = "@function.outer", ["[]"] = "@class.outer"}}}}))
local lspconfig = require("lspconfig")
local capabilities = __fnl_global__lsp_2dutil["get-capabilities"]()
local servers = {"bashls", "cmake", "jedi_language_server", "cssls", "elmls", "html", "jsonls", "clojure_lsp", "tsserver", "tsserver", "yamlls", "hls", "rnix", "fennel_language_server"}
for _, server in pairs(servers) do
  lspconfig[server].setup({capabilities = capabilities, handlers = __fnl_global__lsp_2dutil["get-handlers"]()})
end
defn(lspconfig, {}, nil, nil, nil, nil, lspconfig.clangd.setup({capabilities = capabilities, single_file_support = true, cmd = {"clangd", "--completion-style=detailed", "-fallback-style=LLVM"}}), vim.api.nvim_create_augroup("hover", {clear = true}), vim.api.nvim_create_autocmd("CursorHold", {group = "hover", command = "lua vim.diagnostic.open_float({ scope = \"cursor\" })"}))
defn(__fnl_global__lsp_2dlines, {}, (require("lsp_lines")).setup(), vim.diagnostic.config({virtual_text = false}))
defn(trouble, {}, (require("trouble")).setup({}), util["set-keymap"]("Normal: Open Trouble window", "<leader>xx", "<cmd>Trouble<cr>"))
local cmp = require("cmp")
local function _4_(args)
  return (require("luasnip")).lsp_expand(args.body)
end
local function _5_(entry, vim_item)
  local kind = (require("lspkind")).cmp_format({mode = "symbol_text", maxwidth = 50})(entry, vim_item)
  local strings = vim.split(kind.kind, "%s", {trimempty = true})
  kind.kind = (" " .. strings[1] .. " ")
  kind.menu = ("    (" .. strings[2] .. ")")
  return kind
end
defn(__fnl_global__nvim_2dcmp, {}, nil, cmp.setup({snippet = {expand = _4_}, window = {completion = {winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None", col_offset = ( - 3), side_padding = 0}}, formatting = {fields = {"kind", "abbr", "menu"}, format = _5_}, mapping = cmp.mapping.preset.insert({["<C-n>"] = cmp.mapping.select_next_item({"i", "c"}), ["<C-p>"] = cmp.mapping.select_prev_item({"i", "c"}), ["<C-b>"] = cmp.mapping.scroll_docs(( - 4), {"i", "c"}), ["<C-d>"] = cmp.mapping.scroll_docs(4, {"i", "c"}), ["<C-f>"] = cmp.mapping.complete({"i", "c"}), ["<C-e>"] = cmp.mapping.abort({"i", "c"}), ["<CR>"] = cmp.mapping.confirm({select = true}, {"i", "c"})}), sources = cmp.config.sources({{name = "nvim_lsp"}, {name = "nvim_lsp_signature_help"}, {name = "neorg"}, {name = "luasnip"}, {name = "path"}, {name = "omni"}, {name = "buffer"}}), sorting = {comparators = {cmp.config.compare.score}}}), cmp.setup.cmdline({"/", "?"}, {mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({{name = "buffer"}})}), cmp.setup.cmdline(":", {mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({{name = "path"}}, {{name = "cmdline"}})}))
local luasnip = require("luasnip")
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = (require("luasnip.extras.fmt")).fmt
local fmta = (require("luasnip.extras.fmt")).fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = (require("luasnip.extras.postfix")).postfix
local types = require("luasnip.util.types")
local parse = (require("luasnip.util.parser")).parse_snippet
local ms = ls.multi_snippet
local k = (require("luasnip.nodes.key_indexer")).new_key
local function _6_()
  return os.date("%Y/%m/%d")
end
local function _7_()
  return os.date("%H:%M")
end
defn(luasnip, {}, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, ls.add_snippets("all", {s("TODAY", f(_6_)), s("NOW", f(_7_))}), ls.add_snippets("tex", {s("frac", fmt("\\frac{{{}}}{{{}}}", {i(1), i(2)}))}), ls.add_snippets("lua", {s("req", fmt("local {} = require('{}')", {i(1, "default"), rep(1)}))}), luasnip.config.setup({history = true, enable_autosnippets = false}))
local ng = require("neogit")
defn(neogit, {}, nil, ng.setup({}))
local gs = require("gitsigns")
_G.config["plugin-configs"]["gitsigns-on-attach"] = function(bufnr)
  return vim.api.nvim_exec("highlight GitSignsCurrentLineBlame guifg=#5a5e7a", false)
end
defn(gitsigns, {}, nil, gs.setup({signs = {add = {hl = "GitSignsAdd", text = "\226\150\140", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn"}, change = {hl = "GitSignsChange", text = "\226\150\140", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn"}}, current_line_blame = true, current_line_blame_opts = {virt_text = true, virt_text_pos = "eol", delay = 5000, ignore_whitespace = false}, on_attach = _G.config["plugin-configs"]["gitsigns-on-attach"]}))
defn(conjure, {}, util["set-var"]("conjure#highlight#enabled", true), util["set-var"]("conjure#highlight#group", "IncSearch"), util["set-var"]("conjure#highlight#timeout", "200"))
local nrw = require("netrw")
defn(netrw, {}, nil, nrw.setup({}))
local mm = require("murmur")
defn(murmur, {}, nil, mm.setup({cursor_rgb = "#494d64"}))
local ufo = require("ufo")
defn(ufo, {}, nil, ufo.setup({}))
local function _8_(dap_run_co)
  local scan = require("plenary.scandir")
  local files = scan.scan_dir(".", {})
  local function _9_(choice)
    return coroutine.resume(dap_run_co, choice)
  end
  return vim.ui.select(files, {prompt = "Select executable:"}, _9_)
end
defn(__fnl_global__get_2dexecutable, {}, coroutine.create(_8_))
local dap = require("dap")
dap.adapters.codelldb = {type = "server", port = "${port}", executable = {command = "/usr/bin/codelldb", args = {"--port", "${port}"}}}
local codelldb = {name = "Launch file", type = "codelldb", request = "launch", program = __fnl_global__get_2dexecutable, cwd = "${workspaceFolder}", args = {}, runInTerminal = true, console = "integratedTerminal", stopOnEntry = false}
local configurations = {c = {codelldb}}
dap.configurations = configurations
local dap_ui = require("dapui")
return defn(dap, {}, nil, nil, nil, nil, nil, nil, dap_ui.setup())

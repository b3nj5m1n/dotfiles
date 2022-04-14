local M = {}

--- kommentary ---
function M.kommentary()
    vim.api.nvim_set_keymap("n", "gcc", "<Plug>kommentary_line_default", {})
    vim.api.nvim_set_keymap("v", "gc", "<Plug>kommentary_visual_default", {})
    vim.api.nvim_set_keymap("n", "gc", "<Plug>kommentary_motion_default", {})
end

--- neorg ---
function M.neorg()
    require('neorg').setup {
        load = {
            ["core.defaults"] = {}, -- Load all the default modules
            ["core.norg.concealer"] = {
                config = {
                    preset = "icons",
                }
            }, -- Allows for use of icons
            ["core.norg.esupports.metagen"] = {
                config = {
                    type = "auto",
                }
            },
        },
    }
end

--- neogit ---
function M.neogit()
    local neogit = require('neogit')
    neogit.setup {}
end

--- lsp ---
function M.lsp()
    local lspconfig = require('lspconfig')
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    local servers = { "bashls", "clangd", "clangd", "cmake", "cssls", "elmls", "html", "jsonls", "rust_analyzer", "tsserver", "tsserver", "yamlls" }
    for _, server in pairs(servers) do
        lspconfig[server].setup{
            capabilities = capabilities,
        }
    end
end
function M.lsp_saga()
    local saga = require 'lspsaga'
    saga.init_lsp_saga()
end

function M.lsp_lua()
    local sumneko_root_path = '/usr/share/lua-language-server'
    local sumneko_binary = "/usr/bin/lua-language-server"
    require'lspconfig'.sumneko_lua.setup {
        cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Setup your lua path
                    path = vim.split(package.path, ';'),
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'},
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = {
                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                    },
                },
            },
        },
    }
end
function M.lsp_tailwind()
    require'lspconfig'.tailwindcss.setup {
        filetypes = { "elm", "aspnetcorerazor", "astro", "astro-markdown", "blade", "django-html", "edge", "eelixir", "ejs", "erb", "eruby", "gohtml", "haml", "handlebars", "hbs", "html", "html-eex", "heex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte" },
    }
end

-- vim.api.nvim_exec('autocmd BufWritePre *.c lua vim.lsp.buf.formatting()', false) -- Auto-format on save

--[[ -- More LSP
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 2, prefix = "●" },
  severity_sort = true,
}) ]]

-- Treesitter

function M.treesitter()
    local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

    parser_configs.norg = {
        install_info = {
            url = "https://github.com/nvim-neorg/tree-sitter-norg",
            files = { "src/parser.c", "src/scanner.cc" },
            branch = "main"
        },
    }

    require'nvim-treesitter.configs'.setup {
        ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        highlight = {
            enable = true,              -- false will disable the whole extension
            custom_captures = {
                ["h1"] = "h1",
                ["_h1"] = "_h1",
                ["h2"] = "h2",
                ["_h2"] = "_h2",
                ["h3"] = "h3",
                ["_h3"] = "_h3",
                ["h4"] = "h4",
                ["_h4"] = "_h4",
                ["h5"] = "h5",
                ["_h5"] = "_h5",
                ["emphasis"] = "emphasis",
                ["strong_emphasis"] = "strong_emphasis",
                ["strikethrough"] = "strikethrough",
                ["info_string"] = "info_string",
            },
        },
        indent = {
            enable = true
        }
    }
    -- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    -- parser_config.markdown = {
    --     install_info = {
    --         url = "https://github.com/ikatyang/tree-sitter-markdown", -- local path or git repo
    --         files = {"src/parser.c", "src/scanner.cc"}
    --     },
    --     filetype = "md", -- if filetype does not agrees with parser name
    -- }

    require'nvim-treesitter.configs'.setup {
        textobjects = {
            select = {
                enable = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                },
            },
            move = {
                enable = true,
                goto_next_start = {
                    ["]m"] = "@function.outer",
                    ["]]"] = "@class.outer",
                },
                goto_next_end = {
                    ["]M"] = "@function.outer",
                    ["]["] = "@class.outer",
                },
                goto_previous_start = {
                    ["[m"] = "@function.outer",
                    ["[["] = "@class.outer",
                },
                goto_previous_end = {
                    ["[M"] = "@function.outer",
                    ["[]"] = "@class.outer",
                },
            },
        },
    }
end


--- colorizer ---
function M.colorizer()
    require'colorizer'.setup()
end


--- status line ---
-- vim.api.nvim_set_var('airline_theme', 'dracula') -- Require a length of 2 for sources with priorities 1-6, 0 for the highest priority


--- sneak ---
-- highlight Sneak guifg=black guibg=#00C7DF ctermfg=black ctermbg=cyan
-- highlight SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow


--- fzf ---
-- " These are the default extra key bindings
-- vim.api.nvim_set_var('fzf_action', vim.api.nvim_eval('{ "ctrl-t": "tab split", "ctrl-x": "split", "ctrl-v": "vsplit" }')) -- Require a length of 2 for sources with priorities 1-6, 0 for the highest priority


--- auto pairs ---
function M.autopairs()
    require('nvim-autopairs').setup()
end

--- nvim-cmp ---
function M.cmp()
    local cmp = require('cmp')
    cmp.setup({
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'path' },
            { name = 'luasnip' },
            { name = 'buffer' },
        })
    })
end

--- luasnip ---
function M.luasnip()
    require("luasnip.loaders.from_vscode").lazy_load()
end

return M

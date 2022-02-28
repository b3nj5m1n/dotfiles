--- kommentary ---
vim.api.nvim_set_keymap("n", "gcc", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("v", "gc", "<Plug>kommentary_visual_default", {})
vim.api.nvim_set_keymap("n", "gc", "<Plug>kommentary_motion_default", {})

--- neorg ---
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

--- neogit ---
-- local neogit = require('neogit')
-- neogit.setup {}


--- UltiSnips ---
vim.api.nvim_set_var("UltiSnipsExpandTrigger", "<c-j>")
vim.api.nvim_set_var("UltiSnipsJumpForwardTrigger", "<c-a>")
vim.api.nvim_set_var("UltiSnipsJumpBackwardTrigger", "<c-s>")


--- completion ---
-- vim.api.nvim_command("autocmd BufEnter * lua require'completion'.on_attach()")
-- vim.api.nvim_command("let g:completion_enable_snippet = 'UltiSnips'")
-- vim.cmd([[ let g:completion_chain_complete_list = [ {'complete_items': ['lsp', 'snippet', 'path']}, {'mode': '<c-p>'}, {'mode': '<c-n>'} ] ]])

--[[ local on_attach = function(client)
    require('vim.lsp.protocol').CompletionItemKind = {
        '';   -- Text          = 1;
        '';   -- Method        = 2;
        'ƒ';   -- Function      = 3;
        '';   -- Constructor   = 4;
        '識';  -- Field         = 5;
        '';   -- Variable      = 6;
        '';   -- Class         = 7;
        'ﰮ';   -- Interface     = 8;
        '';   -- Module        = 9;
        '';   -- Property      = 10;
        '';   -- Unit          = 11;
        '';   -- Value         = 12;
        '了';  -- Enum          = 13;
        '';   -- Keyword       = 14;
        '﬌';   -- Snippet       = 15;
        '';   -- Color         = 16;
        '';   -- File          = 17;
        '渚';  -- Reference     = 18;
        '';   -- Folder        = 19;
        '';   -- EnumMember    = 20;
        '';   -- Constant      = 21;
        '';   -- Struct        = 22;
        '鬒';  -- Event         = 23;
        'Ψ';   -- Operator      = 24;
        '';   -- TypeParameter = 25;
    }
end ]]

--[[ require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;

    source = {
        path = true;
        buffer = true;
        calc = true;
        vsnip = true;
        nvim_lsp = true;
        nvim_lua = true;
        spell = false;
        tags = true;
        snippets_nvim = true;
        treesitter = true;
    };
} ]]


--- lsp ---
local saga = require 'lspsaga'
saga.init_lsp_saga()
local lspconfig = require('lspconfig')
lspconfig.util.default_config = vim.tbl_extend( "force", lspconfig.util.default_config, { on_attach=on_attach })
-- lspconfig.pyls.setup{}
lspconfig.bashls.setup{}
lspconfig.clangd.setup{}
lspconfig.cmake.setup{}
lspconfig.cssls.setup{}
lspconfig.dockerls.setup{}
lspconfig.elmls.setup{}
lspconfig.gdscript.setup{}
lspconfig.gopls.setup{}
lspconfig.html.setup{}
lspconfig.jsonls.setup{}
lspconfig.omnisharp.setup{}
lspconfig.perlls.setup{}
lspconfig.rust_analyzer.setup{}
lspconfig.solargraph.setup{}
lspconfig.texlab.setup{}
lspconfig.tsserver.setup{}
lspconfig.vimls.setup{}
lspconfig.yamlls.setup{}

--[[ lspconfig.sqlls.setup{
    cmd = {"/usr/bin/sql-language-server", "up", "--method", "stdio"};
} ]]

local sumneko_root_path = '/usr/share/lua-language-server'
local sumneko_binary = "/usr/bin/lua-language-server"
require'lspconfig'.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    -- on_init = ncm2.register_lsp_source,
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
require'lspconfig'.tailwindcss.setup {
    filetypes = { "elm", "aspnetcorerazor", "astro", "astro-markdown", "blade", "django-html", "edge", "eelixir", "ejs", "erb", "eruby", "gohtml", "haml", "handlebars", "hbs", "html", "html-eex", "heex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte" },
}

vim.api.nvim_exec('autocmd BufWritePre *.c lua vim.lsp.buf.formatting()', false) -- Auto-format on save

-- More LSP
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 2, prefix = "●" },
  severity_sort = true,
})

-- Treesitter

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


--- colorizer ---
require'colorizer'.setup()


--- status line ---
-- vim.api.nvim_set_var('airline_theme', 'dracula') -- Require a length of 2 for sources with priorities 1-6, 0 for the highest priority


--- sneak ---
-- highlight Sneak guifg=black guibg=#00C7DF ctermfg=black ctermbg=cyan
-- highlight SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow


--- fzf ---
-- " These are the default extra key bindings
vim.api.nvim_set_var('fzf_action', vim.api.nvim_eval('{ "ctrl-t": "tab split", "ctrl-x": "split", "ctrl-v": "vsplit" }')) -- Require a length of 2 for sources with priorities 1-6, 0 for the highest priority


--- auto pairs ---
require('nvim-autopairs').setup()


--- UltiSnips ---
vim.api.nvim_set_var("UltiSnipsExpandTrigger", "<c-j>")
vim.api.nvim_set_var("UltiSnipsJumpForwardTrigger", "<c-a>")
vim.api.nvim_set_var("UltiSnipsJumpBackwardTrigger", "<c-s>")


--- completion ---
local on_attach = function(client)
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
end

require'compe'.setup {
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
}


--- lsp ---
local lspconfig = require('lspconfig')
lspconfig.util.default_config = vim.tbl_extend( "force", lspconfig.util.default_config, { on_attach=on_attach })
lspconfig.bashls.setup{}
lspconfig.clangd.setup{}
lspconfig.cmake.setup{}
lspconfig.cssls.setup{}
lspconfig.dockerls.setup{}
lspconfig.gdscript.setup{}
lspconfig.gopls.setup{}
lspconfig.html.setup{}
lspconfig.jsonls.setup{}
lspconfig.omnisharp.setup{}
lspconfig.perlls.setup{}
lspconfig.pyls.setup{}
lspconfig.rust_analyzer.setup{}
lspconfig.solargraph.setup{}
lspconfig.sqlls.setup{}
lspconfig.texlab.setup{}
lspconfig.tsserver.setup{}
lspconfig.vimls.setup{}
lspconfig.yamlls.setup{}

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

vim.api.nvim_exec('autocmd BufWritePre *.c lua vim.lsp.buf.formatting()', false) -- Auto-format on save


-- Treesitter
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
        disable = {},  -- list of language that will be disabled
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


--- airline ---
vim.api.nvim_set_var('airline_theme', 'dracula') -- Require a length of 2 for sources with priorities 1-6, 0 for the highest priority


--- sneak ---
-- highlight Sneak guifg=black guibg=#00C7DF ctermfg=black ctermbg=cyan
-- highlight SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow


--- fzf ---
-- " These are the default extra key bindings
vim.api.nvim_set_var('fzf_action', vim.api.nvim_eval('{ "ctrl-t": "tab split", "ctrl-x": "split", "ctrl-v": "vsplit" }')) -- Require a length of 2 for sources with priorities 1-6, 0 for the highest priority


--- auto pairs ---
require('nvim-autopairs').setup()


--- Nvim Tree Lua ---
--  let g:nvim_tree_side = 'left'
-- let g:nvim_tree_width = 30
-- let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
-- let g:nvim_tree_auto_open = 0
-- let g:nvim_tree_auto_close = 1
-- let g:nvim_tree_quit_on_open = 0
-- let g:nvim_tree_follow = 0
-- let g:nvim_tree_indent_markers = 0
-- let g:nvim_tree_hide_dotfiles = 0
-- let g:nvim_tree_git_hl = 0
-- let g:nvim_tree_root_folder_modifier = ':~'
-- let g:nvim_tree_tab_open = 0
-- let g:nvim_tree_width_allow_resize  = 1
-- let g:nvim_tree_show_icons = { }

-- " NOTE: the 'edit' key will wrap/unwrap a folder and open a file
-- let g:nvim_tree_bindings = {
--     \ 'refresh':         'r',
--     \ 'create':          'a',
--     \ 'remove':          'd',
--     \ 'rename':          'R',
--     \ 'cut':             'x',
--     \ 'copy':            'c',
--     \ 'paste':           'p',
--     \ }

-- let g:nvim_tree_icons = {
--     \ 'default': '',
--     \ 'symlink': '',
--     \ 'git': {
--     \   'unstaged': "✗",
--     \   'staged': "✓",
--     \   'unmerged': "",
--     \   'renamed': "➜",
--     \   'untracked': "★"
--     \   },
--     \ 'folder': {
--     \   'default': "",
--     \   'open': "",
--     \   'symlink': "",
--     \   }
--     \ }

-- nnoremap <C-n> :NvimTreeToggle<CR>
-- " NvimTreeOpen and NvimTreeClose are also available if you need them

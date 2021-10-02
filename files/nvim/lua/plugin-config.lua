--- kommentary ---
vim.api.nvim_set_keymap("n", "gcc", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("v", "gc", "<Plug>kommentary_visual_default", {})
vim.api.nvim_set_keymap("n", "gc", "<Plug>kommentary_motion_default", {})

--- neorg ---
require('neorg').setup {
    load = {
        ["core.defaults"] = {}, -- Load all the default modules
        ["core.norg.concealer"] = {}, -- Allows for use of icons
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
vim.api.nvim_command("autocmd BufEnter * lua require'completion'.on_attach()")
vim.api.nvim_command("let g:completion_enable_snippet = 'UltiSnips'")
vim.cmd([[ let g:completion_chain_complete_list = [ {'complete_items': ['lsp', 'snippet', 'path']}, {'mode': '<c-p>'}, {'mode': '<c-n>'} ] ]])

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
-- lspconfig.pyls.setup{}
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


require'nvim-tree'.setup {
  -- disables netrw completely
  disable_netrw       = true,
  -- hijack netrw window on startup
  hijack_netrw        = true,
  -- open the tree when running this setup function
  open_on_setup       = false,
  -- will not open on setup if the filetype is in this list
  ignore_ft_on_setup  = {},
  -- closes neovim automatically when the tree is the last **WINDOW** in the view
  auto_close          = true,
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab         = false,
  -- hijacks new directory buffers when they are opened.
  update_to_buf_dir   = {
    -- enable the feature
    enable = true,
    -- allow to open the tree if it was previously closed
    auto_open = true,
  },
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor       = true,
  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually) 
  update_cwd          = false,
  -- show lsp diagnostics in the signcolumn
  lsp_diagnostics     = false,
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file = {
    -- enables the feature
    enable      = false,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd  = false,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {}
  },
  -- configuration options for the system open command (`s` in the tree by default)
  system_open = {
    -- the command to run this, leaving nil should work in most cases
    cmd  = nil,
    -- the command arguments as a list
    args = {}
  },

  view = {
    -- width of the window, can be either a number (columns) or a string in `%`
    width = "30%",
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- if true the tree will resize itself after opening a file
    auto_resize = false,
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = false,
      -- list of mappings to set on the tree manually
      list = {}
    }
  }
}

local opts = {
    tools = {
        runnables = {
            use_telescope = true
        },
        executor = require("rust-tools.executors").termopen,
        on_initialized = nil,
        reload_workspace_from_cargo_toml = true,
        inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = "  <- ",
            other_hints_prefix = "  => ",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
        },
        hover_actions = {
            auto_focus = false,
        },
    },

    server = {
        standalone = true,
        capabilities = require("fennel-config")["lsp-util"]["get-capabilities"](),
        handlers = require("fennel-config")["lsp-util"]["get-handlers"](),
    },

    --[[ dap = {
    adapter = {
      type = "executable",
      command = "lldb-vscode",
      name = "rt_lldb",
    },
  }, ]]
}

require('rust-tools').setup(opts)

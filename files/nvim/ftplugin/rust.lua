-- Replaced with lazy.nvim config

--[[ local opts = {
    tools = {
        runnables = {
            use_telescope = true
        },
        executor = require("rust-tools.executors").termopen,
        on_initialized = nil,
        reload_workspace_from_cargo_toml = true,
        inlay_hints = {
            auto = false,
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

    dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter("/usr/bin/codelldb", "/usr/lib/liblldb.so")
    },
}

(local opts {:dap {:adapter ((. (require :rust-tools.dap) :get_codelldb_adapter) :/usr/bin/codelldb
    :/usr/lib/liblldb.so)}
    :server {:capabilities ((. (. (require :fennel-config) :lsp-util)
        :get-capabilities))
        :handlers ((. (. (require :fennel-config) :lsp-util)
            :get-handlers))
        :standalone true}
    :tools {:executor (. (require :rust-tools.executors) :termopen)
    :hover_actions {:auto_focus false}
    :inlay_hints {:auto false
        :highlight :Comment
        :max_len_align false
            :max_len_align_padding 1
            :only_current_line false
            :other_hints_prefix "  => "
            :parameter_hints_prefix "  <- "
            :right_align false
            :right_align_padding 7
            :show_parameter_hints true}
        :on_initialized nil
        :reload_workspace_from_cargo_toml true
        :runnables {:use_telescope true}}}) ]]

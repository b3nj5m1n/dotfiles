(module keymaps
  {require
   {util util}})

; --- Make Ctrl+C behave like Escape ---
(util.set-keymap "Normal: Make Ctrl+C behave like Escape"
                 "<C-c>" "<Esc>")
(util.set-keymap "Visual: Make Ctrl+C behave like Escape"
                 "<C-c>" "<Esc>")
(util.set-keymap "Insert: Make Ctrl+C behave like Escape"
                 "<C-c>" "<Esc>")

; --- General ---
(util.set-keymap "Visual: Keep visual selection after indenting"
            ">" ">gv")
(util.set-keymap "Visual: Keep visual selection after indenting"
            "<" "<gv")
(util.set-keymap "Terminal: Exit to normal mode"
            "<C-g>" "<C-\\><C-n>")
(util.set-keymap "Normal: Source current file"
            "<C-s>" ":source %<CR>")
(util.set-keymap "Normal: Open all folds"
            "zR" ":lua require('ufo').openAllFolds()<CR>")
(util.set-keymap "Normal: Close all folds"
            "zM" ":lua require('ufo').closeAllFolds()<CR>")

; --- Splits ---
(util.set-keymap "Normal: Create vertical split"
            "<leader>wv" ":vsplit<CR>")
(util.set-keymap "Normal: Create horizontal split"
            "<leader>ws" ":split<CR>")
(util.set-keymap "Normal: Move to split on the left"
            "<leader>wh" "<C-W>h")
(util.set-keymap "Normal: Move to split on the bottom"
            "<leader>wj" "<C-W>j")
(util.set-keymap "Normal: Move to split on the top"
            "<leader>wk" "<C-W>k")
(util.set-keymap "Normal: Move to split on the right"
            "<leader>wl" "<C-W>l")

; --- Line highlighting ---
(util.set-keymap "Normal: Toggle highlight on the current line"
  "<leader>hl" ":set cursorline!<CR>")
(util.set-keymap "Normal: Toggle highlight on the current line"
  "<leader>hc" ":set cursorcolumn!<CR>")

; --- Snippets ---
(util.set-keymap "Insert: Expand Snippet"
  "<C-e>" "<Plug>luasnip-expand-snippet")
(util.set-keymap "Insert: Jump to next point in snippet"
  "<C-j>" "<Plug>luasnip-jump-next")
(util.set-keymap "Insert: Jump to previous point in snippet"
  "<C-k>" "<Plug>luasnip-jump-prev")

; --- Telescope ---
(util.set-keymap "Normal: Open fuzzy file finder"
                 "<leader>tf" ":lua require('telescope.builtin').find_files()<CR>")
(util.set-keymap "Normal: Open live grep"
                 "<leader>tg"  ":lua require('telescope.builtin').live_grep()<CR>")
(util.set-keymap "Normal: Open buffer list"
                 "<leader>tb"  ":lua require('telescope.builtin').buffers()<CR>")

; --- Lsp ---
(util.set-keymap "Normal: Format buffer"
                 "<leader>ll" ":lua vim.lsp.buf.format()<CR>")
(util.set-keymap "Normal: Rename symbol under cursor"
                 "<leader>lr" ":lua vim.lsp.buf.rename()<CR>")
(util.set-keymap "Normal: Code action"
                 "<leader>la" ":lua vim.lsp.buf.code_action()<CR>")
(util.set-keymap "Normal: Hover doc"
                 "<leader>lh" ":lua vim.lsp.buf.hover()<CR>")
; (util.set-keymap "Normal: Peek definition"
;                  "<leader>ld" "<cmd>Lspsaga peek_definition<CR>")

; --- Dap ---
(util.set-keymap "Normal: Toggle Breakpoint"
                 "<localleader>dd" ":lua require('dap').toggle_breakpoint()<CR>")
(util.set-keymap "Normal: Continue debugging"
                 "<localleader>dc" ":lua require('dap').continue()<CR>")
(util.set-keymap "Normal: Step into"
                 "<localleader>di" ":lua require('dap').step_into()<CR>")
(util.set-keymap "Normal: Step over"
                 "<localleader>do" ":lua require('dap').step_over()<CR>")
(util.set-keymap "Normal: Toggle DAP-UI"
                 "<localleader>du" ":lua require('dapui').toggle()<CR>")

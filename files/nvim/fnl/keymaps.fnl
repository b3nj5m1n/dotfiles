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
(util.set-keymap "Normal: Move current line down"
            "<C-j>" ":lua require(\"fennel-config\")[\"util\"][\"move-current-line\"](\"down\")<CR>")
(util.set-keymap "Normal: Move current line up"
            "<C-k>" ":lua require(\"fennel-config\")[\"util\"][\"move-current-line\"](\"up\")<CR>")
(util.set-keymap "Visual: Move current selection down"
            "<C-j>" ":lua require(\"fennel-config\")[\"util\"][\"move-current-selection\"](\"down\")<CR>")
(util.set-keymap "Visual: Move current selection up"
            "<C-k>" ":lua require(\"fennel-config\")[\"util\"][\"move-current-selection\"](\"up\")<CR>")
(util.set-keymap "Insert: Move current line down"
            "<C-j>" "<C-o>:lua require(\"fennel-config\")[\"util\"][\"move-current-line\"](\"down\")<CR>")
(util.set-keymap "Insert: Move current line up"
            "<C-k>" "<C-o>:lua require(\"fennel-config\")[\"util\"][\"move-current-line\"](\"up\")<CR>")

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
  "<C-l>" "<Plug>luasnip-jump-next")
(util.set-keymap "Insert: Jump to previous point in snippet"
  "<C-h>" "<Plug>luasnip-jump-prev")

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
(util.set-keymap "Normal: Jump to definition"
                 "<leader>ldj" ":lua vim.lsp.buf.definition()<CR>")
; (util.set-keymap "Normal: Peek definition"
;                  "<leader>ld" "<cmd>Lspsaga peek_definition<CR>")
(util.set-keymap "Normal: Show diagnostics in floating window"
                 "<leader>lds" ":lua vim.diagnostic.open_float()<CR>")
(util.set-keymap "Normal: Go to next diagnostic"
                 "<leader>ldn" ":lua vim.diagnostic.goto_next()<CR>")
(util.set-keymap "Normal: Go to previous diagnostic"
                 "<leader>ldp" ":lua vim.diagnostic.goto_prev()<CR>")

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

; --- Yanky ---
(util.set-keymap "Normal: Paste after"
                 "p" "<Plug>(YankyPutAfter)")
(util.set-keymap "Normal: Paste before"
                 "P" "<Plug>(YankyPutBefore)")
(util.set-keymap "Normal: Yank cycle forward"
                 "<c-n>" "<Plug>(YankyCycleForward)")
(util.set-keymap "Normal: Yank cycle backward"
                 "<c-p>" "<Plug>(YankyCycleBackward)")

; --- Neogit ---
(util.set-keymap "Normal: Open Neogit"
                 "gN" ":Neogit<CR>")

; --- Typst ---
(util.set-keymap "Normal: Open Typst Preview"
                 "gP" ":TypstPreview<CR>")

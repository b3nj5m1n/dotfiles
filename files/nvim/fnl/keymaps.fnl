(module keymaps
  {require
   {util util}})

; --- General ---
(util.set-keymap "Visual: Keep visual selection after indenting"
            ">" ">gv")
(util.set-keymap "Visual: Keep visual selection after indenting"
            "<" "<gv")
(util.set-keymap "Terminal: Exit to normal mode"
            "<C-g>" "<C-\\><C-n>")
(util.set-keymap "Normal: Source current file"
            "<C-s>" ":source %<CR>")

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

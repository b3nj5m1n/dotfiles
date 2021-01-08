" " Tabs
" " Ctrl + h/l switch current tab to previous/next
" nnoremap <C-h> :tabprevious<CR>
" nnoremap <C-l> :tabnext<CR>
" " Alt + h/l moves the current tab to the left/right
" nnoremap <silent> <A-h> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
" nnoremap <silent> <A-l> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

" " Space + w + h/j/k/l for switching windows
" nnoremap <leader>wh <C-W>h
" nnoremap <leader>wj <C-W>j
" nnoremap <leader>wk <C-W>k
" nnoremap <leader>wl <C-W>l

" " Highlighting
" " Toggle current line highlighting
" nnoremap <leader>z :set cursorline!<CR>
" " Toggle current column highlighting
" nnoremap <leader>t :set cursorcolumn!<CR>

" " Open ranger
" nmap <leader>r :RnvimrToggle<CR>

" " Open fzf
" nnoremap <leader><space> :Files<CR>

" " Ripgrep
" nnoremap <leader>g :Rg<CR>

" " Append semicolon to end of line and return to previous location
" nnoremap g; m`A;<esc>``

" " Jump to placeholder in file, replace it and go into insert
" nmap <buffer> <leader>; /<%&%><CR>c5l

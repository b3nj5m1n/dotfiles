" Mod key
let mapleader = " "

" Tabs
" Ctrl + h/l switch current tab to previous/next
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
" Alt + h/l moves the current tab to the left/right
nnoremap <silent> <A-h> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-l> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

" Mod + u to switch between open split screens
nnoremap <leader>u <c-w>w

" Highlighting
" Toggle current line highlighting
nnoremap <leader>z :set cursorline!<CR>
" Toggle current column highlighting
nnoremap <leader>t :set cursorcolumn!<CR>

" Open ranger
nmap <leader>r :RnvimrToggle<CR>

" Open fzf
nnoremap <leader><space> :Files<CR>

" Ripgrep
nnoremap <leader>g :Rg<CR>

" Append semicolon to end of line and return to previous location
nnoremap g; m`A;<esc>``

" Jump to placeholder in file, replace it and go into insert
nmap <buffer> <leader>; /<%&%><CR>c5l


" LaTeX

" Compile document
map <leader>. :w! \| !/bin/scripts/compile-latex.sh "<c-r>%"<CR><CR>

" Open corresponding .pdf/.html or preview
map <leader>p :!zathura $(echo % \| sed 's/tex$/pdf/') & disown<CR>

" " Compile latex file
" map <leader>c :w! /tmp/tocompile.tex \| !/bin/scripts/compile-latex.sh "/tmp/tocompile.tex"&<CR><CR>

" " Open corresponding .pdf/.html or preview
" map <leader>p :!zathura /tmp/tocompile.pdf & disown<CR><CR>

" Mod key
let mapleader = " "

" Tabs
" Ctrl + h/l switch current tab to previous/next
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
" Alt + h/l moves the current tab to the left/right
nnoremap <silent> <A-h> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-l> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

" Ctrl + n to toggle nerd tree
map <C-n> :NERDTreeToggle<CR>

" Mod + u to switch between open split screens
nnoremap <leader>u <c-w>w

" Highlighting
" Toggle current line highlighting
nnoremap <leader>z :set cursorline!<CR>
" Toggle current column highlighting
nnoremap <leader>t :set cursorcolumn!<CR>

" Open ranger
nmap <leader>r :RnvimrToggle<CR>

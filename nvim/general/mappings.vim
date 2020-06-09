let mapleader = "*"

" Mappings

" Ctrl + a selects entire file
" map <C-a> <esc>ggVG<CR>

" Ctrl + left/right switch current tab to previous/next
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
" Alt + left/right moves the current tab to the left/right
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
" Ctrl + n to toggle nerd tree
map <C-n> :NERDTreeToggle<CR>
" Leader key + u to switch between open split screens
nnoremap <leader>u <c-w>w
" Use tab to indent selection & keep selection
" vmap <tab> >gvolloll

" Disable tab for youcompleteme
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
" Press ctrl + j to select a completion (First select with arrow keys)
nnoremap <C-j> g:ycm_key_list_select_completion

" Fold navigation
nnoremap <leader>o zo
nnoremap <leader>c zc
nnoremap <leader>j :call NextClosedFold('j')<cr>
nnoremap <leader>k :call NextClosedFold('k')<cr>
function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction


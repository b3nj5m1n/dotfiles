set nowrap

" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>

" Compile document
map <leader>. :w! \| !/bin/scripts/compile-latex.sh "<c-r>%"<CR><CR>

" Open corresponding .pdf/.html or preview
map <leader>p :!zathura $(echo % \| sed 's/tex$/pdf/') & disown<CR>

" " Compile latex file
" map <leader>c :w! /tmp/tocompile.tex \| !/bin/scripts/compile-latex.sh "/tmp/tocompile.tex"&<CR><CR>

" " Open corresponding .pdf/.html or preview
" map <leader>p :!zathura /tmp/tocompile.pdf & disown<CR><CR>

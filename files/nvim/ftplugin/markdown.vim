set wrap
set linebreak
set spell

" Compile document (c[ompile] d[ocument])
map <leader>cd :silent lua compile()<CR>
lua << EOF
function compile()
	vim.api.nvim_command('write')
    local filepath = vim.api.nvim_exec("echo expand('%:p')", true)
    local cmd = "/bin/compile " .. filepath .. ">/dev/null 2>/dev/null"
    io.popen(cmd)
end
EOF

" Open corresponding .pdf/.html or preview (c[ompile] s[how])
map <leader>cs :!zathura $(echo % \| sed -r 's/\.[^.]+$/.pdf/') & disown<CR>

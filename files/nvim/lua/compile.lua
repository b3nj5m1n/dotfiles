function compile()
	vim.api.nvim_command('write')
    local filepath = vim.api.nvim_exec("echo expand('%:p')", true)
    local cmd = "/bin/compile " .. filepath .. ">/dev/null 2>/dev/null"
    io.popen(cmd)
end

function run()
    local filepath = vim.api.nvim_exec("echo expand('%:p:r')", true)
    local fileextension = vim.api.nvim_exec("echo expand('%:e')", true)
    -- TODO: Make this figure out the proper extension for the compiled file based on the extension of the current file
    local newfileextension = '.pdf'
    local cmd = "/bin/run " .. filepath .. newfileextension .. ">/dev/null 2>/dev/null"
    io.popen(cmd)
end

-- Compile document (c[ompile] d[ocument])
vim.api.nvim_set_keymap('n', '<leader>cd', ':lua compile()<CR>', {noremap = true, silent = true})
-- Open corresponding .pdf/.html or preview (c[ompile] s[how])
vim.api.nvim_set_keymap('n', '<leader>cs', ':lua run()<CR>', {noremap = true, silent = true})

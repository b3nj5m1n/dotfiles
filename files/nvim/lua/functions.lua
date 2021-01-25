function make()
    -- Options for the buffer running the terminal
    local options = {
        bufhidden = 'wipe';
        buftype = 'nofile';
        modifiable = false;
    }
    -- Name the buffer running the terminal with the make command
    local buffer_name = "make_buffer"
    -- The width of the terminal window
    local window_width = "0.35"
    -- The side of the terminal window, L = right, H = right
    local window_side = "L"
    -- The handle of the buffer running the terminal with the make command
    local buffer_handle = vim.api.nvim_create_buf(false, true)
    -- Rename the buffer
    vim.api.nvim_buf_set_name(buffer_handle, buffer_name)
    -- Create a new vertical split, the current window is now the new window
    vim.api.nvim_command("vsplit")
    -- Put the buffer inside the new window
    vim.api.nvim_win_set_buf(0, buffer_handle)
    -- Move the window to the desired location
    vim.api.nvim_command("wincmd " .. window_side)
    -- Resize to the desired size
    vim.api.nvim_command("exec 'vertical resize '. string(&columns * " .. window_width .. ")")
    -- Open the terminal with the make command
    vim.api.nvim_command("edit term://make")
end

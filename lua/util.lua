local M = {}

-- sauce https://www.reddit.com/r/neovim/comments/oxddk9/how_do_i_get_the_value_from_a_highlight_group/
M.get_hl_val = function(name,val)
    local ok, hl = pcall(vim.api.nvim_get_hl_by_name, name, true)
    -- local ok, hl = pcall(vim.api.nvim_get_hl(0, {name = name}))
    if not ok then
        return
    end
    return string.format("#%06x",hl[val])
end


--- Handler for keybindng using vim.keymap.set()
-- @param mode string depicting mode
-- @param binding string for key combo
-- @param cmd function to run | string form of command
-- @param opt table of options | string for description
M.keymap = function (mode, binding, cmd, opt)
    if (type(opt) == 'table') then
        vim.keymap.set(mode, binding, cmd, opt)
    elseif (type(opt) == 'string') then
        local desc = opt -- opt is a description
        vim.keymap.set(mode, binding, cmd, { desc = desc })
    end
end

return M

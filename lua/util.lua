local M = {}

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

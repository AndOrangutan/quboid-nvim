local M = {}

--- Handler for keybindng that uses and maintains similar syntax to vim.keymap.set()
-- @param mode string depicting mode
-- @param binding string for key combo
-- @param cmd function to run | string form of command
-- @param opt table of options | string for description
M.keymap = function (mode, binding, cmd, opt)
    if (type(opt) == 'table') then
        vim.keymap.set(mode, binding, cmd, opt)
        -- TODO: Remove debug print
        print('vim.keymap.set("' .. mode .. '", "' .. binding .. '", "' .. cmd .. '", ' .. vim.inspect(opt) .. ')')
    elseif (type(opt) == 'string') then
        local desc = opt -- opt is a description
        -- print out the following command
        vim.keymap.set(mode, binding, cmd, { desc = desc })
        -- TODO: Remove debug print
        print('vim.keymap.set("' .. mode .. '", "' .. binding .. '", "' .. cmd .. '", { desc = "' .. desc .. '" })')
    end
end

return M

local M = {}

-- local material_icon_ok, material_icon = pcall(require, "nvim-material-icon")
-- if not material_icon_ok then
--     return
-- end

-- M.pequire = function (name)
--     local plugin_ok, plugin = pcall(require, name)
--     if not plugin_ok then
--         return
--     end
-- end

-- Function to use `vim.keymap.set` easier
-- mode String: Mode to be set
-- binding String: Key to be set
-- cmd String|Function: Command to run
-- opt String|Table: Description if string, options if table
M.keymap = function (mode, binding, cmd, opt)
    if (type(opt) == 'table') then
        vim.keymap.set(mode, binding, cmd, opt)
    elseif (type(opt) == 'string') then

    end

    vim.keymap.set(mode, binding, cmd, {desc = desc})
end

return M

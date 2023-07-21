local M


-- sauce https://www.reddit.com/r/neovim/comments/oxddk9/how_do_i_get_the_value_from_a_highlight_group/
M.get_hl_val = function(name,val)
    local ok, hl = pcall(vim.api.nvim_get_hl_by_name, name, true)
    -- local ok, hl = pcall(vim.api.nvim_get_hl(0, {name = name}))
    if not ok then
        return
    end
    return string.format("#%06x",hl[val])
end


--- Determines whether a table contains a value
---@param table [TODO:parameter]
---@param val [TODO:parameter]
---@return [TODO:return]
M.table_contains = function(table, val)
    for _, value in pairs(table) do
        if value == val then
            return true
        end
    end
    return false
end
return M

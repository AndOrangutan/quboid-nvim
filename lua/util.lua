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

M.toggle_cmd = function (cmd1, cmd2)
    if type(vim.g[cmd1..'_'..cmd2..'_toggle']) == 'nil' then
        vim.cmd(cmd1)
        vim.g[cmd1..'_'..cmd2..'_toggle'] = cmd1
    elseif vim.g[cmd1..'_'..cmd2..'_toggle'] == cmd1 then
        vim.cmd(cmd2)
        vim.notify("Toggled to "..cmd2, vim.log.levels['INFO'])
        vim.g[cmd1..'_'..cmd2..'_toggle'] = cmd2
    else
        vim.cmd(cmd1)
        vim.notify("Toggled to "..cmd1, vim.log.levels['INFO'])
        vim.g[cmd1..'_'..cmd2..'_toggle'] = cmd1
    end
end

return M


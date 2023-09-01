local M = {}

-- sauce https://www.reddit.com/r/neovim/comments/oxddk9/how_do_i_get_the_value_from_a_highlight_group/


--- Retrieve highlight values
---@param name string of the highlight
---@param val string 'foreground' or 'background'
---@return string|nil represented in hex
M.get_hl_val = function(name,val)
    local ok, hl = pcall(vim.api.nvim_get_hl_by_name, name, true)
    -- local ok, hl = pcall(vim.api.nvim_get_hl(0, {name = name}))
    if not ok then
        return nil
    end
    return string.format("#%06x",hl[val])
end

--- Toggle between two commands
---@param cmd1 string command one
---@param cmd2 string command two
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


M.input_builder = function (big_tbl_in, callback)
    local output = {}

    local recurse
    recurse = function (tbl_in,out_in)
        local input_opts = {}

        local entry = table.remove(tbl_in, 1)

        if entry == nil then
            callback(out_in)
            return
        end

        if type(entry[2]) == 'table' then
            input_opts = entry[2]
        elseif type(entry[2]) == 'string' then
            input_opts = {
                prompt = entry[2]
            }
        end

        vim.ui.input(input_opts, function (input)
            -- if type(entry[3]) == 'function' and entry[3](input) ~= nil then
            --     input = entry[3](input)
            -- end

            out_in[entry[1]] = input

            recurse(tbl_in, out_in)
        end)
    end

    recurse(big_tbl_in, output)
end


return M


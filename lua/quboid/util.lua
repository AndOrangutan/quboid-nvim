local M = {}

-- sauce https://www.reddit.com/r/neovim/comments/oxddk9/how_do_i_get_the_value_from_a_highlight_group/

--- Retrieve highlight values
---@param name string of the highlight
---@param val 'foreground'|'background'
---@return string|nil represented in hex
M.get_hl_val = function(name, val)
    local ok, hl = pcall(vim.api.nvim_get_hl_by_name, name, true)
	-- local ok, hl = pcall(vim.api.nvim_get_hl(0, {name = name}))
	if not ok then
		return nil
	end
	return string.format("#%06x", hl[val])
end

--- Toggle between two commands
---@param cmd1 string command one
---@param cmd2 string command two
M.toggle_cmd = function(cmd1, cmd2)
    if type(vim.g[cmd1 .. '_' .. cmd2 .. '_toggle']) == 'nil' then
        vim.cmd(cmd1)
        vim.g[cmd1 .. '_' .. cmd2 .. '_toggle'] = cmd1
    elseif vim.g[cmd1 .. '_' .. cmd2 .. '_toggle'] == cmd1 then
        vim.cmd(cmd2)
        vim.notify('Toggled to ' .. cmd2, vim.log.levels['INFO'])
        vim.g[cmd1 .. '_' .. cmd2 .. '_toggle'] = cmd2
    else
        vim.cmd(cmd1)
        vim.notify('Toggled to ' .. cmd1, vim.log.levels['INFO'])
        vim.g[cmd1 .. '_' .. cmd2 .. '_toggle'] = cmd1
    end
end

--- Gather multiple inputs using a table
---@param big_tbl_in table Consisting of { index, prompt, validator, post_input }
---@param callback function Callback function
-- local tmp_tbl = {
--     { 'index', 'Prmpt: ', function (input) return true end, function (table) return table end },
-- }
M.input_builder = function(builder_tbl, callback, pass_in)
    local output_tbl = {}

    if type(pass_in) == 'table' then
        output_tbl = pass_in
    end

    local recurse
    recurse = function(tbl, output)
        local input_opts = {}

        -- Return case
        local entry = table.remove(tbl, 1)
        if entry == nil then
            callback(output)
            return
        end

        -- Assign prompt
        if type(entry[2]) == 'table' then
            input_opts = entry[2]
        elseif type(entry[2]) == 'string' then
            input_opts = {
                prompt = entry[2], }
        end

        -- Gather input
        vim.ui.input(input_opts, function(input)
            if type(entry[3]) == 'function' then
                if entry[3](input) == false then
                    table.insert(tbl, 1, entry)
                end
            elseif input == '' then
                table.insert(tbl, 1, entry)
            else
                output[entry[1]] = input
            end

            if type(entry[4]) ~= 'nil' and type(entry[4]) == 'function' then
                output = entry[4](output)
            end

            recurse(tbl, output)
        end)
    end

    recurse(builder_tbl, output_tbl)
end

--- Finds longs string from list of strings or tables of strings.
---@param ... table|string input strings to be compared
---@return number longest length
M.max_width = function(...)
    local max = 0
    for i, v in ipairs({ ... }) do
        if type(v) == 'table' then
            for i, str in ipairs(v) do
                max = math.max(max, vim.str_utfindex(str))
            end
        elseif type(v) == 'string' then
            max = math.max(max, vim.str_utfindex(v))
        end
    end
    if max % 2 == 1 then
        max = max + 1
    end
    return max
end

--- Return a padded version of the string.
---@param str string input string
---@param wid_to_match number width to pad to
---@return string padded string
M.pad_to_width = function(str, wid_to_match)
    local add_pad = math.max((wid_to_match - #str) / 2, 0)
    return string.rep(' ', add_pad) .. str .. string.rep(' ', add_pad)
end

return M

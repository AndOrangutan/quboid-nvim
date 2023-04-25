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


M.table_contains = function(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

--- This beauty uses your mom as its weekend ride
-- Given a table like:
-- ```
-- local test = {
--     { 'name', 'Name: ', function(out) return out..' is stupid' end},
--     { 'height', 'Height (must be over 69): ', nil, function(input) return tonumber(input) ~= nil and tonumber(input) > 69 end },
--     { 'sex', 'Sex: '},
-- }
-- ```
-- it returns:
-- ```
-- {
--     height = "79",
--     name = "John Doe is stupid",
--     sex = "Every Day"
-- }
-- ```
M.input_builder = function(main_opts, main_input_table, main_callback, main_output)

    local copied_table = {}
    for k, v in pairs(main_input_table) do
        copied_table[k] = v
    end

    if (type(main_output) == 'nil') then
        main_output = {}
    end

    local function recurse(opts, input_table, callback, output)
        if copied_table == {} or #copied_table == 0 then

            if type(callback) == 'function' then
                callback(output)
            end

            return output
        else
            local loc_opts = opts

            local input_branch =  table.remove(copied_table, 1) -- pop

            if type(input_branch) ~= 'table' then
                vim.notify("Improper Syntax: got "..type(input_branch))
                return
            end

            -- 1 index to store data at
            -- 2 Prompt
            -- 3 Mod Function
            -- 4 Condition function

            loc_opts.prompt = input_branch[2]

            vim.ui.input(loc_opts, function (input)

                local temp_thing = { [input_branch[1]] = input}


                -- input modification funciton
                if type(input_branch[3]) == 'function' then
                    temp_thing = { [input_branch[1]] = input_branch[3](input) }
                end

                local continue, ret_opts = true, {}

                local good_opts = vim.tbl_extend('force', output, temp_thing)

                if type(input_branch[4]) == 'function' then
                    continue, ret_opts = input_branch[4](good_opts)
                    if type(ret_opts) == 'table' then good_opts = ret_opts end
                end

                if continue then
                    output = good_opts
                else
                    table.insert(copied_table, 1, input_branch)
                end

                M.input_builder(opts, copied_table, callback, output)

            end)
            -- if out_table == nil then out_table = {} end
        end
    end

    return recurse(main_opts, main_input_table, main_callback, main_output)
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

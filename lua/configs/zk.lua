
local util = require('util')

local wk = require('which-key')
local zk = require('zk')
local commands = require('zk.commands')
local lsp_util = require('lsp-util')


--     - [Z]k[I]nsert[I]dex
--    - [Z]k[I]nsert[N]ote


zk.setup({
    -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
    -- it's recommended to use "telescope" or "fzf"
    picker = "fzf",

    lsp = {
        -- `config` is passed to `vim.lsp.start_client(config)`
        config = {
            cmd = { "zk", "lsp" },
            name = "zk",
            on_attach = function (client, bufnr)
                lsp_util.on_attach(client, bufnr)
            end,
            -- on_attach = ...
            -- etc, see `:h vim.lsp.start_client()`
        },


        -- automatically attach buffers in a zk notebook that match the given filetypes
        auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
        },
    },
})



-- Input tree for input_builder
local groups_main = {
    ['base'] = {
        { { prompt = 'Title: ' }, 'title', nil, function(input) return input ~= '' or input ~= nil end},
    },
    ['index'] = {
        { { prompt = 'Subdiretory: ' }, 'dir',  function(input)
            local dirtocheck = vim.fn.expand('%:p:h')..'/'..input

            -- Create (sub)directory if needed
            if vim.fn.isdirectory(dirtocheck) == 0 then vim.fn.mkdir(dirtocheck, 'p') end

            return dirtocheck
        end, function(opts) 
            opts.extra = { ['type-tags'] = '#index' }
            return opts ~= '' or opts ~= nil
        end},
        { { prmpt = 'Title: ' }, 'title',  nil, function(input) return input ~= '' or input ~= nil end},
    },
    ['dir-calendar'] = {},
    ['dir-title'] = {
        { { prmpt = 'Title: ' }, 'title',  nil, function(input) return input ~= '' or input ~= nil end},
    },
    ['date-title'] = {
        { { prmpt = 'Title: ' }, 'title',  nil, function(input) return input ~= '' or input ~= nil end},
    },
}

util.keymap('n', '<leader>zn', function()

    local groups = groups_main
    local group_names = {}

    for k,v in pairs(groups) do table.insert(group_names, k) end

    vim.ui.select( group_names, {
        prompt = 'Select Group: '
    }, function (group_choice)
        util.input_builder({}, groups[group_choice], function (output)

            -- vim.notify(vim.inspect(output))

            local confirm_val = vim.fn.confirm("Use Custom Template?", "&No\n&Yes")
            if 1 == confirm_val then
                require('zk').new(output)
            elseif 2 == confirm_val then
                local templates = vim.split(vim.fn.system('ls -A '..vim.fn.expand('$XDG_CONFIG_HOME')..'/zk/templates'..'/'..group_choice), '\n')
                -- Add group_choice/
                for i, v in ipairs(templates) do if v == "" then table.remove(templates, i) end end
                for k, v in pairs(templates) do templates[k] = group_choice..'/'..v end
                -- Include base template
                table.insert(templates, group_choice..'.md')

                vim.ui.select(templates, {
                    prompt = 'Select Template: '
                }, function (template_choice)
                    output['template'] = template_choice
                    require('zk').new(output)
                end)
            end
        end, { group = group_choice, dir = vim.fn.expand('%:p:h') })
    end)
end, '[z]k [n]ew')

util.keymap('n', '<leader>zs', '<cmd>ZkNotes<cr>', '[z]k [s]earch')
util.keymap('n', '<cr>', '<cmd>lua vim.lsp.buf.definition()<cr>', 'Zk Open Link')

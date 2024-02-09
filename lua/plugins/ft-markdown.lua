return {
    {
        'mickael-menu/zk-nvim',
        ft = require('quboid.ft').markup,
        cmd = {
            'ZkCd',
        },
        config = function()
            local lsp_config = require('quboid.lsp').gen_config()
            lsp_config = vim.tbl_extend('keep', lsp_config or {}, { cmd = { 'zk', 'lsp' }, name = 'zk' })

            require('zk').setup({
                -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
                -- it's recommended to use "telescope" or "fzf"
                picker = 'fzf_lua',

                lsp = {
                    -- `config` is passed to `vim.lsp.start_client(config)`
                    config = lsp_config,

                    -- automatically attach buffers in a zk notebook that match the given filetypes
                    auto_attach = {
                        enabled = true,
                        filetypes = require('quboid.ft').markup,
                    },
                },
            })
        end,
        keys = {
            { '<leader>zn', function()
                local group_tbl = {
                    ['base'] = {
                        { 'title', 'Title: ' },
                    },
                    ['index'] = {
                        { 'dir', 'Subdirectory: ', nil, function(table)
                            local dirtocheck = vim.fn.expand('%:p:h') .. '/' .. table.dir
                            -- Create (sub)directory if needed
                            if vim.fn.isdirectory(dirtocheck) == 0 then vim.fn.mkdir(dirtocheck, 'p') end
                            table.dir = dirtocheck

                            table.extra = { ['type-tags'] = '#index' }
                            return table
                        end
                        },
                        { 'title', 'Title: ' },
                    },
                    ['dir-calendar'] = {}, -- TODO: add dir-calendar
                    ['dir-title'] = {
                        { 'title', 'Title: ' },
                    },
                    ['date-title'] = {
                        { 'title', 'Title: ' },
                    }
                }

                local group_names = {}
                for k, _ in pairs(group_tbl) do table.insert(group_names, k) end

                vim.ui.select(group_names, {
                    prompt = 'Select Group: ',
                }, function(group_choice)
                        require('quboid.util').input_builder(group_tbl[group_choice], function (table)
                        vim.notify(vim.inspect(table))

                        local confirm_val = vim.fn.confirm('Use Custom Template?', '&No\n&Yes')
                        if confirm_val == 1 then
                            require('zk').new(table)
                        elseif confirm_val == 2 then
                            local templates = vim.split(
                                vim.fn.system('ls -A ' ..
                                    vim.fn.expand('$XDG_CONFIG_HOME') .. '/zk/templates' .. '/' .. group_choice), '\n')
                            -- Add group_choice/
                            for i, v in ipairs(templates) do if v == '' then table.remove(templates, i) end end
                            for k, v in pairs(templates) do templates[k] = group_choice .. '/' .. v end
                            -- Include base template
                            table.insert(templates, group_choice .. '.md')

                            vim.ui.select(templates, {
                                prompt = 'Select Template: '
                            }, function(template_choice)
                                if template_choice ~= nil then
                                    table['template'] = template_choice
                                    require('zk').new(table)
                                end
                            end)
                        end
                    end, { group = group_choice, dir = vim.fn.expand('%:p:h') })
                end)
            end },
            { '<leader>zs', '<cmd>ZkNotes<cr>',                      desc = '[z]k [s]earch' },
            { '<leader>zl', '<cmd>ZkLinks<cr>',                      desc = '[z]k [l]inks' },
            { '<leader>zb', '<cmd>ZkBacklinks<cr>',                  desc = '[z]k [b]acklinks' },
            { '<leader>zi', '<cmd>ZkInsertLink<cr>',                 desc = '[z]k [i]sert Link' },
            { '<cr>',       function() vim.lsp.buf.definition() end, desc = 'Zk Follow note' }
        },
    }
}

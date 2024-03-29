return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'linrongbin16/lsp-progress.nvim'
        },
        event = 'VeryLazy',
        config = function()
            local icons = require('quboid.icons')
            local util = require('quboid.util')

            local lsp_progress_ok, lsp_progress = pcall(require, 'lsp-progress')
            local overseer = require('overseer')


            local function min_window_width(width)
                return function() return vim.fn.winwidth(0) > width end
            end

            require('lualine').setup({
                options = {
                    theme = 'auto',
                    section_separators = { left = '', right = '' },
                    component_separators = { left = icons.ui.bar_thin, right = icons.ui.bar_thin },
                    -- component_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    globalstatus = true,
                    ignore_focus = {}, -- TODO: maybe set to exclude ft
                },
                sections = {
                    lualine_a = {
                        { 'mode', fmt = function(str) return string.lower(str:sub(1, 1)) end },
                    },

                    lualine_b = {
                        {
                            'branch',
                            -- cond = min_window_width(120),
                            icon = icons.gen.box_git,
                        },
                        {
                            'diff',
                            symbols = {
                                added = icons.gen.box_added,
                                modified = icons.gen.box_modified,
                                removed = icons.gen.box_deleted,
                            }, -- Changes the symbols used by the diff.
                            -- cond = min_window_width(120),
                            on_click = function() vim.cmd('Neogit') end,
                        },
                    },
                    lualine_c = {
                        {
                            'diagnostics',
                            update_in_insert = true,
                            symbols = {
                                error = icons.gen.circle_error,
                                warn = icons.gen.circle_warn,
                                info = icons.gen.circle_info,
                                hint = icons.gen.circle_hint
                            },
                            on_click = function() vim.cmd('TroubleToggle document_diagnostics') end,
                        },
                        {
                            lsp_progress.progress,
                            cond = min_window_width(80),
                            color = function(section)
                                return { fg = util.get_hl_val('Comment', 'foreground') }
                            end,
                            on_click = function() vim.cmd('LspInfo') end,
                        },
                    },
                    lualine_x = {
                        {
                            'searchcount',
                            icon = ' ',
                            color = function(section)
                                return { fg = util.get_hl_val('Search', 'background') }
                            end,
                            on_click = function() vim.cmd('noh') end,
                        },
                        {
                            'selectioncount',
                            icon = ' ',
                            color = function(section)
                                return { fg = util.get_hl_val('String', 'foreground') }
                            end,
                        },
                        {
                            'overseer',
                            label = '',     -- Prefix for task counts
                            colored = true, -- Color the task icons and counts
                            symbols = {
                                [overseer.STATUS.FAILURE] = 'F:',
                                [overseer.STATUS.CANCELED] = 'C:',
                                [overseer.STATUS.SUCCESS] = 'S:',
                                [overseer.STATUS.RUNNING] = 'R:',
                            },
                            unique = false,     -- Unique-ify non-running task count by name
                            name = nil,         -- List of task names to search for
                            name_not = false,   -- When true, invert the name search
                            status = nil,       -- List of task statuses to display
                            status_not = false, -- When true, invert the status search
                        },
                        {
                            require('lazy.status').updates,
                            cond = require('lazy.status').has_updates,
                            color = function(section)
                                return { fg = util.get_hl_val('String', 'foreground') }
                            end,
                            on_click = function() vim.cmd('Lazy') end,
                        },
                    },
                    lualine_y = {
                        { 'filetype' },
                        { 'filesize' },
                        -- { 'encoding',
                        --     cond = min_window_width(120)
                        -- },
                    },
                    lualine_z = {
                        { 'location' },
                    },

                },
            })
            -- listen lsp-progress event and refresh lualine
            vim.api.nvim_create_augroup('lualine_augroup', { clear = true })
            vim.api.nvim_create_autocmd('User', {
                group = 'lualine_augroup',
                pattern = 'LspProgressStatusUpdated',
                callback = require('lualine').refresh,
            })
        end,
    },
    {
        'linrongbin16/lsp-progress.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local icons = require('quboid.icons')
            require('lsp-progress').setup({
                spinner = icons.spinner,
                client_format = function(client_name, spinner, series_messages)
                    if #series_messages == 0 then
                        return nil
                    end
                    return {
                        name = client_name,
                        body = spinner .. ' ' .. table.concat(series_messages, ', '),
                    }
                end,
                format = function(client_messages)
                    --- @param name string
                    --- @param msg string?
                    --- @return string
                    local function stringify(name, msg)
                        return msg and string.format('%s %s', name, msg) or name
                    end

                    local sign = require('quboid.icons').gen.server -- nf-fa-gear \uf013
                    local lsp_clients = vim.lsp.get_active_clients()
                    local messages_map = {}
                    for _, climsg in ipairs(client_messages) do
                        messages_map[climsg.name] = climsg.body
                    end

                    if #lsp_clients > 0 then
                        table.sort(lsp_clients, function(a, b)
                            return a.name < b.name
                        end)
                        local builder = {}
                        for _, cli in ipairs(lsp_clients) do
                            if
                                type(cli) == 'table'
                                and type(cli.name) == 'string'
                                and string.len(cli.name) > 0
                            then
                                if messages_map[cli.name] then
                                    table.insert(
                                        builder,
                                        stringify(cli.name, messages_map[cli.name])
                                    )
                                else
                                    table.insert(builder, stringify(cli.name))
                                end
                            end
                        end
                        if #builder > 0 then
                            return sign .. table.concat(builder, ', ')
                        end
                    end
                    return ''
                end,
            })
        end
    }
}

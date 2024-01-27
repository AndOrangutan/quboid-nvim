return {
    {
        'echasnovski/mini.notify',
        config = function()
            local quboid = require('quboid')

            local opts = { ERROR = { duration = 10000 } }
            vim.notify = require('mini.notify').make_notify(opts)

            require('mini.notify').setup({
                -- Content management
                content = {
                    -- Function which formats the notification message
                    -- By default prepends message with notification time
                    format = nil,

                    -- Function which orders notification array from most to least important
                    -- By default orders first by level and then by update timestamp
                    sort = function(notif_arr)
                        table.sort(
                            notif_arr,
                            function(a, b) return a.ts_update > b.ts_update end
                        )
                        return notif_arr
                    end,
                },
                lsp_progress = {
                    enable = false,
                    duration_last = 500,
                },
                window = {
                    config = {
                        border = require('quboid').border,
                    },
                    winblend = require('quboid').winblend,
                },
            })

            vim.api.nvim_create_user_command('MiniNotifyHistory', function()
                vim.cmd [[split]]
                require('mini.notify').show_history()
            end, {})
            vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
                local client = vim.lsp.get_client_by_id(ctx.client_id)

                print('Did a thing, look')
                vim.notify(result.message, result.type { title = 'LSP | ' .. client.name, timeout = 10000, })
            end
        end,
        -- event = { 'BufReadPre', 'BufNewFile' },
    },
}

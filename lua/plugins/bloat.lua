return {
    {
        'echasnovski/mini.animate',
        config = function()
            local m_animate = require('mini.animate')

            -- Smooth mouse
            local mouse_scrolled = false
            for _, scroll in ipairs({ 'Up', 'Down' }) do
                local key = '<ScrollWheel' .. scroll .. '>'
                vim.keymap.set('', key, function()
                    mouse_scrolled = true
                    return key
                end, { expr = true })
            end

            m_animate.setup({
                scroll = {
                    timing = m_animate.gen_timing.linear({ duration = 150, unit = 'total' }),
                    subscroll = m_animate.gen_subscroll.equal({
                        predicate = function(total_scroll)
                            if mouse_scrolled then
                                mouse_scrolled = false
                                return false
                            end
                            return total_scroll > 1
                        end,
                    }),
                },
                resize = {
                    timing = m_animate.gen_timing.linear({ duration = 100, unit = 'total' }),
                },
                -- open = {
                --     timing = m_animate.gen_timing.linear({ duration = 150, unit = "total" }),
                -- },
                -- close = {
                --     timing = m_animate.gen_timing.linear({ duration = 150, unit = "total" }),
                -- },
            })
        end,
        event = 'VeryLazy',
        version = false,
    },
    {
        'echasnovski/mini.indentscope',
        dependencies = {
            'echasnovski/mini.starter'
        },
        event = { 'BufReadPre', 'BufNewFile', 'BufEnter' },
        version = false,
        config = function()
            local icons = require('quboid.icons')
            local ft = require('quboid.ft')

            require('mini.indentscope').setup({
                options = { try_as_border = true },
                symbol = icons.ui.bar_thick_split,
            })

            local indentscope_disable = vim.api.nvim_create_augroup('indentscope_disable', { clear = true })

            vim.api.nvim_create_autocmd({ 'FileType' }, {
                pattern = require('quboid.ft').ft_exclude,
                group = indentscope_disable,
                callback = function(opts)
                    vim.schedule(function()
                        vim.b.miniindentscope_disable = true
                    end)
                end,
            })
            vim.api.nvim_create_autocmd({ 'User' }, {
                pattern = 'MiniStarterOpened',
                group = indentscope_disable,
                callback = function(opts)
                    vim.schedule(function()
                        vim.b.miniindentscope_disable = true
                    end)
                end,
            })

            vim.api.nvim_create_autocmd({ 'Filetype' }, {
                pattern = ft.markup,
                group = indentscope_disable,
                callback = function(opts)
                    vim.schedule(function()
                        vim.b.miniindentscope_disable = true
                    end)
                end,
            })
        end,
    },
    {
        'echasnovski/mini.map',
        -- main = 'mini.map',
        config = function()
            local icons = require('quboid.icons')

            local map = require('mini.map')
            map.setup({
                symbols = {
                    scroll_ldine = icons.ui.bar_cursor,
                    scroll_view = icons.ui.bar_thick,
                },
                window = { show_integration_count = false },
                integrations = {
                    map.gen_integration.builtin_search({
                        search = 'ReverseSearch',
                    }),
                    map.gen_integration.diagnostic(),
                    map.gen_integration.gitsigns(),
                },
            })


            vim.api.nvim_create_user_command('MiniMapToggle', function()
                require('mini.map').toggle()
            end, {})
            vim.api.nvim_create_user_command('MiniMapFocus', function()
                require('mini.map').toggle_focus()
            end, {})
            vim.api.nvim_create_user_command('MiniMapSwitch', function()
                require('mini.map').toggle_side()
            end, {})
            vim.api.nvim_create_user_command('MiniMapRefresh', function()
                require('mini.map').refresh({}, { lines = false, scrollbar = false })
            end, {})
        end,
        keys = {
            { '<leader>mm', '<cmd>MiniMapToggle<cr>',        desc = '[m]ini [m]ap' },
            { '<leader>mf', '<cmd>MiniMapFocus<cr>',         desc = 'Mini [m]ap Switch [f]ocus' },
            { '<leader>ms', '<cmd>MiniMapSwitch<cr>',        desc = 'Mini [m]ap Switch [s]ides' },
            { 'n',          'n' .. '<cmd>MiniMapRefresh<cr>' },
            { 'N',          'N' .. '<cmd>MiniMapRefresh<cr>' },
            { '*',          '*' .. '<cmd>MiniMapRefresh<cr>' },
            { '#',          '#' .. '<cmd>MiniMapRefresh<cr>' },
        },
        event = 'VeryLazy',
        -- version = false,
    },
}

return {
 	{ 'echasnovski/mini.nvim', version = false },
    { 'echasnovski/mini.align',
        config = function () require('mini.align').setup() end,
        event = 'VeryLazy',
        version = false,
    },
    { 'echasnovski/mini.animate',
        config = function ()
            local m_animate = require('mini.animate')

            -- Smooth mouse
            local mouse_scrolled = false
            for _, scroll in ipairs({ "Up", "Down" }) do
                local key = "<ScrollWheel" .. scroll .. ">"
                vim.keymap.set("", key, function()
                    mouse_scrolled = true
                    return key
                end, { expr = true })
            end

            m_animate.setup({
                scroll = {
                    timing = m_animate.gen_timing.linear({ duration = 150, unit = "total" }),
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
                    timing = m_animate.gen_timing.linear({ duration = 100, unit = "total" }),
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
    { 'echasnovski/mini.comment',
        config = function () require('mini.comment').setup() end,
        event = 'VeryLazy',
        version = false,
    },
    { 'echasnovski/mini.indentscope',
        dependencies = {
            'echasnovski/mini.starter'
        },
        config = function ()
            local quboid = require('quboid')

            require('mini.indentscope').setup({
                options = { try_as_border = true },
                symbol = quboid.icons.bar_thick_split,
            })

            local indentscope_disable = vim.api.nvim_create_augroup("indentscope_disable", {clear = true})

            vim.api.nvim_create_autocmd({ 'FileType' }, {
                pattern = require('quboid').ft_exclude,
                group = indentscope_disable,
                callback = function (opts)
                    vim.schedule(function ()
                        vim.b.miniindentscope_disable = true
                    end)
                end,
            })
            vim.api.nvim_create_autocmd({ 'User' }, {
                pattern = 'MiniStarterOpened',
                group = indentscope_disable,
                callback = function (opts)
                    vim.schedule(function ()
                        vim.b.miniindentscope_disable = true
                    end)
                end,
            })

            vim.api.nvim_create_autocmd({ 'Filetype' }, {
                pattern = quboid.ft_markup,
                group = indentscope_disable,
                callback = function (opts)
                    vim.schedule(function ()
                        vim.b.miniindentscope_disable = true
                    end)
                end,
            })

        end,
        -- event = { 'BufReadPre', 'BufNewFile' }, -- NOTE: Needed for autocmd to work
        -- event = 'VeryLazy',
        version = false
    },
    { 'echasnovski/mini.map',
        -- main = 'mini.map',
        config = function ()
            local quboid = require('quboid')

            local map = require('mini.map')
            map.setup({
                symbols = {
                    scroll_ldine = quboid.icons.bar_cursor,
                    scroll_view = quboid.icons.bar_thick,
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
        end,
        keys = {
            { '<leader>mm', '<cmd>lua require("mini.map").toggle()<cr>' },
            { '<leader>mf', '<cmd>lua require("mini.map").toggle_focus()<cr>', desc = 'Mini [m]ap Switch [f]ocus' },
            { '<leader>ms', '<cmd>lua require("mini.map").toggle_side()<cr>', desc = 'Mini [m]ap Switch [s]ides' },
            { 'n', 'n'..'<cmd>lua require("mini.map").refresh({}, {lines = false, scrollbar = false})<cr>' },
            { 'N', 'N'..'<cmd>lua require("mini.map").refresh({}, {lines = false, scrollbar = false})<cr>' },
            { '*', '*'..'<cmd>lua require("mini.map").refresh({}, {lines = false, scrollbar = false})<cr>' },
            { '#', '#'..'<cmd>lua require("mini.map").refresh({}, {lines = false, scrollbar = false})<cr>' },
        },
        -- event = 'VeryLazy',
        -- version = false,
    },
}

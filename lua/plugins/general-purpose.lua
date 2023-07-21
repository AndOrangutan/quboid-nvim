return {
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
                end, { noremap = true, expr = true })
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
        config = function () 
            local quboid = require('quboid')

            require('mini.indentscope').setup({
                options = { try_as_border = true },
                symbol = quboid.icons.bar_thick_split,
            })

            vim.api.nvim_create_autocmd('FileType', {
                pattern = quboid.ft_marktex,
                callback = function ()
                    vim.b.miniindentscope_disable = true
                end,
            })

        end,
        -- event = { 'BufReadPre', 'BufNewFile' },
        event = 'VeryLazy',
        version = false
    },
    { 'echasnovski/mini.map',
        config = function ()
            local quboid = require('quboid')

            local map = require('mini.map')
            map.setup({
                symbols = {
                    scroll_line = quboid.icons.bar_cursor,
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
            { '<leader>mm', require('mini.map').toggle, desc = '[m]ini [m]ap Toggle' },
            { '<leader>mf', require('mini.map').toggle_focus, desc = 'Mini [m]ap Switch [f]ocus' },
            { '<leader>ms', require('mini.map').toggle_side, desc = 'Mini [m]ap Switch [s]ides' },
            { 'n', 'n'..'<cmd>lua MiniMap.refresh({}, {lines = false, scrollbar = false})<cr>' },
            { 'N', 'N'..'<cmd>lua MiniMap.refresh({}, {lines = false, scrollbar = false})<cr>' },
            { '*', '*'..'<cmd>lua MiniMap.refresh({}, {lines = false, scrollbar = false})<cr>' },
            { '#', '#'..'<cmd>lua MiniMap.refresh({}, {lines = false, scrollbar = false})<cr>' },
        },
        event = 'VeryLazy',
        version = false,
    },
}

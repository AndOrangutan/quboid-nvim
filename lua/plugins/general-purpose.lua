local util = require('util')
local quboid = require('quboid')
local icons = quboid.icons


return {
    -- { 'echasnovski/mini.ai',
    --     config = function () require('mini.ai').setup() end,
    --     event = { 'BufReadPre', 'BufNewFile' },
    --     version = false,
    -- },
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
        version = false,
    },
    { 'echasnovski/mini.indentscope',
        config = function () 
            require('mini.indentscope').setup({
                options = { try_as_border = true },
                symbol = icons.bar_thick_split,
            })

            vim.api.nvim_create_autocmd('FileType', {
                pattern = quboid.ft_exclude,
                callback = function ()
                    vim.b.miniindentscope_disable = true
                end,
            })

            vim.api.nvim_create_autocmd('FileType', {
                pattern = quboid.ft_marktex,
                callback = function ()
                    vim.b.miniindentscope_disable = true
                end,
            })

        end,
        event = { 'BufReadPre', 'BufNewFile' },
        version = false
    },
    { 'echasnovski/mini.map',
        config = function ()
            local map = require('mini.map')
            map.setup({
                symbols = {
                    scroll_line = icons.triangle_cursor,
                    scroll_view = icons.bar_thick,
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

            for _, key in ipairs({ 'n', 'N', '*', '#' }) do
                vim.keymap.set( 'n', key, key .. '<Cmd>lua MiniMap.refresh({}, {lines = false, scrollbar = false})<CR>'
                )
            end
            util.keymap('n', '<leader>mm', map.toggle, '[m]ini [m]Map Toggle')
            util.keymap('n', '<leader>mf', map.toggle_focus, 'Mini [m]ap Tggl. [f]ocus')
            util.keymap('n', '<leader>ms', map.toggle_side, 'Mini [m]ap [s]witch sides')

        end,
        event = 'VeryLazy',
        version = false,
    },
}

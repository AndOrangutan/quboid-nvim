local util = require('util')
local quboid = require('quboid')
local icons = quboid.icons


return {
    { 'echasnovski/mini.ai',
        config = function () require('mini.ai').setup() end,
        version = false,
    },
    { 'echasnovski/mini.animate',
        config = function ()
            local m_animate = require('mini.animate')

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

            -- local map_scroll_with_center = function(lhs)
            --     local center_command =
            --     [[if MiniAnimate ~= nil then MiniAnimate.execute_after('scroll', 'normal! zz') else vim.cmd('normal! zz') end]]
            --
            --     local rhs = string.format([[<Cmd>lua pcall(vim.cmd, 'normal! %s'); %s<CR>]], lhs, center_command)
            --     vim.keymap.set('n', lhs, rhs, {})
            -- end
            --
            -- map_scroll_with_center('<C-d>')
            -- map_scroll_with_center('<C-u>')
            -- map_scroll_with_center('gg')
            -- map_scroll_with_center('G')
            -- map_scroll_with_center('n')
            -- map_scroll_with_center('N')

            -- Smooth mouse
            local mouse_scrolled = false
            for _, scroll in ipairs({ "Up", "Down" }) do
                local key = "<ScrollWheel" .. scroll .. ">"
                vim.keymap.set("", key, function()
                    mouse_scrolled = true
                    return key
                end, { noremap = true, expr = true })
            end

            -- Auto resize windows
            local function sizes()
                vim.go.winwidth = math.max(80, math.floor(vim.go.columns * 0.5))
                vim.go.winminwidth = 36
                vim.go.winheight = math.max(20, math.floor(vim.go.lines * 0.5))
                vim.go.winminheight = 5
            end

            sizes()
            vim.api.nvim_create_autocmd("VimResized", { callback = sizes })

        end,
        version = false,
    },
    { 'echasnovski/mini.comment',
        config = function () require('mini.comment').setup() end,
        version = false,
    },
    { 'echasnovski/mini.indentscope',
        config = function () 
            require('mini.indentscope').setup({
                options = {
                    border = 'both',
                    indent_at_cursor = true,
                    try_as_border = true,
                },
                symbol = icons.bar_thick_split,
            })

            for _, exludefile in pairs(quboid.ft_marktex) do
                vim.cmd('autocmd filetype '..exludefile..' lua vim.b.miniindentscope_disable = true')
            end

            for _, exludefile in pairs(quboid.ft_exclude) do
                vim.cmd('autocmd filetype '..exludefile..' lua vim.b.miniindentscope_disable = true')
            end

        end,
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
                        search = 'Search'
                        -- TODO: Add 'ReverseSearch' highlight for minimap
                        -- search = 'ReverseSearch'
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
        version = false,
    },
}

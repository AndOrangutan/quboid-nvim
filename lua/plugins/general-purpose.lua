local util = require('util')


return {
    { 'echasnovski/mini.ai',
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
        version = false,
    }
}

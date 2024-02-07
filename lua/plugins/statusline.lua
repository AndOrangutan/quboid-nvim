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
                            separator = '',
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
                            separator = '',
                            on_click = function() vim.cmd('TroubleToggle document_diagnostics') end,
                        },
                        {
                            lsp_progress.progress,
                            cond = min_window_width(80),
                            color = function(section)
                                return { fg = util.get_hl_val('Comment', 'foreground') }
                            end,
                            seperator = '',
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
        end,
    },
    {
        'linrongbin16/lsp-progress.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lsp-progress').setup()
        end
    }
}

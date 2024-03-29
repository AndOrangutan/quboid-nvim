return {
    {
        'akinsho/bufferline.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            local icons = require('quboid.icons')

            require('bufferline').setup({
                options = {
                    indicator                    = {
                        icon = ' ',
                        style = 'none',
                    },
                    buffer_close_icon            = icons.gen.close,
                    modified_icon                = icons.gen.pencil,
                    close_icon                   = icons.gen.close,
                    left_trunc_marker            = icons.gen.arrow_left,
                    right_trunc_marker           = icons.gen.arrow_right,
                    max_name_length              = 14,
                    max_prefix_length            = 13, -- prefix used when a buffer is de-duplicated
                    tab_size                     = 20,
                    diagnostics                  = 'nvim_lsp',
                    diagnostics_update_in_insert = false,
                    -- NOTE: this will be called a lot so don't do any heavy processing here
                    custom_filter                = function(buf_number, buf_numbers)
                        -- filter out filetypes you don't want to see
                        if vim.bo[buf_number].filetype ~= '<i-dont-want-to-see-this>' then
                            return true
                        end
                        -- filter out by buffer name
                        if vim.fn.bufname(buf_number) ~= '<buffer-name-I-dont-want>' then
                            return true
                        end
                        -- filter out based on arbitrary rules
                        -- e.g. filter out vim wiki buffer from tabline in your work repo
                        if vim.fn.getcwd() == '<work-repo>' and vim.bo[buf_number].filetype ~= 'wiki' then
                            return true
                        end
                        -- filter out by it's index number in list (don't show first buffer)
                        if buf_numbers[1] ~= buf_number then
                            return true
                        end
                    end,
                    offsets                      = {
                        {
                            filetype = 'neo-tree',
                            text = 'Neo Tree',
                            highlight = 'NeoTreeNormal',
                            text_align = 'center',
                            padding = 0
                        },
                        {
                            filetype = 'NvimTree',
                            text = 'File Tree',
                            highlight = 'NvimTreeNormal',
                            text_align = 'center',
                            padding = 0
                        },
                        {
                            filetype = 'Outline',
                            text = 'Symbol Outline',
                            highlight = 'NvimTreeNormal',
                            text_align = 'center',
                            padding = 0
                        },
                        {
                            filetype = 'undotree',
                            text = 'Undo Tree',
                            highlight = 'NvimTreeNormal',
                            text_align = 'center',
                            padding = 0
                        },
                        {
                            filetype = 'OverseerList',
                            text = 'Overseer Build List',
                            highlight = 'NvimTreeNormal',
                            text_align = 'center',
                            padding = 0
                        },
                    },
                    color_icons                  = true, -- whether or not to add the filetype icon highlights
                    show_buffer_icons            = true, -- disable filetype icons for buffers
                    show_buffer_close_icons      = true,
                    show_close_icon              = false,
                    show_tab_indicators          = false,
                    persist_buffer_sort          = true, -- whether or not custom sorted buffers should persist
                    -- can also be a table containing 2 custom separators
                    -- [focused and unfocused]. eg: { '|', '|' }
                    separator_style              = 'thick',
                    enforce_regular_tabs         = false,
                    always_show_bufferline       = true,
                    sort_by                      = 'id',
                },
            })
        end,
        event = { 'BufReadPre', 'BufNewFile', 'BufEnter' },
        keys = {
            { '<M-.>', '<cmd>BufferLineCycleNext<cr>', desc = 'Bufferline Cycle Next' },
            { '<M-,>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Bufferline Cycle Prev' },
        },
    },
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

        end,
        event = { 'BufReadPre', 'BufNewFile', 'BufEnter' },
    },
    {
        'luukvbaal/statuscol.nvim',
        config = function()
            local ft = require('quboid.ft')
            local builtin = require('statuscol.builtin')
            require('statuscol').setup({
                foldfunc = 'builtin',
                ft_ignore = ft.ft_exclude,
                bt_ignore = ft.bt_exclude,
                setopt = true,
                thousands = false,
                relculright = true,
                segments = {
                    { text = { '%s' },                  click = 'v:lua.ScSa' },
                    { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
                    { text = { builtin.foldfunc },      click = 'v:lua.ScFa' },
                }
            })
        end
    },
}

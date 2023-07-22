return {
    { 'akinsho/bufferline.nvim',
        dependencies = {
            'DaikyXendo/nvim-material-icon',
        },
        config = function ()

            local util = require('util')
            local quboid = require('quboid')

            require("bufferline").setup({
                options = {
                    indicator = {
                        icon = " ",
                        style = "none",
                    },
                    buffer_close_icon   = quboid.icons.close,
                    modified_icon       = quboid.icons.pencil,
                    close_icon          = quboid.icons.close,
                    left_trunc_marker   = quboid.icons.arrowLeft,
                    right_trunc_marker  = quboid.icons.arrowRight,
                    --- name_formatter can be used to change the buffer's label in the bufferline.
                    --- Please note some names can/will break the
                    --- bufferline so use this at your discretion knowing that it has
                    --- some limitations that will *NOT* be fixed.
                    max_name_length = 14,
                    max_prefix_length = 13, -- prefix used when a buffer is de-duplicated
                    tab_size = 20,
                    diagnostics = "nvim_lsp",
                    diagnostics_update_in_insert = false,
                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        return "("..count..")"
                    end,
                    -- NOTE: this will be called a lot so don't do any heavy processing here
                    custom_filter = function(buf_number, buf_numbers)
                        -- filter out filetypes you don't want to see
                        if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
                            return true
                        end
                        -- filter out by buffer name
                        if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
                            return true
                        end
                        -- filter out based on arbitrary rules
                        -- e.g. filter out vim wiki buffer from tabline in your work repo
                        if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
                            return true
                        end
                        -- filter out by it's index number in list (don't show first buffer)
                        if buf_numbers[1] ~= buf_number then
                            return true
                        end
                    end,
                    offsets = {
                        {filetype = "neo-tree", text = "Neo Tree", highlight = "NvimTreeNormal", text_align = "center", padding = 0 },
                        {filetype = "NvimTree", text = "File Tree", highlight = "NvimTreeNormal", text_align = "center", padding = 0 },
                        {filetype = "Outline", text = "Symbol Outline", highlight = "NvimTreeNormal", text_align = "center", padding = 0 },
                    },
                    color_icons = true, -- whether or not to add the filetype icon highlights
                    show_buffer_icons = true, -- disable filetype icons for buffers
                    show_buffer_close_icons = true,
                    show_close_icon = false,
                    show_tab_indicators = false,
                    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
                    -- can also be a table containing 2 custom separators
                    -- [focused and unfocused]. eg: { '|', '|' }
                    separator_style = "thick",
                    enforce_regular_tabs = false,
                    always_show_bufferline = true,
                    sort_by = 'id',
                },
            })
        end,
        event = 'VeryLazy',
        keys = {
            { '<M-.>', '<cmd>BufferlineCycleNext<cr>', desc = 'Bufferline Cycle Next' },
            { '<M-,>', '<cmd>BufferlineCyclePrev<cr>', desc = 'Bufferline Cycle Prev' },
        },
    },
    { 'rcarriga/nvim-notify',
        config = function ()
            local quboid = require('quboid')
            local notify = require('notify')

            -- Overide default notification handler
            vim.notify = notify

            notify.setup({
                background_colour = 'NormalFloat',
                fps = 30,
                icons = {
                    INFO = quboid.icons.Info,
                    ERROR = quboid.icons.Error,
                    WARN = quboid.icons.Warn,
                    DEBUG = quboid.icons.Debug,
                    TRACE = quboid.icons.Trace,
                },
                level = 'info',
                render = 'default',
                stages = 'fade_in_slide_out',
                timeout = 3000, -- from 5000
                max_height = function()
                    return math.floor(vim.o.lines * 0.75)
                end,
                max_width = function()
                    return math.floor(vim.o.columns * 0.75)
                end,
                on_open = function(win)
                    vim.api.nvim_win_set_config(win, { border = quboid.border_float })
                end,
            })
        end,
        keys = {
            { '<leader>nd', function() require("notify").dismiss({ silent = true, pending = true }) end, desc = '[n]otification [d]ismiss' },
            { '<leader>nl', '<cmd>Notifications<cr>', desc = '[n]otification [l]ist' },
        },
    },
}

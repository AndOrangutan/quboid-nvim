return {
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

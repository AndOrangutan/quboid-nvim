return {
    { 'famiu/bufdelete.nvim',
        keys = {
            { '<C-q>', function () require('bufdelete').bufdelete(0) end, 'Save and Close Buffer' }
        },

    },
    { 'mrjones2014/smart-splits.nvim',
        opts = {
            ignore_buftypes = require('quboid').ft_rigid, -- TODO: Double check this
            hooks = {
                on_enter = function()
                    vim.notify('Entering resize mode')
                end,
                on_leave = function()
                    vim.notify('Exiting resize mode, bye')
                end,
            },

        },
        keys = {
            { '<C-A-h>', '<cmd>lua require("smart-splits").resize_left()<cr>', 'Resize Left' },
            { '<C-A-j>', '<cmd>lua require("smart-splits").resize_down()<cr>', 'Resize Down' },
            { '<C-A-k>', '<cmd>lua require("smart-splits").resize_up()<cr>', 'Resize Up' },
            { '<C-A-l>', '<cmd>lua require("smart-splits").resize_right()<cr>', 'Resize Right' },
            -- moving between splits
            { '<A-h>', '<cmd>lua require("smart-splits").move_cursor_left()<cr>', 'Move Left' },
            { '<A-j>', '<cmd>lua require("smart-splits").move_cursor_down()<cr>', 'Move Down' },
            { '<A-k>', '<cmd>lua require("smart-splits").move_cursor_up()<cr>', 'Move Up' },
            { '<A-l>', '<cmd>lua require("smart-splits").move_cursor_right()<cr>', 'Move Right' },
            -- swapping buffers between windows
            { '<A-H>', '<cmd>lua require("smart-splits").swap_buf_left()<cr>', 'Swap Left' },
            { '<A-J>', '<cmd>lua require("smart-splits").swap_buf_down()<cr>', 'Swap Down' },
            { '<A-K>', '<cmd>lua require("smart-splits").swap_buf_up()<cr>', 'Swap Up' },
            { '<A-L>', '<cmd>lua require("smart-splits").swap_buf_right()<cr>', 'Swap Right' },
        },
    },
}

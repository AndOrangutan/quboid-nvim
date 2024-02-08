return {
    {
        'famiu/bufdelete.nvim',
        keys = {
            { '<C-q>', function() require('bufdelete').bufdelete(0) end, desc = 'Save and Close Buffer, not buffer' }
        },

    },
    {
        'mrjones2014/smart-splits.nvim',
        opts = {
            ignore_filetypes = require('quboid.ft').ft_exclude,
            ignore_buftypes = require('quboid.ft').bt_exclude,
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
            { '<C-A-h>', '<cmd>lua require("smart-splits").resize_left()<cr>',       desc = 'Resize Left' },
            { '<C-A-j>', '<cmd>lua require("smart-splits").resize_down()<cr>',       desc = 'Resize Down' },
            { '<C-A-k>', '<cmd>lua require("smart-splits").resize_up()<cr>',         desc = 'Resize Up' },
            { '<C-A-l>', '<cmd>lua require("smart-splits").resize_right()<cr>',      desc = 'Resize Right' },
            -- moving between splits
            { '<A-h>',   '<cmd>lua require("smart-splits").move_cursor_left()<cr>',  desc = 'Move Left' },
            { '<A-j>',   '<cmd>lua require("smart-splits").move_cursor_down()<cr>',  desc = 'Move Down' },
            { '<A-k>',   '<cmd>lua require("smart-splits").move_cursor_up()<cr>',    desc = 'Move Up' },
            { '<A-l>',   '<cmd>lua require("smart-splits").move_cursor_right()<cr>', desc = 'Move Right' },
            -- swapping buffers between windows
            { '<A-H>',   '<cmd>lua require("smart-splits").swap_buf_left()<cr>',     desc = 'Swap Left' },
            { '<A-J>',   '<cmd>lua require("smart-splits").swap_buf_down()<cr>',     desc = 'Swap Down' },
            { '<A-K>',   '<cmd>lua require("smart-splits").swap_buf_up()<cr>',       desc = 'Swap Up' },
            { '<A-L>',   '<cmd>lua require("smart-splits").swap_buf_right()<cr>',    desc = 'Swap Right' },
        },
    },
}

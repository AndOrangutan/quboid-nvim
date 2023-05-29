return {
    { 'windwp/nvim-autopairs',
        config = function () require('configs.autopairs') end,
    },
    { 'NMAC427/guess-indent.nvim',
        config = function () require('guess-indent').setup({}) end,
    },
    { 'famiu/bufdelete.nvim',
        config = function () 
            require('util').keymap('n', '<C-q>', function ()
                require('bufdelete').bufdelete(0)
                --vim.api.nvim_command('write')
            end, 'Save and Close Buffer')
        end,
    },
}

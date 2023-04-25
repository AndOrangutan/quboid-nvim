return {
    { 'windwp/nvim-autopairs',
        config = function () require('configs.autopairs') end,
    },
    { 'NMAC427/guess-indent.nvim',
        config = function () require('guess-indent') end,
    },
    { 'famiu/bufdelete.nvim',
        config = function () 
            require('util').keymap('n', 'Q', function ()
                require('bufdelete').bufdelete(0)
            end, 'Save and Close Buffer')
        end,
    },
}

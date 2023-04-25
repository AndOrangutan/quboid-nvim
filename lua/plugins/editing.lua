return {
    { 'windwp/nvim-autopairs',
        config = function () require('configs.autopairs') end,
    },
    { 'NMAC427/guess-indent.nvim',
        config = function () require('guess-indent') end,
    },
}

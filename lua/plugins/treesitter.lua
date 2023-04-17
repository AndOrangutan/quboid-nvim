return {
    { 'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'RRethy/nvim-treesitter-endwise',
        },
        config = function () require('configs.treesitter') end,
        build = ':TSUpdate',
    },
}

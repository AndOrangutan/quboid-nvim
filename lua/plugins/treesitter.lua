return {
    { 'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'RRethy/nvim-treesitter-endwise',
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
        config = function () require('configs.treesitter') end,
        build = ':TSUpdate',
    },
}

return {
    { 'nvim-treesitter/nvim-treesitter',
        dependencies = {
        },
        config = function () require('configs.treesitter') end,
        build = ':TSUpdate',
    },
}

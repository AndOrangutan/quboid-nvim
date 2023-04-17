return {
    { 'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason-lspconfig.nvim',
                dependencies = 'williamboman/mason.nvim',
            },
        },
        config = function () require('configs.lspconfig') end,
        event = 'BufRead',
    },
}

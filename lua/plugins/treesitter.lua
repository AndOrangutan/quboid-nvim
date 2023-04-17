return {
    { 'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-context',
            'RRethy/nvim-treesitter-endwise',
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
        config = function () require('configs.treesitter') end,
        build = ':TSUpdate',
    },
    { 'kylechui/nvim-surround',
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    }
}

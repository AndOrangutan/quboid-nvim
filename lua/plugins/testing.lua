return {
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter'
        },
        config = function()
            require('neotest').setup({
                -- https://github.com/nvim-neotest/neotest?tab=readme-ov-file#supported-runners
                adapters = {
                },
            })
        end,
    }
}

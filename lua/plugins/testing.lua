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
                consumers = {
                    overseer = require('neotest.consumers.overseer'),
                },
            })
        end,
        keys = {
            {
                '<leader>trn',
                '<cmd>lua require("neotest").run.run()<cr>',
                desc =
                'Neo[t]est [r]un [n]earest'
            },
            {
                '<leader>tr%',
                '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>',
                desc =
                'Neo[t]est [r]un [c]ur. File'
            },
            {
                '<leader>trd',
                '<cmd>lua require("neotest").run.run({strategy = "dap"})<cr>',
                desc =
                'Neo[t]est [r]un [c]ur. File'
            },
            {
                '<leader>tt',
                '<cmd>lua require("neotest").run.stop()<cr>',
                desc =
                'Neo[t]est [s]top Nearest'
            },
            {
                '<leader>ta',
                '<cmd>lua require("neotest").run.attach()<cr>',
                desc =
                'Neo[t]est [a]ttach Nearest'
            },
        },
    }
}

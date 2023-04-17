local util = require('util')

return {
    { 'kylechui/nvim-surround',
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    { 'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-context',
            'RRethy/nvim-treesitter-endwise',
            'windwp/nvim-ts-autotag',
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
        config = function () require('configs.treesitter') end,
        build = ':TSUpdate',
    },
    { 'ckolkey/ts-node-action',
        dependencies = { 'nvim-treesitter' },
        opts = {},
        event = "VeryLazy",
        config = function ()
            local null_ls_ok, null_ls = pcall(require, 'null-ls')
            -- local ts_node_action = require('ts-node-action')
            util.keymap('n', '<leader>na', require("ts-node-action").node_action, 'TS Node Action')


            if null_ls_ok then
                null_ls.register({ name = 'more_actions', method = { require'null-ls'.methods.CODE_ACTION }, filetypes = { '_all' }, generator = { fn = require('ts-node-action').available_actions } })
            end
        end
    },
}

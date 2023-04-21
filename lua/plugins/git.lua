local util = require('util')

return {
    { 'sindrets/diffview.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    { 'akinsho/git-conflict.nvim',
        config = true,
        event = 'BufRead',
        version = '*',
    },
    { 'ThePrimeagen/git-worktree.nvim', 
        config = function () require('configs.git-worktree') end,
    },
    { 'lewis6991/gitsigns.nvim',
        config = function () require('gitsigns').setup() end,
        event = { "BufReadPre", "BufNewFile" },
    },
    { 'TimUntersberger/neogit',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function () 
            require('neogit').setup({
                integrations = { diffview = true },
            })
            util.keymap('n', '<leader>gg', '<cmd>Neogit<cr>', 'Neo[g]it Toggle [g]oodness')
        end,
    },
}

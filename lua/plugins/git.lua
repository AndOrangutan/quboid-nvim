return {
    { 'sindrets/diffview.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = {
            'DiffviewOpen',
            'DiffviewToggle',
        },
        event = 'VeryLazy',
        keys = {
            { '<leader>gd', function () require('util').toggle_cmd('DiffviewOpen', 'DiffviewClose') end, desc = '[d]iffview Toggle' },
        }
    },
    { 'tpope/vim-fugitive' },
    { 'lewis6991/gitsigns.nvim',
        config = true,
        event = { "BufReadPre", "BufNewFile" },
    },
}

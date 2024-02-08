return {
    {
        'sindrets/diffview.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = {
            'DiffviewOpen',
            'DiffviewToggle',
        },
        event = { 'BufReadPre', 'BufNewFile' },
        keys = {
            {
                '<leader>gd',
                function() require('quboid.util').toggle_cmd('DiffviewOpen', 'DiffviewClose') end,
                desc = '[d]iffview Toggle',
            },
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        keys = {
            { '<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<cr>', desc = '[g]it [b]lame toggle' },
        },
        config = true,
    },
}

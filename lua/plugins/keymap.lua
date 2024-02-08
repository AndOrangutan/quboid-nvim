return {
    {
        'folke/which-key.nvim',
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            local wk = require('which-key')
            wk.setup()
            wk.register({
                ['<leader>s'] = { name = 'Sessions' },
                ['<leader>m'] = { name = 'Mini Lib (Map)' },
                ['<leader>w'] = { name = 'Open [w]indow Options' },
                ['<leader>n'] = { name = 'Navigation' },
                ['<leader>p'] = { name = 'Picker' },
                ['<leader>ts'] = { name = 'Treesitter' },
            })
        end,
        keys = {
            { '<leader>' },
        },
        event = 'VeryLazy',
    },
}

return { 
    { 'folke/which-key.nvim',
        config = function ()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require('which-key').setup()
        end
    },
    { 'mrjones2014/legendary.nvim',
        config = function () require('configs.legendary') end,
        dependencies = {
            'kkharji/sqlite.lua',
            'folke/which-key.nvim',
        },
    },
}

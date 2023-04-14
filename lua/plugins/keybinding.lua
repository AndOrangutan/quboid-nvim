return { 
    { 'folke/which-key.nvim',
        config = function ()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            local wk = require("which-key")
            wk.setup()
            wk.register()
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

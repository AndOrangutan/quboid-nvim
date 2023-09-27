return {
    { 'danymat/neogen',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        config = function()
            local neogen = require('neogen')
           neogen.setup({ input_after_comment = true,
                snippet_engine = 'luasnip',
            })
        end,
        cmd = { 'Neogen' },
        keys = {
            { 'gcd', function () require('neogen').generate() end, desc = '[g]enerate [c]omment [d]ocumentaiton' },
        },
    },
}

return {
    { 'danymat/neogen',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        config = function()
            local neogen = require('neogen')
            require('neogen').setup({})
            neogen.setup({ snippet_engine = 'luasnip' })
        end,
    },
}

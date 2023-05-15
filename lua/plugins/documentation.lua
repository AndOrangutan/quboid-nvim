
local util = require('util')
return {
    { 'danymat/neogen',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        config = function()
            local neogen = require('neogen')
            require('neogen').setup({ input_after_comment = true })
            neogen.setup({ snippet_engine = 'luasnip' })
            util.keymap('n', 'gcd', function () require('neogen').generate() end, '[c]omment [d]ocumentation')
        end,
    },
}

local quboid = require('quboid')
local util = require('util')

return {
    { 'norcalli/nvim-colorizer.lua',
        config = function ()
            util.keymap('n', '<leader>cc', '<cmd>ColorizerToggle<cr>', '[c]olorize [c]urrent buffer')
        end,
    },
    { 'nvim-colortils/colortils.nvim',
        config = function()
            require("colortils").setup({
                border = quboid.border,
            })
            util.keymap('n', '<leader>cu', '<cmd>Colortils<cr>', '[c]olor [u]til Toggle')
        end,
        -- cmd = 'Colortils',

    }
}

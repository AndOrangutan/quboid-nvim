local util = require('util')

require('legendary').setup({
    which_key = {
        auto_register = true,
    },
    extensions = {
        -- TODO: Determine and enable extensions for lengendary.nvim
        smart_splits = false,
        op_nvim = false,
        diffview = false,
    },
})

util.keymap('n', '<leader>fl', '<cmd>Legendary<cr>', '[f]uzzy keybind [l]egend')
        

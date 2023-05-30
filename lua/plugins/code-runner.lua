local util = require('util')
-- vim.g["codi#virtual_text"] = 0 
return {
    { 'metakirby5/codi.vim',
        config = function () util.keymap('n', '<leader>cs', '<cmd>codi!<cr>', '[c]odi [s]crachpad') end,
    },
    { 'michaelb/sniprun',
        config = function () 
            require('sniprun').setup({
                display = { 'NvimNotify' },
                display_options = {
                    notification_timeout = 5000,
                },
            }) 
            util.keymap('n', '<leader>cr', '<cmd>SnipRun<cr>', '[c]odi [s]crachpad')
        end,
        build = 'bash ./install.sh',
    }
}

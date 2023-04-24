local util = require('util')

require("femaco").setup({
    border = vim.g.quboid_border,
    prepare_buffer = function(opts)
        vim.cmd('split')
        local win = vim.api.nvim_get_current_win()
        local buf = vim.api.nvim_create_buf(false, false)
        return vim.api.nvim_win_set_buf(win, buf)
    end,
    post_open_float = function(winnr)
        -- vim.wo.signcolumn = 'no'
        vim.wo.winhighlight = "Nomral:NormalFloat"

    end
})

util.keymap('n', '<leader>o', '<cmd>FeMaco<cr>', 'FeMaco [o]pen Codeblock')



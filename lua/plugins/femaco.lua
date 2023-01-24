local wk = require('which-key')

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

wk.register({
    ['<leader>e'] = { '<cmd>FeMaco<cr>', 'Femaco [e]dit Code'}
})



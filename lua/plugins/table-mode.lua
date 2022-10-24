
vim.g.table_mode_corner = '|'

vim.g.vim_table_mode_enabled = false


local wk = require("which-key")


wk.register({
    ["<leader><bar><bar>"] = { function ()
        if vim.g.vim_table_mode_enabled == false then
            vim.g.vim_table_mode_enabled = true
            vim.cmd[[TableModeEnable]]
            vim.notify('Table Mode Enabled')
        elseif vim.g.vim_table_mode_enabled == true then
            vim.g.vim_table_mode_enabled = false
            vim.cmd[[TableModeDisable]]
            vim.notify('Table Mode Disabled')
        end

    end,
    "Table Mode Toggle" }
})

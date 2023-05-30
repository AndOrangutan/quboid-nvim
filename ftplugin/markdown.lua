
vim.opt_local.wrap = true
vim.opt_local.spell = false
vim.opt_local.linebreak = true

-- require("lsp_lines").toggle()
vim.diagnostic.config({ virtual_lines = false })

vim.api.nvim_create_autocmd("TextChanged", {
    pattern = "*",
    callback = function()
        vim.cmd.normal({require('autolist').force_recalculate(nil, nil), bang = false})
    end
})

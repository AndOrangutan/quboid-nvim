
vim.opt_local.wrap = true
vim.opt_local.spell = false
vim.opt_local.linebreak = true

-- require("lsp_lines").toggle()
vim.diagnostic.config({
    update_in_insert = true,
    virtual_lines = false,
    underline = true
})


vim.o.textwidth = 0
vim.opt_local.wrap = true
vim.opt_local.spell = false
vim.opt_local.linebreak = true

vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

vim.keymap.set('n', 'gj', 'j')
vim.keymap.set('n', 'gk', 'k')

-- require("lsp_lines").toggle()
vim.diagnostic.config({
    update_in_insert = true,
    virtual_lines = false,
    underline = true
})

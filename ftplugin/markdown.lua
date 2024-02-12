vim.opt_local.textwidth = 80
vim.opt_local.wrap = false
vim.opt_local.spell = false
vim.opt_local.linebreak = true
vim.opt_local.comments = 'fb:>,fb:*,fb:+,fb:-,fb::'
vim.opt_local.formatoptions = 'tacqwn'

vim.keymap.set('n', '<cr>', function() vim.lsp.buf.definition() end, { desc = 'Zk Follow note' })

-- vim.keymap.set('n', 'j', 'gj')
-- vim.keymap.set('n', 'k', 'gk')
--
-- vim.keymap.set('n', 'gj', 'j')
-- vim.keymap.set('n', 'gk', 'k')

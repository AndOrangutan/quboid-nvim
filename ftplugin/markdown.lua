local util = require('util')

vim.opt_local.wrap = true
vim.opt_local.linebreak = true


util.keymap('n', 'j', 'gj', 'Markdown Wrap-friendly [j]ump')
util.keymap('n', 'k', 'gk', 'Markdown Wrap-friendly [k]ick')
util.keymap('n', 'gj', 'j', 'Markdown Normal [k]ick')
util.keymap('n', 'gk', 'k', 'Markdown Normal [k]ick')

--local wk = require('which-key')

vim.opt_local.wrap = true
vim.opt_local.linebreak = true
--
--wk.register({
--    ['j'] = { 'gj', '.md Intuitive [j]ump' },
--    ['k'] = { 'gk', '.md Intuitive [k]ick' },
--    ['jg'] = { 'j', '.md Normal [j]ump' },
--    ['kg'] = { 'k', '.md Normal [k]ick' },
--})

vim.cmd[[
    noremap j gj
    noremap k gk
    noremap gj j
    noremap gk k
]]

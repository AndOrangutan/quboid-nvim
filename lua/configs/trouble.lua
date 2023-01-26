

local util = require('util')

local wk_ok, wk = pcall(require, 'which-key')

require('trouble').setup()

util.keymap('n', '<leader>xx', '<cmd>TroubleToggle<cr>', 'Trouble Toggle E[x]plorer E[x]tensive (workspace)')
util.keymap('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', 'Trouble E[x]plore [w]orkspace Diagnostics')
-- TODO: Look into quickfix and loclist
util.keymap('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>', 'Trouble E[x]plore [q]uickfix Diagnostics')
util.keymap('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>', 'Trouble E[x]plore [l]oclist Diagnostics')

if wk_ok then
    wk.register({
        ["<leader>x"] = { name = "Trouble E[x]plore Diagnostics" },
    },{})
end

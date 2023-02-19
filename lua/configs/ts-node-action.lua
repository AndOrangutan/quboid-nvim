local util = require('util')

local null_ls_ok, null_ls = pcall(require, 'null-ls')
local ts_node_action = require('ts-node-action')

util.keymap('n', '<leader>na', require("ts-node-action").node_action, 'TS Node Action')

-- null_ls.register({
--     name = 'more_actions',
--     method = { null_ls.method.CODE_ACTION },
--     filetype = { '_all' },
--     generator = {
--         fn = ts_node_action.available_actions,
--     },
-- })

require "null-ls".register({
    name = 'more_actions',
    method = { require'null-ls'.methods.CODE_ACTION },
    filetypes = { '_all' },
    generator = { fn = require('ts-node-action').available_actions }
})

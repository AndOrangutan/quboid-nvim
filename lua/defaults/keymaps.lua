local util = require('util')

local bufdelete_ok, bufdelete = pcall(require, 'bufdelete')

-- util.keymap('n', 'p', 'p=`]', '[p]aste and auto format')

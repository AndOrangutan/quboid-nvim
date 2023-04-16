-- Stage 0 - Oh wait this is lua

-- Stage 1 - Load lua defualts and global settings

require('quboid')

require('defaults.options')
require('defaults.autocmds')
require('defaults.keymaps')
-- require("defaults.mouse")

-- Stage 2 - Load plugins
require('plugin-management')      -- Load plugin manager

-- Stage 3 - Load plugin dependent files

-- colorscheme and highlights
require('highlights')

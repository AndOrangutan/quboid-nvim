local quboid = require('quboid')

return {
    { 'barrett-ruth/import-cost.nvim',                          -- Display javascript import costs inside of neovim 
        -- TODO: Extract javascript package manager
        build = 'sh install.sh '..quboid.quboid_ft_javascript_package_manager,
        config = function() require('import-cost').setup() end,
    },
    { 'jose-elias-alvarez/typescript.nvim',                     --  A Lua plugin, written in TypeScript, to write TypeScript (Lua optional). 
        config = function () require('configs.typescript') end,
    }
}

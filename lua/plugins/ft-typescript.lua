local quboid = require('quboid')

return {
    { 'barrett-ruth/import-cost.nvim',                          -- Display javascript import costs inside of neovim 
        -- TODO: Extract javascript package manager
        build = 'sh install.sh '..quboid.ft_javascript_package_manager,
        config = function() require('import-cost').setup() end,
    },
    { 'jose-elias-alvarez/typescript.nvim',                     --  A Lua plugin, written in TypeScript, to write TypeScript (Lua optional). 
        dependencies = {
            'ray-x/lsp_signature.nvim',
        },
        config = function() require("configs.typescript") end,
    },
}

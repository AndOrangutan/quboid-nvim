local quboid = require('quboid')

return {
    { 'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason-lspconfig.nvim',
                dependencies = 'williamboman/mason.nvim',
            },
            { 'rmagatti/goto-preview',
                config = function () 
                    require('goto-preview').setup({
                        border = quboid.border
                    })
                end
            },
        },
        config = function () require('configs.lspconfig') end,
        event = 'BufRead',
    },
}

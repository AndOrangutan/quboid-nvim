local quboid = require('quboid')

return {
    { 'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason-lspconfig.nvim',
                dependencies = 'williamboman/mason.nvim',
            },
            { "weilbith/nvim-code-action-menu",
                cmd = "CodeActionMenu",
                config = function() vim.g.code_action_menu_window_border = quboid.quboid_border vim.g.code_action_menu_show_details = false end,
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

local quboid = require('quboid')

return {
    { 'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
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
            { url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
                config = function() require('lsp_lines').setup() end,
            },
            { 'ray-x/lsp_signature.nvim', 
                -- config = function() require('lsp_signature').setup() end,
            },
            'SmiteshP/nvim-navic',
        },
        config = function () require('configs.lspconfig') end,
        event = 'BufRead',
    },
    { 'utilyre/barbecue.nvim',
        dependencies = {
            'SmiteshP/nvim-navic',
            'DaikyXendo/nvim-material-icon',
        },
        config = function () require('configs.barbecue') end,
        name = 'barbecue',
        version = '*',
    },
    { 'RRethy/vim-illuminate',
        event = 'BufRead',
        config = function() require('illuminate').configure() end,
    },
    { 'jose-elias-alvarez/null-ls.nvim',
        dependencies = {
            'jay-babu/mason-null-ls.nvim',
            'ckolkey/ts-node-action',
        },
        config = function () require('configs.null-ls') end,
    },
}

local quboid = require('quboid')
return {
    { 'neovim/nvim-lspconfig',                          -- Quickstart configurations for the Neovim LSP client.
        dependencies = {    -- deps for lspconfig and lsp-util
            'williamboman/mason-lspconfig',                 -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim. Strongly recommended for Windows users. 
            { 'SmiteshP/nvim-navic',
            },
            { 'folke/neodev.nvim' },
            { 'ray-x/lsp_signature.nvim',                   -- LSP signature hint as you type 
                -- needs bufnr to toggle
                -- config = function() require('configs.lsp-signature').setup() end,
            },
            { "weilbith/nvim-code-action-menu",             -- A floating pop-up menu for code actions to show code action information and a diff preview.
                cmd = "CodeActionMenu",
                config = function() quboid.code_action_menu_window_border = quboid.quboid_border quboid.code_action_menu_show_details = false end,
            },
            { url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim', -- lsp_lines is a simple neovim plugin that renders diagnostics using virtual lines on top of the real line of code.
                config = function() require('lsp_lines').setup() end,
            },
            { 'rmagatti/goto-preview',                      -- A small Neovim plugin for previewing definitions using floating windows. 
                config = function () require('configs.goto-preview') end
            },
        },
        event = 'BufRead',
        config = function () require('configs.lspconfig') end,
    },
    { 'jose-elias-alvarez/null-ls.nvim',                -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua. 
        dependencies = {
            'jose-elias-alvarez/null-ls.nvim',
            'ckolkey/ts-node-action',
        },
        config = function () require('configs.null-ls') end,
    },
    { 'utilyre/barbecue.nvim',                          -- A VS Code like winbar for Neovim ,
        config = function () require('configs.barbecue') end,
        dependencies = {
            { 'SmiteshP/nvim-navic', 
                -- config = function () require('configs.navic') end,
            },
            'DaikyXendo/nvim-material-icon',
            'neovim/nvim-lspconfig',
        },
    },
    { 'RRethy/vim-illuminate',                          -- (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching.
        event = 'BufRead',
        config = function() require('illuminate').configure() end,
    },
}

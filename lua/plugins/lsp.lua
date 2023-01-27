return {
    { 'neovim/nvim-lspconfig',                          -- Quickstart configurations for the Neovim LSP client.
        dependencies = {
            'williamboman/mason-lspconfig',                 -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim. Strongly recommended for Windows users. 
            'ray-x/lsp_signature.nvim',                     -- LSP signature hint as you type 
            'smjonas/inc-rename.nvim',                      -- Incremental LSP renaming based on Neovim's command-preview feature.
        },
        event = 'BufRead',
        config = function () require('configs.lspconfig') end,
    },
    { "weilbith/nvim-code-action-menu",                 -- A floating pop-up menu for code actions to show code action information and a diff preview.
        cmd = "CodeActionMenu",
        config = function() vim.g.code_action_menu_window_border = vim.g.quboid_border vim.g.code_action_menu_show_details = false end,
    },
    --use { "kosayoda/nvim-lightbulb",
    --    event = "BufRead",
    --    requires = "antoinemadec/FixCursorHold.nvim",
    --    config = function() require("configs.lightbulb") end,
    --}
    { 'RRethy/vim-illuminate',                          -- (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching.
        event = 'BufRead',
        config = function() require('illuminate').configure() end,
    },
}

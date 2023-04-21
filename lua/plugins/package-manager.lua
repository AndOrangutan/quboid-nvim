return {
    { 'williamboman/mason.nvim',
        config = function() require('mason').setup({
            ui = {
                icons = {
                    -- TODO: Extract icons to quboid.lua
                    package_installed   = "✓",
                    package_pending     = "➜",
                    package_uninstalled = "✗"
                },
            },
        }) end,
        event = 'BufRead',
    },
    { 'williamboman/mason-lspconfig.nvim',              -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
        dependencies = 'williamboman/mason.nvim',
        event = 'BufRead',
        config = function() require('configs.mason-lspconfig') end,
    },
}

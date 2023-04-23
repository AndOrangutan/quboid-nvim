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
    { 'williamboman/mason-lspconfig.nvim',
        dependencies = 'williamboman/mason.nvim',
        event = 'BufRead',
        config = function() require('configs.mason-lspconfig') end,
    },
    { 'jay-babu/mason-nvim-dap.nvim',
        dependencies = 'williamboman/mason.nvim',
        config = function() 
            require ('mason-nvim-dap').setup({
                ensure_installed = {
                    -- TODO: Add list here for dap
                },
        }) end,
        event = 'BufRead',
    },
}

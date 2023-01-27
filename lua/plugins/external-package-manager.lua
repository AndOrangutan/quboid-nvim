return {
    { 'williamboman/mason.nvim',                        -- Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.
        event = 'BufRead',
        config = function() require('configs.mason') end,
    },
    { 'williamboman/mason-lspconfig.nvim',              -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
        dependencies = 'williamboman/mason.nvim',
        event = 'BufRead',
        config = function() require('configs.mason-lspconfig') end,
    },
}

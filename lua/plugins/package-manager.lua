return {
    {
        'williamboman/mason.nvim',
        -- event = 'VeryLazy',
        opts = {
            registries = {
                "github:nvim-java/mason-registry",
                "github:mason-org/mason-registry",
            },
            ui = {
                border = require('quboid').border_float,
                icons = {
                    package_installed   = require('quboid.icons').gen.check,
                    package_pending     = require('quboid.icons').gen.arrow_right,
                    package_uninstalled = require('quboid.icons').gen.close,
                },
            },
            log_level = vim.log.levels.INFO,
            max_concurrent_installers = 4,
        }
    }
}

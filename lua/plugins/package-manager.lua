return {
    {
        'williamboman/mason.nvim',
        event = 'VeryLazy',
        config = function()
            local quboid = require('quboid')
            local icons = require('quboid.icons')

            require('mason').setup({
                registries = {
                    'github:nvim-java/mason-registry',
                    'github:mason-org/mason-registry',
                },
                ui = {
                    border = quboid.border_float,
                    icons = {
                        package_installed   = icons.gen.check,
                        package_pending     = icons.gen.arrow_right,
                        package_uninstalled = icons.gen.close,
                    },
                },
                log_level = vim.log.levels.INFO,
                max_concurrent_installers = 4,
            })
        end,
    },
}

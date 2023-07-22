return {

    { 'williamboman/mason.nvim',
        config = function() 
            local quboid = require('quboid')

            require('mason').setup({
                ui = {
                    border = quboid.border_float,
                        icons = {
                            package_installed   = quboid.icons.check,
                            package_pending     = quboid.icons.arrow_right,
                            package_uninstalled = quboid.icons.close,
                        },
                },
                log_level = vim.log.levels.INFO,
                max_concurrent_installers = 4,
        }) end,
        event = 'VeryLazy',
    },
}

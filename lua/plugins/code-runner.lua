return {
    { 'michaelb/sniprun',
        opts = {
            display = { 'NvimNotify' },
            display_options = {
                notification_timeout = 5000,
            },
        },
        keys = {
            { '<leader>cr', '<cmd>SnipRun<Cr>', desc = '[c]ode [r]unner' },
        },
        build = 'bash ./install.sh',
    },
}

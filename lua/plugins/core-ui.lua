local quboid = require('quboid')
return {
    { 'akinsho/bufferline.nvim',
        dependencies = {
            'DaikyXendo/nvim-material-icon',
        },
        config = function () require('configs.bufferline') end,
    },
    { 'nvim-lualine/lualine.nvim',
        dependencies = {
            'DaikyXendo/nvim-material-icon',
            'linrongbin16/lsp-progress.nvim'
        },
        config = function () require('configs.lualine') end,
        event = { 'VimEnter' },
    },

    { 'linrongbin16/lsp-progress.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'DaikyXendo/nvim-material-icon',
        },
        config = function () require('configs.lsp-progress') end,
        event = { 'VimEnter' },
    },
    { 'rcarriga/nvim-notify',
        config = function () require('configs.notify') end,
    },
    { 'kevinhwang91/nvim-ufo',
        dependencies = {
            'kevinhwang91/promise-async',
        },
        config = function () require('configs.ufo') end,
    },
}

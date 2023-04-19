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
        },
        config = function () require('configs.lualine') end,
    },
    { 'rcarriga/nvim-notify',
        config = function () require('configs.notify') end,
    },
    { 'nvim-neo-tree/neo-tree.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'DaikyXendo/nvim-material-icon',
            'MunifTanjim/nui.nvim',
        },
        config = function () require('configs.neo-tree') end,
    },
}

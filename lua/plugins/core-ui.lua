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
    { 'nvim-neo-tree/neo-tree.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'DaikyXendo/nvim-material-icon',
            'MunifTanjim/nui.nvim',
        },
        config = function () require('configs.neo-tree') end,
    },

    { 'folke/trouble.nvim',
        dependencies = { 
            'DaikyXendo/nvim-material-icon',
            { 'folke/todo-comments.nvim',
                config = function () require('configs.todo-comments') end,
            }
        },
        event = 'VimEnter',
        config = function() require('configs.trouble') end,
    },
}

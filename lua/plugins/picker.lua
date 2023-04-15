return {
    { 'stevearc/dressing.nvim',
        config = function () require('configs.dressing') end,
        lazy = true,
    },
    { 'ibhagwan/fzf-lua',
        dependencies = {
            'DaikyXendo/nvim-material-icon',
        },
        config = function () require('configs.fzf-lua') end,
        event = { 'BufReadPre', 'BufNewFile' },
    }
}

return {
    { 'stevearc/dressing.nvim',                         -- Neovim plugin to improve the default vim.ui interfaces
        event = 'VimEnter',
        config = function () require('configs.dressing') end,
    },
    { 'rcarriga/nvim-notify',                           -- A fancy, configurable, notification manager for Neovim.
        event = 'VimEnter',
        config = function() require('configs.notify') end,
    },
    -- TODO: Convert to https://github.com/rebelot/heirline.nvim
    { 'nvim-lualine/lualine.nvim',                      -- A blazing fast and easy to configure Neovim statusline.
        dependencies = {
            'WhoIsSethDaniel/lualine-lsp-progress',
            'DaikyXendo/nvim-material-icon',
        },
        config = function() require('configs.lualine') end
    },
    { 'akinsho/bufferline.nvim',                        --  A snazzy bufferline for Neovim 
        config = function () require('configs.bufferline') end,
    },
    { 'ibhagwan/fzf-lua',                               -- Improved fzf.vim written in lua
        dependencies = { 'DaikyXendo/nvim-material-icon' },
        --event = 'VimEnter',
        config = function() require('configs.fzf-lua') end,
    },
    { 'm4xshen/smartcolumn.nvim',                       -- A Neovim plugin hiding your colorcolumn when unneeded.
        config = function() require('configs.smartcolumn') end,

    }
}

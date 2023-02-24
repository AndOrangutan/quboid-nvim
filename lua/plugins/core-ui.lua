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
            'DaikyXendo/nvim-material-icon',
            { 'linrongbin16/lsp-progress.nvim',
                branch = 'main',
                event = { 'VimEnter' },
                dependencies = {
                    'nvim-tree/nvim-web-devicons',
                },
                config = function() require('configs.lsp-progress') end 
            }
        },
        config = function() require('configs.lualine') end,
        event = { 'VimEnter' },
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

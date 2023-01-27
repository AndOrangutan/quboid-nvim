return {
    { "goolord/alpha-nvim",                             -- A lua powered greeter like vim-startify / dashboard-nvim.
        -- TODO: Fix yucky config
        config = function() require("configs.alpha") end,
    },
    { 'nvim-neo-tree/neo-tree.nvim',                    -- Neovim plugin to manage the file system and other tree like structures. 
        dependencies = {
            'nvim-lua/plenary.nvim',
            'DaikyXendo/nvim-material-icon',
            'MunifTanjim/nui.nvim',
        },
        -- cmd = 'Neotree',
        branch = 'v2.x',
        config = function () require('configs.neo-tree') end,
    },
    -- TODO: Add todo https://github.com/folke/todo-comments.nvim
    { 'folke/trouble.nvim',                             -- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
        dependencies = { 
            'DaikyXendo/nvim-material-icon',
            { 'folke/todo-comments.nvim',
                config = function () require('configs.todo-comments') end,
            }
        },
        event = 'VimEnter',
        config = function() require('configs.trouble') end,
    },
    -- TODO: Once over config
    { 'simrat39/symbols-outline.nvim',                  -- A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favourite languages.
        dependencies = { 'DaikyXendo/nvim-material-icon' },
        cmd = 'SymbolsOutline',
        config = function () require('configs.symbols-outline') end,
    },
}

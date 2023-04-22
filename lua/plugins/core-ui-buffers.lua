local util = require('util')
return {
    { 'nvim-neo-tree/neo-tree.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'DaikyXendo/nvim-material-icon',
            'MunifTanjim/nui.nvim',
        },
        config = function () require('configs.neo-tree') end,
    },
    { 'simrat39/symbols-outline.nvim',                  -- A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favourite languages.
        dependencies = { 'DaikyXendo/nvim-material-icon' },
        config = function()
            require('symbols-outline').setup({
                auto_close = true,
                relative_width = false,
                width  = 40,
                show_guides = false,
            })
            util.keymap('n', '<leader>bs', '<cmd>SymbolsOutline<cr>', '[b]uffer [s]symbol Outline Toggle')
            vim.cmd[[autocmd FileType Outline setlocal signcolumn=no]]
        end,
        -- cmd = 'SymbolsOutline',
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
    { 'mbbill/undotree',
        -- cmd = 'UndotreeToggle',
        config = function()
            vim.g.undotree_SplitWidth = 40

            util.keymap('n', '<leader>bu', '<cmd>UndotreeToggle<cr>', '[b]uffer [u]ndotree toggle')
        end;
    }
}

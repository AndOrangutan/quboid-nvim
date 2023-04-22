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
        cmd = 'UndotreeToggle',
        config = function()
            vim.g.undotree_SplitWidth = 40

            util.keymap('n', '<leader>uu', '<cmd>UndotreeToggle<cr>', '[u]ndo tree toggle')
        end;
    }
}

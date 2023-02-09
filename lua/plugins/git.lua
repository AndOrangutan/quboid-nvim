return {
    { 'lewis6991/gitsigns.nvim',                        -- Git integration: signs, hunk actions, blame, etc.
        config = function() require("configs.gitsigns") end,
        event = 'BufRead',
        --after = 'nvim-lua/plenary.nvim',
    },
    { 'TimUntersberger/neogit',                         -- A Magit clone for Neovim that may change some things to fit the Vim philosophy.
        dependencies = 'nvim-lua/plenary.nvim',
        config = function() require('configs.neogit') end,
        event = 'VimEnter',
    },
    -- TODO: Add/config diffview
    { 'sindrets/diffview.nvim',                         -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
        config = function() require('configs.diffview') end,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'DaikyXendo/nvim-material-icon',
        },
        event = 'BufRead',
    },
    { 'akinsho/git-conflict.nvim',                      -- A plugin to visualise and resolve merge conflicts in neovim.
        config = true,
        event = 'BufRead',
        version = '*',
    },
}

return {
    { 'nvim-treesitter/nvim-treesitter',                -- Neovim Treesitter configurations and abstraction layer.
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',  -- Create your own textobjects using tree-sitter queries.
            'RRethy/nvim-treesitter-endwise',               -- Wisely add "end" in Ruby, Vimscript, Lua, etc. Tree-sitter aware alternative to tpope's vim-endwise.
            'JoosepAlviste/nvim-ts-context-commentstring',  -- Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
            { 'nvim-treesitter/playground',                 --Treesitter playground integrated into Neovim
                cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' }
            },
        },
        build = ':TSUpdate',
        config = function() require('configs.nvim-treesitter') end,
    },
    { 'nvim-treesitter/nvim-treesitter-context',        -- Shows floating hover with the current function/block context.
        event = 'VimEnter',
    },
    { 'kylechui/nvim-surround',                         -- Add/change/delete surrounding delimiter pairs with ease. Written with heart in Lua. 
        version = '*',
        config = true,
    },
    { 'windwp/nvim-ts-autotag',                         -- Use treesitter to auto close and auto rename html tags.
        config = true,
    },
}

return {
    -- TODO: Rewrite zk config
    { 'mickael-menu/zk-nvim',                           -- Neovim extension for zk 
        -- TODO: Fix ft lazyload for md stuffs
        --ft = 'markdown',
        config = function () require('configs.zk') end,
        dependencies = {
            'junegunn/fzf',
        },
    },
    { 'prncss-xyz/neo-tree-zk.nvim',                    -- neo-tree source for zk-nvim 
        requires = {
            'nvim-neo-tree/neo-tree.nvim',
            'mickael-menu/zk-nvim'
        }
    },
    { 'lukas-reineke/headlines.nvim',                   -- This plugin add horizontal highlights for text filetypes, like markdown, orgmode, and neorg.
        ft =  'markdown',
        config = function ()  require('configs.headlines') end,
    },
    { 'preservim/vim-markdown',                         -- Markdown Vim Mode
        ft = 'markdown',
        init = function () require('configs.vim-markdown') end,
    },
    -- TODO: Maybe replace with peek.nvim
    { 'iamcco/markdown-preview.nvim',                   -- Markdown preview plugin for (neo)vim
        ft = 'markdown',
        build = function () vim.fn['mkdp#util#install']() end,
        init = function () require('configs.markdown-preview') end,
    },
    { 'ekickx/clipboard-image.nvim',                    -- Neovim Lua plugin to paste image from clipboard. 
        ft = 'markdown',
        config = function () require('configs.clipboard-image') end,
    },
    { 'gaoDean/autolist.nvim',                          -- Automatic list continuation and formatting for neovim, powered by lua 
        ft = { 'markdown', 'text', 'gitcommit', 'scatch' },
        config = function () require('configs.autolist') end
    },
    --    { 'jbyuki/nabla.nvim' }
    { 'AckslD/nvim-FeMaco.lua',                         -- Catalyze your Fenced Markdown Code-block editing!
        ft = 'markdown',
        config = function () require('configs.femaco') end,
    },
    -- TODO: Setup Table mode and add nice toggle util
    -- { 'dhruvasagar/vim-table-mode',                     -- VIM Table Mode for instant table creation. 
    --     ft = 'markdown',
    --     config = function () require('configs.table-mode') end,
    -- },
    { 'NFrid/due.nvim',                                 -- Neovim plugin for displaying due dates
        ft = 'markdown',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        config = function() require('configs.due') end,
    },
    { "andrewferrier/wrapping.nvim",                    -- Plugin to make it easier to switch between 'soft' and 'hard' line wrapping in NeoVim 
        config = function()
            require("wrapping").setup()
        end
    },
    -- { 'bytesnake/vim-graphical-preview',
    --     build = 'make -C autoload',
    --     dependencies = { 
    --         {'mattn/libcallex-vim',
    --             build = 'cargo build --release',
    --         },
    --     },
    -- }
    -- { 'edluffy/hologram.nvim',                          -- A cross platform terminal image viewer for Neovim. Extensible and fast, written in Lua and C. Works on macOS and Linux.
    --     config = function () require('hologram').setup({ auto_display = true }) end,
    -- },
}

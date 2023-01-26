-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call to not error out if not installed yet
local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
    return
end


-- Define plugins
local plugins = {
    ['dependencies'] = {
        -- Fixes, dependencies, and other needed util
        { 'DaikyXendo/nvim-material-icon',                  -- Icon set using nonicons for neovim plugins and settings
            dependencies = 'nvim-tree/nvim-web-devicons',       -- A Lua fork of vim-devicons.
            config = function () require('configs.nvim-material-icon') end,
        },
        { 'antoinemadec/FixCursorHold.nvim' },              -- Fix CursorHold Performance.
        { 'nvim-lua/plenary.nvim' },                        -- plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write twice.
        { 'MunifTanjim/nui.nvim' }                          -- UI Component Library for Neovim. 
    },
    ['treesitter'] = {
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
            tag = '*',
            event = 'VimEnter',
            config = true,
        },
        { 'windwp/nvim-ts-autotag',                         -- Use treesitter to auto close and auto rename html tags.
            config = true,
        },
    },
    ['keymapping'] = {
        { 'folke/which-key.nvim',                           -- Neovim plugin that shows a popup with possible keybindings of the command you started typing.
            dependencies = {
                'mrjones2014/legendary.nvim',                   -- Define your keymaps, commands, and autocommands as simple Lua tables, and create a legend for them at the same time, integrates with which-key.nvim.
                config = true,
            },
        },
    },
    ['git'] = {
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
        -- { 'sindrets/diffview.nvim',                         -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
        --     config = function() require('configs.diffview') end,
        --     event = 'BufRead',
        -- },
        { 'akinsho/git-conflict.nvim',                      -- A plugin to visualise and resolve merge conflicts in neovim.
            config = true,
            event = 'BufRead',
            tag = '*',
        },
    },
    ['external-package-manager'] = {
        { 'williamboman/mason.nvim',                        -- Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.
            event = 'BufRead',
            config = function() require('configs.mason') end,
        },
        { 'williamboman/mason-lspconfig.nvim',              -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
            dependencies = 'williamboman/mason.nvim',
            event = 'BufRead',
            config = function() require('configs.mason-lspconfig') end,
        }
    },
    ['language-server-protocol'] = {
        { 'neovim/nvim-lspconfig',                          -- Quickstart configurations for the Neovim LSP client.
            dependencies = {
                'williamboman/mason-lspconfig',                 -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim. Strongly recommended for Windows users. 
                'ray-x/lsp_signature.nvim',                     -- LSP signature hint as you type 
                'smjonas/inc-rename.nvim',                      -- Incremental LSP renaming based on Neovim's command-preview feature.
            },
            event = 'BufRead',
            config = function () require('configs.lspconfig') end,
        },
        { "weilbith/nvim-code-action-menu",                 -- A floating pop-up menu for code actions to show code action information and a diff preview.
            cmd = "CodeActionMenu",
            config = function() vim.g.code_action_menu_window_border = vim.g.quboid_border vim.g.code_action_menu_show_details = false end,
        },
        --use { "kosayoda/nvim-lightbulb",
        --    event = "BufRead",
        --    requires = "antoinemadec/FixCursorHold.nvim",
        --    config = function() require("configs.lightbulb") end,
        --}
        { 'RRethy/vim-illuminate',                          -- (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching.
            event = 'BufRead',
            config = function() require('illuminate').configure() end,
        },
    },
    ['completion'] = {
        { 'L3MON4D3/LuaSnip',                               -- Snippet Engine for Neovim written in Lua.
            dependencies = {
                'rafamadriz/friendly-snippets',                 -- Set of preconfigured snippets for different languages.
                { 'dsznajder/vscode-es7-javascript-react-snippets', -- Extension for React/Javascript snippets with search supporting ES7+ and babel features 
                    build = 'yarn install --frozen-lockfile && yarn compile',
                },
            },
            event = 'InsertEnter',
            config = function() require('configs.luasnip') end,
        },
        { 'hrsh7th/nvim-cmp',                               -- A completion plugin for Neovim written in Lua. New version of nvim-compe.
            dependencies = {
                'hrsh7th/cmp-path',                             -- nvim-cmp source for path 
                'kdheepak/cmp-latex-symbols',                   -- Add latex symbol support for nvim-cmp. 
                "hrsh7th/cmp-calc",                             -- nvim-cmp source for math calculation

                'saadparwaiz1/cmp_luasnip',                     -- nvim-cmp source for luasnip.
                'hrsh7th/cmp-nvim-lsp',                         -- nvim-cmp source for neovim builtin LSP client
                "andersevenrud/cmp-tmux",                       -- Tmux completion source for nvim-cmp and nvim-compe 

                'hrsh7th/cmp-buffer',                           -- nvim-cmp source for buffer words 
                'hrsh7th/cmp-cmdline',                          -- nvim-cmp source for vim's cmdline 
                { "petertriho/cmp-git",                         -- Git source for nvim-cmp 
                    dependencies = "nvim-lua/plenary.nvim"
                },
            },
            -- after = 'LuaSnip',
            config = function() require('configs.cmp') end,
        },
    },
    ['debug-adapter-protocol'] = {
    },
    ['multi-purpose'] = {
        -- TODO: Replace cinnamon and windows.nvim with this https://github.com/echasnovski/mini.nvim/issues/177#issuecomment-1364064915
        { 'echasnovski/mini.nvim',  -- Mini, multi purpose plugin, used for minimap and indent scope 
            --event = 'VimEnter',
            config = function () require('configs.mini') end,
        },
    },
    ['core-ui'] = {
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
                'kyazdani42/nvim-web-devicons',
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
    },
    ['core-ui-buffers'] = {
        -- Startup 
        { "goolord/alpha-nvim",                             -- A lua powered greeter like vim-startify / dashboard-nvim.
            -- TODO: Fix yucky config
            config = function() require("plugins.alpha") end,
        },

        -- File tree
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
            dependencies = { 'DaikyXendo/nvim-material-icon' },
            event = 'VimEnter',
            config = function() require('configs.trouble') end,
        },

        -- TODO: Once over config
        { 'simrat39/symbols-outline.nvim',                  -- A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favourite languages.
            dependencies = { 'kyazdani42/nvim-web-devicons', 'DaikyXendo/nvim-material-icon' },
            cmd = 'SymbolsOutline',
            config = function () require('configs.symbols-outline') end,
        },
    },
    ['colorschemes'] = {
    },
    ['plugin-dev'] = {
        { 'milisims/nvim-luaref' },                         -- Add a vim :help reference for lua
    },
    ['ft-markdown'] = {
        { 'prncss-xyz/neo-tree-zk.nvim',                    -- neo-tree source for zk-nvim 
            requires = {
                'nvim-neo-tree/neo-tree.nvim',
                'mickael-menu/zk-nvim'
            }
        },

    }
}

-- Condense tables
local plugins_spec = {}
for group, specs in pairs(plugins) do
    for _, spec in ipairs(specs) do
        table.insert(plugins_spec, spec)
    end
end

-- Send final table to lazy
lazy.setup(plugins_spec)


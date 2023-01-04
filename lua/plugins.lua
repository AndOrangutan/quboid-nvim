------------------------------------------- Autoinstall and autoupdate for Packer --
-------------------------------------------
-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path, }) print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
--vim.cmd([[
--    augroup packer_user_config
--        autocmd!
--        autocmd BufWritePost plugins.lua source <afile> | PackerSync
--    augroup end
--]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = vim.g.quboid_border })
        end,
    },
})

---------------------
-- Install plugins --
----------------------
return packer.startup(function(use)


    ------------------
    -- Core Plugins --
    -------------------

    -- Startup
    use { 'lewis6991/impatient.nvim',                       -- Improve startup time for Neovim.
        config = function() require('impatient') end,
    }
    use { 'wbthomason/packer.nvim',                         -- A use-package inspired plugin manager for Neovim. Uses native packages, supports Luarocks dependencies, written in Lua, allows for expressive config.
        --opt = true,
    }
    use { 'dstein64/vim-startuptime',                       -- Vim plugin for profiling Vim's startup time.
        cmd = 'StartupTime',
    }

    -- Helpers / Depenhencies
    use { 'DaikyXendo/nvim-material-icon',                         --Icon set using nonicons for neovim plugins and settings
        requires = {'nvim-tree/nvim-web-devicons',          -- A Lua fork of vim-devicons.
            config = function () require('plugins.nvim-material-icon') end,
        },
        --event = 'VimEnter',
    }
    use { 'antoinemadec/FixCursorHold.nvim' }               -- Fix CursorHold Performance.
    use { 'nvim-lua/plenary.nvim' }                         -- plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write twice.


    -- Keymapping
    use { 'mrjones2014/legendary.nvim',                     -- Define your keymaps, commands, and autocommands as simple Lua tables, and create a legend for them at the same time, integrates with which-key.nvim.
        --event = 'VimEnter',
        config = function() require('legendary').setup() end,
    }
    use { 'folke/which-key.nvim',                           -- Neovim plugin that shows a popup with possible keybindings of the command you started typing.
        requires = 'mrjones2014/legendary.nvim',

    --event = 'VimEnter',
        config = function() require('which-key').setup({}) end,
    }


    -- Treesitter for highlighting and syntax parsing
    use { 'nvim-treesitter/nvim-treesitter',                -- Neovim Treesitter configurations and abstraction layer.
        requires = {
            --"nvim-treesitter/nvim-treesitter-textobjects",      -- TODO: Setup textobjects
            'RRethy/nvim-treesitter-endwise',                   -- Wisely add "end" in Ruby, Vimscript, Lua, etc. Tree-sitter aware alternative to tpope's vim-endwise.
            'JoosepAlviste/nvim-ts-context-commentstring',      -- Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
            { 'nvim-treesitter/playground',                     --Treesitter playground integrated into Neovim
                cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' }
            },
        },
        --event = 'BufRead',
        run = ':TSUpdate',
        config = function() require('plugins.nvim-treesitter') end,
    }
    use { 'nvim-treesitter/nvim-treesitter-context',        -- Shows floating hover with the current function/block context.
        event = 'VimEnter',
        config = function() require('plugins.treesitter-context') end,
    }
    use { 'kylechui/nvim-surround',
        tag = '*',
        event = "VimEnter",
        config = function() require('nvim-surround').setup() end,
    }

    use { 'windwp/nvim-ts-autotag',                         -- Use treesitter to auto close and auto rename html tags.
        --event = 'VimEnter',
        --ft = vim.g.quboid_ft_html,
        --config = function() require('nvim-ts-auotag').setup() end,
    }
    --use { 'windwp/nvim-autopairs',                          -- A minimalist autopairs for Neovim written in Lua.
    --    event = 'VimEnter',
    --    config = function() require('plugins.nvim-autopairs') end,
    --}

    -- Git
    -- TODO: Configure and integrate git workflow
    use { 'lewis6991/gitsigns.nvim',                        -- Git integration: signs, hunk actions, blame, etc.
        event = 'BufRead',
        --after = 'nvim-lua/plenary.nvim',
        config = function() require("plugins.gitsigns") end,
    }
    use { 'TimUntersberger/neogit',                         -- A Magit clone for Neovim that may change some things to fit the Vim philosophy.
        config = function() require('plugins.neogit') end,
        event = 'VimEnter',
        commit = '8adf22f',
        --branch = 'nanozuki:master',
        requires = 'nvim-lua/plenary.nvim',
    }
    use { 'sindrets/diffview.nvim',                         -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
        event = 'BufRead',
        config = function() require('plugins.diffview') end,
    }
    use { 'akinsho/git-conflict.nvim',                      -- A plugin to visualise and resolve merge conflicts in neovim.
        event = 'BufRead',
        tag = '*',
        config = function() require('git-conflict').setup() end,
    }

    -- External Package Manaageers
    use { 'williamboman/mason.nvim',                        -- Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.
        event = 'BufRead',
        config = function() require('plugins.mason') end,
    }
    use { 'williamboman/mason-lspconfig.nvim',              -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
        requires = 'williamboman/mason.nvim',
        event = 'BufRead',
        config = function() require('plugins.mason-lspconfig') end,
    }

    -- LSP
    use { 'neovim/nvim-lspconfig',                          -- Quickstart configurations for the Neovim LSP client.
        requires = {
            'williamboman/mason-lspconfig',                 -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim. Strongly recommended for Windows users. 
            'ray-x/lsp_signature.nvim',                     -- LSP signature hint as you type 
            'smjonas/inc-rename.nvim',                      -- Incremental LSP renaming based on Neovim's command-preview feature.
        },
        event = 'BufRead',
        config = function () require('plugins.lspconfig') end,
    }
    ---- TODO: config properly
    --use { "ray-x/lsp_signature.nvim", -- Lsp signature hint when you type.
    --    event = "BufRead",
    --}
    use { "weilbith/nvim-code-action-menu",                 -- A floating pop-up menu for code actions to show code action information and a diff preview.
        event = "BufRead",
        cmd = "CodeActionMenu",
        config = function() vim.g.code_action_menu_window_border = vim.g.quboid_border vim.g.code_action_menu_show_details = false end,
    }
    --use { "kosayoda/nvim-lightbulb",
    --    event = "BufRead",
    --    requires = "antoinemadec/FixCursorHold.nvim",
    --    config = function() require("configs.lightbulb") end,
    --}
    use { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',   -- Show nvim diagnostics using virtual lines
        event = 'BufRead',
        config = function() require('plugins.lsp_lines') end,
    }
    use { 'RRethy/vim-illuminate',                          -- (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching.
        event = 'BufRead',
        config = function() require('illuminate').configure() end,
    } -- Completion and Snippets


    use { 'L3MON4D3/LuaSnip',                               -- Snippet Engine for Neovim written in Lua.
        requires = {
            'rafamadriz/friendly-snippets',                     -- Set of preconfigured snippets for different languages.
            { 'dsznajder/vscode-es7-javascript-react-snippets', run = 'yarn install --frozen-lockfile && yarn compile' },
        },
        event = 'InsertEnter',

        --event = 'InsertEnter',
        config = function() require('plugins.luasnip') end,
    }
    use { 'hrsh7th/nvim-cmp',                               -- A completion plugin for Neovim written in Lua. New version of nvim-compe.
        requires = {
            'hrsh7th/cmp-path',                             -- nvim-cmp source for path 
            'kdheepak/cmp-latex-symbols',                   -- Add latex symbol support for nvim-cmp. 
            "hrsh7th/cmp-calc",                             -- nvim-cmp source for math calculation

            'saadparwaiz1/cmp_luasnip',                     -- nvim-cmp source for luasnip.
            'hrsh7th/cmp-nvim-lsp',                         -- nvim-cmp source for neovim builtin LSP client
            'hrsh7th/cmp-nvim-lua',                         -- nvim-cmp source for nvim lua 
            "andersevenrud/cmp-tmux",                       -- Tmux completion source for nvim-cmp and nvim-compe 

            'hrsh7th/cmp-buffer',                           -- nvim-cmp source for buffer words 
            'hrsh7th/cmp-cmdline',                          -- nvim-cmp source for vim's cmdline 
            { "petertriho/cmp-git", requires = "nvim-lua/plenary.nvim" },   -- Git source for nvim-cmp 
        },
        after = 'LuaSnip',
        config = function() require('plugins.cmp') end,
    }

    -- Mini, multi purpose plugin, used for minimap and indent scope
    use { 'echasnovski/mini.nvim',  -- 
        --event = 'VimEnter',
        config = function () require('plugins.mini') end,
    }

    ------------------------
    -- Core UI Components --
    ------------------------

    -- Notificaitons
    use { 'rcarriga/nvim-notify',                           -- A fancy, configurable, notification manager for Neovim.
        event = 'VimEnter',
        config = function() require('plugins.notify') end,
    }

    use { 'stevearc/dressing.nvim',                         -- Neovim plugin to improve the default vim.ui interfaces
        config = function () require('plugins.dressing') end,
    }

    -- Statusline
    use { 'nvim-lualine/lualine.nvim',                      -- A blazing fast and easy to configure Neovim statusline.
        requires = { 'kyazdani42/nvim-web-devicons', 'DaikyXendo/nvim-material-icon' },
        config = function() require('plugins.lualine') end
    }

    -- Bufferline/Tabline
    use { 'akinsho/bufferline.nvim',
        config = function () require('plugins.bufferline') end,
    }

    use { 'prncss-xyz/neo-tree-zk.nvim',                    -- neo-tree source for zk-nvim 
        requires = {
            'nvim-neo-tree/neo-tree.nvim',
            'mickael-menu/zk-nvim'
        }
    }

    -- File tree
    use { 'nvim-neo-tree/neo-tree.nvim',                    -- Neovim plugin to manage the file system and other tree like structures. 
        requires = {
            'nvim-lua/plenary.nvim',
            {'kyazdani42/nvim-web-devicons', 'DaikyXendo/nvim-material-icon'},
            'MunifTanjim/nui.nvim',
        },
        --cmd = 'Neotree',
        branch = 'v2.x',
        config = function () require('plugins.neo-tree') end,
    }

    -- Picker
    use { 'ibhagwan/fzf-lua',                               -- Improved fzf.vim written in lua
        requires = { 'DaikyXendo/nvim-material-icon', 'kyazdani42/nvim-web-devicons' },
        --event = 'VimEnter',
        config = function() require('plugins.fzf-lua') end,
    }

    -- Startup 
    use { "goolord/alpha-nvim",                             -- A lua powered greeter like vim-startify / dashboard-nvim.
        config = function() require("plugins.alpha") end,
    }

    --Quick fix
    use { 'folke/trouble.nvim',                             -- Improved fzf.vim written in lua
        requires = { 'DaikyXendo/nvim-material-icon' },
        --event = 'VimEnter',
        config = function() require('plugins.trouble') end,
    }

    -- Symbol Outline
    use { 'simrat39/symbols-outline.nvim',                  -- A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favourite languages.
        requires = { 'kyazdani42/nvim-web-devicons', 'DaikyXendo/nvim-material-icon' },
        cmd = 'SymbolsOutline',
        config = function () require('plugins.symbols-outline') end,
    }

    -- Multiline Cursor
    use { 'mg979/vim-visual-multi' }                        -- Multiple cursor plugin fot vim/neovim}

    -- Comments
    use { 'numToStr/Comment.nvim',                          -- Smart and powerful comment plugin for neovim. Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more 
        config = function () require('Comment').setup() end,
    }
    use { 'aserowy/tmux.nvim',                              -- Tmux integration for Neovim features pane movement and resizing from within Neovim.
        config = function() require('plugins.tmux') end,
    }
    use { 'anuvyklack/windows.nvim',                        -- Automatically expand width of the current window. Maximizes and restore it. And all this with nice animations! 
        requires = {
            'anuvyklack/middleclass',
            'anuvyklack/animation.nvim'
        },
        config = function()
            require('plugins.windows')
        end
    }


    -- Highlighting
    use { 'jinh0/eyeliner.nvim',                            -- Move faster with unique f/F indicators. 
        config = function () require('eyeliner').setup({ highlight_on_key = true }) end,
    }
    -------------------
    -- Code Runners --
    -------------------

    -- General
    use { 'michaelb/sniprun',                               -- A neovim plugin to run lines/blocs of code (independently of the rest of the file), supporting multiples languages

        run = 'bash ./install.sh',
        config = function () require('plugins.sniprun') end,

    }

    -------------------
    -- File Specific --
    --------------------

    -- Markdown
    use { 'mickael-menu/zk-nvim',                           -- Neovim extension for zk 
        --ft = 'markdown',
        config = function () require('plugins.zk') end,
    }
    use { 'lukas-reineke/headlines.nvim',                   -- This plugin adds horizontal highlights for text filetypes, like markdown, orgmode, and neorg.
        --ft =  'markdown',
        after = 'nvim-treesitter',
        confug = function ()  require('headlines').setup() end,
    }
    use { 'preservim/vim-markdown',                         -- Markdown Vim Mode
        ft = 'markdown',
        setup = function () require('plugins.vim-markdown') end,
    }
    use { 'iamcco/markdown-preview.nvim',                   -- Markdown preview plugin for (neo)vim
        ft = 'markdown',
        run = function () vim.fn['mkdp#util#install']() end,
        setup = function () require('plugins.markdown-preview') end,
    }
    use { 'ekickx/clipboard-image.nvim',                    -- Neovim Lua plugin to paste image from clipboard. 
        ft = 'markdown',
        config = function () require('plugins.clipboard-image') end,
    }
    use { 'gaoDean/autolist.nvim',                          -- Automatic list continuation and formatting for neovim, powered by lua 
        ft = { 'markdown', 'text', 'gitcommit', 'scatch' },
        config = function () require('plugins.autolist') end
    }
    --use { 'jbyuki/nabla.nvim' }
    use { 'AckslD/nvim-FeMaco.lua',                         -- Catalyze your Fenced Markdown Code-block editing!
        ft = 'markdown',
        config = function () require('plugins.femaco') end,

    }
    use { 'dhruvasagar/vim-table-mode',                     -- VIM Table Mode for instant table creation. 
        ft = 'markdown',
        config = function () require('plugins.table-mode') end,
    }
    use { 'NFrid/due.nvim',                                 -- Neovim plugin for displaying due dates
        ft = 'markdown',
        requires = 'nvim-treesitter/nvim-treesitter',
        config = function() require('plugins.due') end,
    }



    -----------
    -- Bloat --
    -----------
    -- use { 'levouh/tint.nvim',                               -- Dim inactive windows in Neovim using window-local highlight namespaces. 
    --     config = function () require('tint').setup() end,
    -- }
    -- TODO: add exclude function so it doesn't flash when using neotree or symbol outline

    -- Smooth Scrolling
    use { 'declancm/cinnamon.nvim',                         -- Smooth scrolling for ANY movement command exploding_head. A Neovim plugin written in Lua! 
        config = function() require('plugins.cinnamon') end,
    }


    --------------------
    ---- Colorschemes --
    --------------------

    use { 'navarasu/onedark.nvim',                          -- One dark and light colorscheme for neovim >= 0.5.0 written in lua based on Atom's One Dark and Light theme. Additionally, it comes with 5 color variant styles
        config = function () require('plugins.onedark') end,
    }

    use { 'neanias/everforest-nvim' }                      -- Lua port: A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favourite languages.

end)

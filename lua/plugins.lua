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
    use { 'lewis6991/impatient.nvim', -- Improve startup time for Neovim.
        config = function() require('impatient') end,
    }
    use { 'wbthomason/packer.nvim', -- A use-package inspired plugin manager for Neovim. Uses native packages, supports Luarocks dependencies, written in Lua, allows for expressive config.
        --opt = true,
    }
    use { 'dstein64/vim-startuptime', -- Vim plugin for profiling Vim's startup time.
        cmd = 'StartupTime',
    }

    -- Helpers / Depenhencies
    use { 'yamatsum/nvim-nonicons', --Icon set using nonicons for neovim plugins and settings
        requires = 'nvim-tree/nvim-web-devicons',  -- A Lua fork of vim-devicons.
        --event = 'VimEnter',
    }
    use { 'antoinemadec/FixCursorHold.nvim' } -- Fix CursorHold Performance.
    use { 'nvim-lua/plenary.nvim', -- plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write twice.
    }

    -- Keymapping
    use { 'mrjones2014/legendary.nvim', -- Define your keymaps, commands, and autocommands as simple Lua tables, and create a legend for them at the same time, integrates with which-key.nvim.
        --event = 'VimEnter',
        config = function() require('legendary').setup() end,
    }
    use { 'folke/which-key.nvim', -- Neovim plugin that shows a popup with possible keybindings of the command you started typing.
        requires = 'mrjones2014/legendary.nvim',

    --event = 'VimEnter',
        config = function() require('which-key').setup() end,
    }

    -- Treesitter for highlighting and syntax parsing
    use { 'nvim-treesitter/nvim-treesitter', -- Neovim Treesitter configurations and abstraction layer.
        requires = {
            --"nvim-treesitter/nvim-treesitter-textobjects",  -- TODO: Setup textobjects
            'RRethy/nvim-treesitter-endwise', -- Wisely add "end" in Ruby, Vimscript, Lua, etc. Tree-sitter aware alternative to tpope's vim-endwise.
            'JoosepAlviste/nvim-ts-context-commentstring', -- Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
            { 'MDeiml/tree-sitter-markdown', -- A markdown grammar for tree-sitter
                ft = 'markdown',
            },
            { 'nvim-treesitter/playground', --Treesitter playground integrated into Neovim
                cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' }
            },
        },
        --event = 'BufRead',
        run = ':TSUpdate',
        config = function() require('plugins.nvim-treesitter') end,
    }
    use { 'nvim-treesitter/nvim-treesitter-context', -- Shows floating hover with the current function/block context.
        event = 'VimEnter',
        config = function() require('plugins.treesitter-context') end,
    }
    use { 'kylechui/nvim-surround',
        tag = '*',
        event = "VimEnter",
        config = function() require('nvim-surround').setup() end,
    }
    use { 'windwp/nvim-ts-autotag', -- Use treesitter to auto close and auto rename html tags.
        --event = 'VimEnter',
        --ft = vim.g.quboid_ft_html,
        --config = function() require('nvim-ts-auotag').setup() end,
    }
    use { 'windwp/nvim-autopairs', -- A minimalist autopairs for Neovim written in Lua.
        event = 'VimEnter',
        config = function() require('plugins.nvim-autopairs') end,
    }

    -- Git
    -- TODO: Configure and integrate git workflow
    use { 'lewis6991/gitsigns.nvim', -- Git integration: signs, hunk actions, blame, etc.
        event = 'BufRead',
        --after = 'nvim-lua/plenary.nvim',
        config = function() require("plugins.gitsigns") end,
    }
    use { 'TimUntersberger/neogit', -- A Magit clone for Neovim that may change some things to fit the Vim philosophy.
        config = function() require('plugins.neogit') end,
        event = 'VimEnter',
        commit = '8adf22f',
        --branch = 'nanozuki:master',
        requires = 'nvim-lua/plenary.nvim',
    }
    use { 'sindrets/diffview.nvim', -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
        event = 'BufRead',
        config = function() require('plugins.diffview') end,
    }
    use { 'akinsho/git-conflict.nvim', -- A plugin to visualise and resolve merge conflicts in neovim.
        event = 'BufRead',
        tag = '*',
        config = function() require('git-conflict').setup() end,
    }

    -- External Package Manaageers
    use { 'williamboman/mason.nvim', -- Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.
        event = 'BufRead',
        config = function() require('plugins.mason') end,
    }
    use { 'williamboman/mason-lspconfig.nvim', -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
        requires = 'williamboman/mason.nvim',
        event = 'BufRead',
        config = function() require('plugins.mason-lspconfig') end,
    }

    -- LSP
    use { 'neovim/nvim-lspconfig', -- Quickstart configurations for the Neovim LSP client.
        requires = 'williamboman/mason-lspconfig',
        event = 'BufRead',
        config = function () require('plugins.lspconfig') end,
    }
    ---- TODO: config properly
    --use { "ray-x/lsp_signature.nvim", -- Lsp signature hint when you type.
    --    event = "BufRead",
    --    config = function() require("configs.lspsignature") end,
    --}
    --use { "weilbith/nvim-code-action-menu", -- A floating pop-up menu for code actions to show code action information and a diff preview.
    --    event = "BufRead",
    --    cmd = "CodeActionMenu",
    --    config = function() vim.g.code_action_menu_window_border = "solid" vim.g.code_action_menu_show_details = false end,
    --}
    --use { "kosayoda/nvim-lightbulb",
    --    event = "BufRead",
    --    requires = "antoinemadec/FixCursorHold.nvim",
    --    config = function() require("configs.lightbulb") end,
    --}
    use { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim', -- Show nvim diagnostics using virtual lines
        event = 'BufRead',
        config = function() require('plugins.lsp_lines') end,
    }
    use { 'RRethy/vim-illuminate', -- (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching.
        event = 'BufRead',
        config = function() require('illuminate').configure() end,
    } -- Completion and Snippets
    --
    --
    use { 'L3MON4D3/LuaSnip', -- Snippet Engine for Neovim written in Lua.
        requires = {
            'rafamadriz/friendly-snippets', -- Set of preconfigured snippets for different languages.
            { 'dsznajder/vscode-es7-javascript-react-snippets', run = 'yarn install --frozen-lockfile && yarn compile' },
        },
        event = 'InsertEnter',
        config = function() require('plugins.luasnip') end,
    }
    use { 'hrsh7th/nvim-cmp', -- A completion plugin for Neovim written in Lua. New version of nvim-compe.
        requires = {
            'windwp/nvim-autopairs',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',

            --{ "David-Kunz/cmp-npm", requires = "nvim-lua/plenary.nvim" },
            --"kdheepak/cmp-latex-symbols",
            --"ray-x/cmp-treesitter",
            --{ "petertriho/cmp-git", requires = "nvim-lua/plenary.nvim" },
            --"andersevenrud/cmp-tmux",
            --"lukas-reineke/cmp-rg",
            --"hrsh7th/cmp-calc",
            --"uga-rosa/cmp-dictionary",
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
    use { 'rcarriga/nvim-notify',   -- A fancy, configurable, notification manager for Neovim.
        event = 'VimEnter',
        config = function() require('plugins.notify') end,
    }

    -- Statusline
    use { 'nvim-lualine/lualine.nvim', -- A blazing fast and easy to configure Neovim statusline.
        requires = { 'kyazdani42/nvim-web-devicons', },
        config = function() require('plugins.lualine') end
    }

    -- Bufferline/Tabline
    use { 'akinsho/bufferline.nvim',
        config = function () require('plugins.bufferline') end,
    }

    use { 'prncss-xyz/neo-tree-zk.nvim', -- neo-tree source for zk-nvim 
        requires = {
            'nvim-neo-tree/neo-tree.nvim',
            'mickael-menu/zk-nvim'
        }
    }

    -- File tree
    use { 'nvim-neo-tree/neo-tree.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
        --cmd = 'Neotree',
        branch = 'v2.x',
        config = function () require('plugins.neo-tree') end,
    }

    -- Picker
    use { 'ibhagwan/fzf-lua',   -- Improved fzf.vim written in lua
        requires = 'kyazdani42/nvim-web-devicons',
        --event = 'VimEnter',
        config = function() require('plugins.fzf-lua') end,
    }

    -- Startup 
    use { "goolord/alpha-nvim", -- A lua powered greeter like vim-startify / dashboard-nvim.
        config = function() require("plugins.alpha") end,
    }



    use { 'declancm/cinnamon.nvim', -- Smooth scrolling for ANY movement command exploding_head. A Neovim plugin written in Lua! 
        config = function() require('plugins.cinnamon') end,
    }

    -------------------
    -- File Specific --
    --------------------

    -- Markdown
    use { 'mickael-menu/zk-nvim',   -- Neovim extension for zk 
        --ft = 'markdown',
        config = function () require('plugins.zk') end,
    }
    use { 'preservim/vim-markdown', -- Markdown Vim Mode
        ft = 'markdown',
        setup = function () require('plugins.vim-markdown') end,
    }

    --------------------
    ---- Colorschemes --
    --------------------

    use { 'navarasu/onedark.nvim',
        config = function () require('plugins.onedark') end,
    }


end)

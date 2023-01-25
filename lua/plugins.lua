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
    dependencies = {
        -- Fixes, dependencies, and other needed util
        { 'DaikyXendo/nvim-material-icon',                  -- Icon set using nonicons for neovim plugins and settings
            dependencies = 'nvim-tree/nvim-web-devicons',       -- A Lua fork of vim-devicons.
            config = function () require('configs.nvim-material-icon') end,
        },
        { 'antoinemadec/FixCursorHold.nvim' },              -- Fix CursorHold Performance.
        { 'nvim-lua/plenary.nvim' },                        -- plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write twice.
    },
    treesitter = {
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
        { },
    },
    keymapping = {
        { 'folke/which-key.nvim',                           -- Neovim plugin that shows a popup with possible keybindings of the command you started typing.
            dependencies = {
                'mrjones2014/legendary.nvim',                   -- Define your keymaps, commands, and autocommands as simple Lua tables, and create a legend for them at the same time, integrates with which-key.nvim.
                config = true,
            },
        },
    },
    lsp = {
    },
    dap = {
    },
    kruft = {
    },
    colorschemes = {
    },
}

-- Condense tables
local plugins_spec = {}
for group, specs in pairs(plugins) do
    if not table.contains(groups_to_skip, group) then
        for _, spec in ipairs(specs) do
            table.insert(plugins_spec, spec)
        end
    end
end

-- Send final table to lazy
lazy.setup(plugins_spec)



local quboid = require('quboid')

-- Load pre-plugin settings
require('defaults.options')
require('custom.options')

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

local lazy_ok, lazy = pcall(require, 'lazy')
if not lazy_ok then
    return
end

lazy.setup('plugins', {
    diff = {
        -- TODO: Enable diffview support
        -- cmd = "diffview.nvim",
    },
    install = { colorscheme = { 'onedark' } },
    checker = {
        enabled = true,
        notify = false,
    },
    ui = {
        border = quboid.border,
        icons = {
            cmd         = " ",
            config      = quboid.icons.cog,
            event       = quboid.icons.bolt,
            ft          = quboid.icons.file,
            init        = quboid.icons.cog,
            import      = quboid.icons.file_import,
            keys        = quboid.icons.keyboard,
            lazy        = "󰒲 ",
            loaded      = "●",
            not_loaded  = "○",
            plugin      = quboid.icons.cube,
            runtime     = quboid.icons.vim,
            source      = quboid.icons.code,
            start       = quboid.icons.circle_play,
            task        = quboid.icons.check,
            list = {
                "●",
                "➜",
                "★",
                "‒",
            },
        },
    },
})

-- Load post-plugin settings
require('defaults.autocmds')
require('custom.autocmds')
require('defaults.autocmds')
require('custom.autocmds')

-- colorscheme and highlights
-- require('highlights')

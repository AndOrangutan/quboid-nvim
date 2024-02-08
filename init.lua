local quboid = require('quboid')
local icons = require('quboid.icons')

require('options')

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
        cmd = "diffview.nvim",
    },
    install = { colorscheme = { 'onedark' } },
    checker = {
        enabled = true,
        notify = false,
    },
    ui = {
        border = quboid.border,
        icons = {
            cmd = icons.gen.cmd,
            config = icons.gen.cmd,
            event = icons.gen.bolt,
            ft = icons.gen.file,
            init = icons.gen.cog,
            import = icons.gen.file_inport,
            keys = icons.gen.keybord,
            lazy = icons.gen.zzz,
            loaded = icons.gen.circle,
            not_loaded = icons.gen.circle_o,
            plugin = icons.gen.plug,
            runtime = icons.gen.editor,
            require = icons.lang.lua,
            source = icons.gen.code,
            start = icons.gen.play,
            task = icons.gen.check,
            list = {
                '●',
                '➜',
                '★',
                '‒',
            },
        },
    },
    performance = {
        rtp = {
            disabled_plugins = {
                'netrwPlugin', -- disable netrw
            },
        },
    },

})


-- TODO: Checkout
-- -- Fixes diagnostics
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics, {
--         virtual_text = false
--     }
-- )

-- colorscheme and highlights
require('highlights')

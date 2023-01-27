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


-- Send final table to lazy
lazy.setup('plugins')


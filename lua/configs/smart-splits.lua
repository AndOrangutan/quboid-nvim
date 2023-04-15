local quboid = require('quboid')
local util = require('util')

require('smart-splits').setup({
    ignore_buftypes = quboid.ft_rigid,
    hooks = {
        on_enter = function()
            vim.notify('Entering resize mode')
        end,
        on_leave = function()
            vim.notify('Exiting resize mode, bye')
        end,
    },
})


util.keymap('n', '<C-A-h>', require('smart-splits').resize_left)
util.keymap('n', '<C-A-j>', require('smart-splits').resize_down)
util.keymap('n', '<C-A-k>', require('smart-splits').resize_up)
util.keymap('n', '<C-A-l>', require('smart-splits').resize_right)
-- moving between splits
util.keymap('n', '<A-h>', require('smart-splits').move_cursor_left)
util.keymap('n', '<A-j>', require('smart-splits').move_cursor_down)
util.keymap('n', '<A-k>', require('smart-splits').move_cursor_up)
util.keymap('n', '<A-l>', require('smart-splits').move_cursor_right)
-- swapping buffers between windows
util.keymap('n', '<A-H>', require('smart-splits').swap_buf_left)
util.keymap('n', '<A-J>', require('smart-splits').swap_buf_down)
util.keymap('n', '<A-K>', require('smart-splits').swap_buf_up)
util.keymap('n', '<A-L>', require('smart-splits').swap_buf_right)

-- TODO: Add smart-splits support to wezterm
-- https://github.com/aserowy/tmux.nvim


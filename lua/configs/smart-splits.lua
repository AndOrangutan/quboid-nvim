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


util.keymap('n', '<C-A-h>', require('smart-splits').resize_left, 'Resize Left')
util.keymap('n', '<C-A-j>', require('smart-splits').resize_down, 'Resize Down')
util.keymap('n', '<C-A-k>', require('smart-splits').resize_up, 'Resize Up')
util.keymap('n', '<C-A-l>', require('smart-splits').resize_right, 'Resize Right')
-- moving between splits
util.keymap('n', '<A-h>', require('smart-splits').move_cursor_left, 'Move Left')
util.keymap('n', '<A-j>', require('smart-splits').move_cursor_down, 'Move Down')
util.keymap('n', '<A-k>', require('smart-splits').move_cursor_up, 'Move Up')
util.keymap('n', '<A-l>', require('smart-splits').move_cursor_right, 'Move Right')
-- swapping buffers between windows
util.keymap('n', '<A-H>', require('smart-splits').swap_buf_left, 'Swap Left')
util.keymap('n', '<A-J>', require('smart-splits').swap_buf_down, 'Swap Down')
util.keymap('n', '<A-K>', require('smart-splits').swap_buf_up, 'Swap Up')
util.keymap('n', '<A-L>', require('smart-splits').swap_buf_right, 'Swap Right')



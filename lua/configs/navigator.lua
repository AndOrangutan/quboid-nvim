local util = require('util')

require('Navigator').setup({
    -- Save modified buffer(s) when moving to mux
    -- nil - Don't save (default)
    -- 'current' - Only save the current modified buffer
    -- 'all' - Save all the buffers
    auto_save = nil,

    -- Disable navigation when the current mux pane is zoomed in
    disable_on_zoom = false,

    -- Multiplexer to use
    -- 'auto' - Chooses mux based on priority (default)
    -- table - Custom mux to use
    mux = 'auto'
})


util.keymap('n', '<M-h>', '<cmd>lua require("Navigator").left()<cr>', 'Multiplexer/Neovim [h]op Left')
util.keymap('n', '<M-j>', '<cmd>lua require("Navigator").down()<cr>', 'Multiplexer/Neovim [j]ump Down')
util.keymap('n', '<M-k>', '<cmd>lua require("Navigator").up()<cr>', 'Multiplexer/Neovim [k]ick Up')
util.keymap('n', '<M-l>', '<cmd>lua require("Navigator").right()<cr>', 'Multiplexer/Neovim [l]eap Right')

-- TODO: Ask for this if I miss multiplexer shrinking growing
-- util.keymap('n', '<C-M-h>', '<cmd>lua require("tmux").resize_left()<cr>', 'Tmux/Neovim [c]rush Left')
-- util.keymap('n', '<C-M-j>', '<cmd>lua require("tmux").resize_bottom()<cr>', 'Tmux/Neovim [c]rush Down')
-- util.keymap('n', '<C-M-k>', '<cmd>lua require("tmux").resize_top()<cr>', 'Tmux/Neovim [c]rush Up')
-- util.keymap('n', '<C-M-l>', '<cmd>lua require("tmux").resize_right()<cr>', 'Tmux/Neovim [c]rush Right')


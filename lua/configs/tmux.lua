local util = require('util')

local tmux = require('tmux')

tmux.setup({
    copy_sync = {
        -- enables copy sync and overwrites all register actions to
        -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
        enable = true,

        -- ignore specific tmux buffers e.g. buffer0 = true to ignore the
        -- first buffer or named_buffer_name = true to ignore a named tmux
        -- buffer with name named_buffer_name :)
        ignore_buffers = { empty = false },

        -- TMUX >= 3.2: yanks (and deletes) will get redirected to system
        -- clipboard by tmux
        redirect_to_clipboard = false,

        -- offset controls where register sync starts
        -- e.g. offset 2 lets registers 0 and 1 untouched
        register_offset = 0,

        -- sync clipboard overwrites vim.g.clipboard to handle * and +
        -- registers. If you sync your system clipboard without tmux, disable
        -- this option!
        sync_clipboard = true,

        -- synchronizes registers *, +, unnamed, and 0 till 9 with tmux buffers.
        sync_registers = false,
        
        -- syncs deletes with tmux clipboard as well, it is adviced to
        -- do so. Nvim does not allow syncing registers 0 and 1 without
        -- overwriting the unnamed register. Thus, ddp would not be possible.
        sync_deletes = true,

        -- syncs the unnamed register with the first buffer entry from tmux.
        sync_unnamed = true,
    },
    navigation = {
        -- cycles to opposite pane while navigating into the border
        cycle_navigation = false,

        -- enables default keybindings (C-hjkl) for normal mode
        enable_default_keybindings = false,

        -- prevents unzoom tmux when navigating beyond vim border
        persist_zoom = false,
    },
    resize = {
        -- enables default keybindings (A-hjkl) for normal mode
        enable_default_keybindings = false,

        -- sets resize steps for x axis
        resize_step_x = 1,

        -- sets resize steps for y axis
        resize_step_y = 1,
    }
})

util.keymap('n', '<M-h>', '<cmd>require("tmux").move_left()', 'Tmux/Neovim [h]op Left')
util.keymap('n', '<M-j>', '<cmd>require("tmux").move_bottom()', 'Tmux/Neovim [j]ump Down')
util.keymap('n', '<M-k>', '<cmd>require("tmux").move_top()', 'Tmux/Neovim [k]ick Up')
util.keymap('n', '<M-l>', '<cmd>require("tmux").move_top()', 'Tmux/Neovim [l]eap Right')

util.keymap('n', '<C-M-h>', '<cmd>require("tmux").resize_left()', 'Tmux/Neovim [c]rush Left')
util.keymap('n', '<C-M-j>', '<cmd>require("tmux").resize_bottom()', 'Tmux/Neovim [c]rush Down')
util.keymap('n', '<C-M-k>', '<cmd>require("tmux").resize_top()', 'Tmux/Neovim [c]rush Up')
util.keymap('n', '<C-M-l>', '<cmd>require("tmux").resize_top()', 'Tmux/Neovim [c]rush Right')




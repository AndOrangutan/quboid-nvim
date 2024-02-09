return {
    {
        'Shatur/neovim-session-manager',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = { 'SessionManager' },
        config = function()
            local ft = require('quboid.ft')
            local quboid = require('quboid')
            local path = require('plenary.path')

            require('session_manager').setup({
                sessions_dir = path:new(vim.fn.stdpath('data'), 'sessions'),             -- The directory where the session files will be saved.
                path_replacer = '__',                                                    -- The character to which the path separator will be replaced for session files.
                colon_replacer = '++',                                                   -- The character to which the colon symbol will be replaced for session files.
                autoload_mode = require('session_manager.config').AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
                autosave_last_session = true,                                            -- Automatically save last session on exit and on session switch.
                autosave_ignore_not_normal = true,                                       -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
                autosave_ignore_dirs = quboid.session_exclude_dirs,                      -- A list of directories where the session will not be autosaved.
                autosave_ignore_filetypes = ft.ft_exclude,
                autosave_ignore_buftypes = ft.bt_exclude,                                -- All buffers of these bufer types will be closed before the session is saved.
                autosave_only_in_session = false,                                        -- Always autosaves session. If true, only autosaves after a session is active.
                max_path_length = 80,                                                    -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
            })
        end,
        keys = {
            { '<leader>ss', '<cmd>SessionManager save_current_session<CR>', desc = '[s]essions [s]ave' },
            { '<leader>sl', '<cmd>SessionManager load_session<CR>',         desc = '[s]essions [l]oad' },
        },
    }
}

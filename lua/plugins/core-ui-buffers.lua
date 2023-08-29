return {
    { 'nvim-neo-tree/neo-tree.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
        config = function () 
            local quboid = require('quboid')

            vim.fn.sign_define("DiagnosticSignError", {text = quboid.icons.circle_error, texthl = "DiagnosticSignError"})
            vim.fn.sign_define("DiagnosticSignWarn", {text = quboid.icons.circle_warn, texthl = "DiagnosticSignWarn"})
            vim.fn.sign_define("DiagnosticSignInfo", {text = quboid.icons.circle_info, texthl = "DiagnosticSignInfo"})
            vim.fn.sign_define("DiagnosticSignHint", {text = quboid.icons.circle_hint, texthl = "DiagnosticSignHint"})

            require('neo-tree').setup({
                close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
                popup_border_style = quboid.border,
                enable_git_status = true,
                enable_diagnostics = true,

                default_component_configs = {
                    container = {
                        enable_character_fade = true
                    },
                    indent = {
                        indent_size = 2,
                        padding = 1, -- extra padding on left hand side
                        -- indent guides
                        with_markers = true,
                        indent_marker       = quboid.icons.bar_thick_tree,
                        last_indent_marker  = quboid.icons.bar_thick_elbow,
                        highlight = "NeoTreeIndentMarker",
                        -- expander config, needed for nesting files
                        with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                        expander_collapsed  = "",
                        expander_expanded   = "",
                        expander_highlight = "NeoTreeExpander",
                    },
                    icon = {
                        folder_closed   = quboid.icons.folder,
                        folder_open     = quboid.icons.folder_open,
                        folder_empty    = quboid.icons.folder_outline,
                        -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                        -- then these will never be used.
                        default = "*",
                        highlight = "NeoTreeFileIcon"
                    },
                    modified = {
                        symbol = "[+]",
                        highlight = "NeoTreeModified",
                    },
                    git_status = {
                        symbols = {
                            -- Change type
                            added     = quboid.icons.git_added, -- or "✚", but this is redundant info if you use git_status_colors on the name
                            modified  = quboid.icons.git_modified, -- or "", but this is redundant info if you use git_status_colors on the name
                            deleted   = quboid.icons.git_deleted,-- this can only be used in the git_status source
                            renamed   = quboid.icons.git_renamed,-- this can only be used in the git_status source
                            -- Status type
                            untracked = quboid.icons.git_untracked,
                            ignored   = quboid.icons.git_ignored,
                            unstaged  = quboid.icons.git_unstaged,
                            staged    = quboid.icons.git_staged,
                            conflict  = quboid.icons.git_conflict,
                        }
                    },
                },
                window = {
                    position = "left",
                    width = 40,
                    mapping_options = {
                        noremap = true,
                        nowait = true,
                    },
                },

                -- https://github.com/echasnovski/mini.nvim/issues/177#issuecomment-1406203745
                event_handlers = {
                    {
                        event = 'neo_tree_window_after_open',
                        handler = function(data)
                            local winid = data.winid
                            vim.api.nvim_win_set_option(winid, 'winfixwidth', true)
                            vim.api.nvim_win_set_width(winid, 40)
                        end,
                    }
                }
            })
        end,
        event = 'VeryLazy',
        keys = {
            { '<leader>nn', '<cmd>Neotree toggle<cr>', desc = 'Neo-tree Toggle' },
        },
    }
}

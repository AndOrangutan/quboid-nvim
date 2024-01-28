return {
    {
        'nvim-neo-tree/neo-tree.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
            -- "3rd/image.nvim", -- TODO: Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function()
            local quboid = require('quboid')
            local icons = require('quboid.icons')

            vim.fn.sign_define('DiagnosticSignError', { text = icons.gen.circle_error, texthl = 'DiagnosticSignError' })
            vim.fn.sign_define('DiagnosticSignWarn', { text = icons.gen.circle_warn, texthl = 'DiagnosticSignWarn' })
            vim.fn.sign_define('DiagnosticSignInfo', { text = icons.gen.circle_info, texthl = 'DiagnosticSignInfo' })
            vim.fn.sign_define('DiagnosticSignHint', { text = icons.gen.circle_hint, texthl = 'DiagnosticSignHint' })

            require('neo-tree').setup({
                close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
                popup_border_style = quboid.border,

                default_component_configs = {
                    indent = {
                        indent_size = 2,
                        padding = 1, -- extra padding on left hand side
                        -- indent guides
                        with_markers = true,
                        indent_marker = icons.ui.bar_thick_tree,
                        last_indent_marker = icons.ui.bar_thick_elbow,
                        highlight = 'NeoTreeIndentMarker',
                        with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                        expander_collapsed = icons.ui.collapse,
                        expander_expanded = icons.ui.expand,
                        expander_highlight = 'NeoTreeExpander',
                    },
                    icon = {
                        folder_closed = icons.gen.folder,
                        folder_open = icons.gen.folder_open,
                        folder_empty = icons.gen.folder_o,
                        -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                        -- then these will never be used.
                        default = '*',
                        highlight = 'NeoTreeFileIcon',
                    },
                    modified = {
                        symbol = icons.gen.pencil,
                        highlight = 'NeoTreeModified',
                    },
                    git_status = {
                        symbols = {
                            -- Change type
                            added = icons.gen.box_added,       -- or '✚', but this is redundant info if you use git_status_colors on the name
                            modified = icons.gen.box_modified, -- or '', but this is redundant info if you use git_status_colors on the name
                            deleted = icons.gen.box_deleted,   -- this can only be used in the git_status source
                            renamed = icons.gen.box_renamed,   -- this can only be used in the git_status source
                            -- Status type
                            untracked = icons.gen.question,
                            ignored = icons.gen.hidden,
                            unstaged = icons.gen.box_o,
                            staged = icons.gen.box_o_check,
                            conflict = icons.gen.config,
                        },
                    },
                },
                window = {
                    position = 'left',
                    width = 40,
                    mapping_options = {
                        noremap = true,
                        nowait = true,
                    },
                    mappings = {
                        -- ['<space>'] = {
                        --     'toggle_node',
                        --     nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
                        -- },
                        ['<2-LeftMouse>'] = 'open',
                        ['<cr>'] = 'open',
                        ['<tab>'] = 'open',
                        ['<esc>'] = 'cancel', -- close preview or floating neo-tree window
                        ['P'] = { 'toggle_preview', config = { use_float = false, use_image_nvim = true } },
                        ['l'] = 'focus_preview',
                        ['S'] = 'open_split',
                        ['s'] = 'open_vsplit',
                        -- ['S'] = 'split_with_window_picker',
                        -- ['s'] = 'vsplit_with_window_picker',
                        ['t'] = 'open_tabnew',
                        -- ['<cr>'] = 'open_drop',
                        -- ['t'] = 'open_tab_drop',
                        ['w'] = 'open_with_window_picker',
                        --['P'] = 'toggle_preview', -- enter preview mode, which shows the current node without focusing
                        ['C'] = 'close_node',
                        -- ['C'] = 'close_all_subnodes',
                        ['z'] = 'close_all_nodes',
                        --['Z'] = 'expand_all_nodes',
                        ['a'] = {
                            'add',
                            -- this command supports BASH style brace expansion ('x{a,b,c}' -> xa,xb,xc). see `:h neo-tree-file-actions` for details
                            -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                            config = {
                                show_path = 'none', -- 'none', 'relative', 'absolute'
                            },
                        },
                        ['A'] = 'add_directory', -- also accepts the optional config.show_path option like 'add'. this also supports BASH style brace expansion.
                        ['d'] = 'delete',
                        ['r'] = 'rename',
                        ['y'] = 'copy_to_clipboard',
                        ['x'] = 'cut_to_clipboard',
                        ['p'] = 'paste_from_clipboard',
                        ['c'] = 'copy', -- takes text input for destination, also accepts the optional config.show_path option like 'add':
                        -- ['c'] = {
                        --  'copy',
                        --  config = {
                        --    show_path = 'none' -- 'none', 'relative', 'absolute'
                        --  }
                        --}
                        ['m'] = 'move', -- takes text input for destination, also accepts the optional config.show_path option like 'add'.
                        ['q'] = 'close_window',
                        ['R'] = 'refresh',
                        ['?'] = 'show_help',
                        ['<'] = 'prev_source',
                        ['>'] = 'next_source',
                        ['i'] = 'show_file_details',
                    },
                },

                filesystem = {
                    hijack_netrw_behavior = 'open_default',
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
                    },
                },
            })
        end,
        event = { 'BufReadPre', 'BufNewFile', 'BufEnter' },
        keys = {
            { '<leader>nn', '<cmd>Neotree toggle<cr>', desc = 'Neo-tree Toggle' },
        },
    },
}

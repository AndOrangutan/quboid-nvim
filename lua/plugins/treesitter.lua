return {
    { 'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/playground',
        },
        config = function ()
            local quboid = require('quboid')
            require('nvim-treesitter.configs').setup({
                ensure_installed = 'all',
                auto_install = true,
                highlight = {
                    enable = true,
                    -- additional_vim_regex_highlighting = { "markdown" },
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },

                -- Extensions
                playground = {
                    enable = true,
                    disable = quboid.ft_exclude,
                    keybindings = {
                        toggle_query_editor = 'o',
                        toggle_hl_groups = 'i',
                        toggle_injected_languages = 't',
                        toggle_anonymous_nodes = 'a',
                        toggle_language_display = 'I',
                        focus_language = 'f',
                        unfocus_language = 'F',
                        update = 'R',
                        goto_node = '<cr>',
                        show_help = '?',
                    },
                }
            })
        end,
        keys = {
            { '<leader>tsp,', '<cmd>Tree<cr>', desc = 'Bufferline Cycle Next' },
        },
        event = 'VeryLazy',
        build = ':TSUpdate',
    },
    { 'nvim-treesitter/nvim-treesitter-context',
        config = function ()
            require('treesitter-context').setup({

                enable = true,
                zindex = 1,     -- Prevent conflicts with minimap ;p
            })
        end,
    },
}

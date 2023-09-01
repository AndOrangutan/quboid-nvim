return {
    { 'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'windwp/nvim-ts-autotag',
            'JoosepAlviste/nvim-ts-context-commentstring',
            'RRethy/nvim-treesitter-endwise',
            'nvim-treesitter/playground',
            'nvim-treesitter/nvim-treesitter-textobjects',
            'RRethy/nvim-treesitter-textsubjects',
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
                autotag = {
                    enable = true,
                },
                context_commentstring = {
                    enable = true
                },
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
                },
                endwise = {
                    enable = true,
                },
                textobjects = {
                    enable = true,
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ['agc'] = '@comment.outer',
                            ['igc'] = '@comment.inner',
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                            ['ab'] = '@block.outer',
                            ['ib'] = '@block.inner',
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = { query = '@class.outer', desc = 'Next class start' },
                        },
                        goto_next_end = {
                            [']M'] = '@function.outer',
                            [']['] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer',
                        },
                        goto_previous_end = {
                            ['[M'] = '@function.outer',
                            ['[]'] = '@class.outer',
                        },
                    },
                },
                -- TODO: Config textsubjects correctly
                -- textsubjects = {
                --     enable = true,
                --     prev_selection = ',', -- (Optional) keymap to select the previous selection
                --     keymaps = {
                --         ['<cr>'] = 'textsubjects-smart',
                --         [';'] = 'textsubjects-container-outer',
                --         ['i;'] = 'textsubjects-container-inner',
                --     },
                -- },
            })
        end,
        keys = {
            { '<leader>tsp', '<cmd>TSPlaygroundToggle<cr>', desc = '[t]ree[s]itter [p]layground Toggle' },
            { '<leader>tsc', '<cmd>TSContextToggle<cr>', desc = '[t]ree[s]itter [c]layground Toggle' },
        },
        event = 'VeryLazy',
        build = ':TSUpdate',
    },
    { 'nvim-treesitter/nvim-treesitter-context',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        config = function ()
            require('treesitter-context').setup({

                enable = true,
                zindex = 1,     -- Prevent conflicts with minimap ;p
            })
        end,
    },
    { 'HiPhish/rainbow-delimiters.nvim' }
}

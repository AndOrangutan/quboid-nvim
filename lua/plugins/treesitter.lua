return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring',
            'nvim-treesitter/playground',
        },
        config = function()
            local ft = require('quboid.ft')

            require('nvim-treesitter.configs').setup({
                ensure_installed = 'all',
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { 'markdown', 'tex' },
                },
                indent = { enable = true },

                -- Extensions
                playground = {
                    enable = true,
                    disable = ft.ft_exclude,
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

            })
        end,
        keys = {
            { '<leader>tsp', '<cmd>TSPlaygroundToggle<cr>', desc = '[t]ree[s]itter [p]layground Toggle' },
        },
        event = 'VeryLazy',
        build = ':TSUpdate',
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        config = function()
            require('treesitter-context').setup({
                enable = true,
                zindex = 2, -- Prevent conflicts with minimap ;p
            })
        end,
        event = 'VeryLazy',
        keys = {
            { '<leader>tsc', '<cmd>TSContextToggle<cr>', desc = '[t]ree[s]itter [c]ontext Toggle' },
        },
    },
    {
        'ckolkey/ts-node-action',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {},
        event = 'VeryLazy',
        config = function()
            local null_ls_ok, null_ls = pcall(require, 'null-ls')

            if null_ls_ok then
                null_ls.register({ name = 'more_actions', method = { require 'null-ls'.methods.CODE_ACTION },
                    filetypes = { '_all' }, generator = { fn = require('ts-node-action').available_actions } })
            end
        end,
        keys = {
            { '<leader>na', function() require('ts-node-action').node_action() end, desc = 'TS Node Action' }
        },
    },
}

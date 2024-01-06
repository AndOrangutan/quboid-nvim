---@diagnostic disable: missing-fields
return {

    { 'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring',
            'RRethy/nvim-treesitter-endwise',
            'nvim-treesitter/playground',
            'RRethy/nvim-treesitter-textsubjects',
        },
        config = function ()
            local quboid = require('quboid')

            require('nvim-treesitter.configs').setup({
                ensure_installed = 'all',
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { 'markdown', 'tex' },
                    -- additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },
                -- autotag = { enable = true },

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
                },
                endwise = {
                    enable = true,
                },

            })

            -- require('nvim-ts-autotag').setup()
        end,
        keys = {
            { '<leader>tsp', '<cmd>TSPlaygroundToggle<cr>', desc = '[t]ree[s]itter [p]layground Toggle' },
            { '<leader>tsc', '<cmd>TSContextToggle<cr>', desc = '[t]ree[s]itter [c]layground Toggle' },
        },
        -- event = 'VeryLazy',
        build = ':TSUpdate',
    },
    { 'alvan/vim-closetag' }, -- TODO: add to readme and add in gohtml
    -- { 'windwp/nvim-ts-autotag',
    --     dependencies = "nvim-treesitter/nvim-treesitter",
    --     config = function ()
    --         require('nvim-ts-autotag').setup({
    --             enable = true,
    --             filetypes = { "html" , "xml", "eruby", "erb", "embedded_template" },
    --
    --             enable_rename = true,
    --             enable_close = true,
    --             enable_close_on_slash = true,
    --         })
    --         ---@diagnostic disable-next-line: undefined-global
    --         lvim.builtin.treesitter.autotag.enable = true 
    --     end,
    --     lazy = true,
    --     event = "VeryLazy"
    -- },
    { 'nvim-treesitter/nvim-treesitter-context',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        config = function ()
            require('treesitter-context').setup({
                enable = true,
                zindex = 1,     -- Prevent conflicts with minimap ;p
            })
        end,
    },
    { 'HiPhish/rainbow-delimiters.nvim' },
    { 'ckolkey/ts-node-action',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {},
        event = "VeryLazy",
        config = function ()
            local null_ls_ok, null_ls = pcall(require, 'null-ls')

            if null_ls_ok then
                null_ls.register({ name = 'more_actions', method = { require'null-ls'.methods.CODE_ACTION }, filetypes = { '_all' }, generator = { fn = require('ts-node-action').available_actions } })
            end
        end,
        keys = {
            { '<leader>na', function () require("ts-node-action").node_action() end, desc = 'TS Node Action' }
        },
    },
}

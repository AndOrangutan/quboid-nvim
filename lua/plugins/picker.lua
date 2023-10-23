return {
    { 'stevearc/dressing.nvim',
        opts = {
            input = {
                override = function(conf)
                    conf.col = -1
                    conf.row = 0
                    return conf
                end,
            },
        },
    },
    { 'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
            },
        },
        config = function()
            local telescope = require('telescope')
            telescope.setup{
                defaults = {
                    -- Default configuration for telescope goes here:
                    -- config_key = value,
                    mappings = {
                        i = {
                            ["<C-h>"] = "which_key",
                        }
                    }, 
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--trim" -- add this value
                    },
                    prompt_prefix = "   ",
                    selection_caret = "  ",
                    entry_prefix = " ",
                    initial_mode = "insert",
                    selection_strategy = "reset",
                    sorting_strategy = "ascending",
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                            results_width = 0.8,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 0.95,
                        height = 0.95,
                        preview_cutoff = 120,
                    },
                    border = {},
                    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                },
                pickers = {
                },
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override t ffhe file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    },
                }
            }

            telescope.load_extension('fzf')
            telescope.load_extension('git_worktree')
        end,
        keys = {
            { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Telescope [f]Zf [f]iles' },
            { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Telescope [f]ZF [g]rep' },
            { '<leader>fa', '<cmd>Telescope builtin<cr>', desc = 'Telescope [f]ZF [a]ll' },
            { '<leader>fc', '<cmd>Telescope colorscheme<cr>', desc = 'Telescope [f]ZF [c]olorscheme' },
            { '<leader>fm', '<cmd>Telescope marks<cr>', desc = 'Telescope [f]ZF [m]arks' },
            { '<leader>fk', '<cmd>Telescope keymaps<cr>', desc = 'Telescope [f]ZF [k]eymaps' },
            { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Telescope [f]ZF [b]uffers' },
            { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Telescope [f]ZF [h]elp Tags' },


            -- { '<leader>fh', [[<cmd>lua require("require('telescope.builtin')").help_tags<cr>]], desc = 'Telescope [f]ZF [h]elp Tags' },

        },
        -- event = { 'BufReadPre', 'BufNewFile' },
    },
}

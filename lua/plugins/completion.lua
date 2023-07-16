local quboid = require('quboid')

-- write a function that generates a random function


return {
    { 'L3MON4D3/LuaSnip',
        dependencies = {
            'rafamadriz/friendly-snippets',
            { 'dsznajder/vscode-es7-javascript-react-snippets',
                build = 'yarn install --frozen-lockfile && yarn compile',
            },
        }, 
        version = '1.2.1.*',
        build = 'make install_jsregexp',
        event = 'InsertEnter',
        config = function() require('configs.luasnip') end,
    },
    { 'hrsh7th/nvim-cmp',
        dependencies = {
            'windwp/nvim-autopairs',

            { 'doxnit/cmp-luasnip-choice',
                config = function () require('cmp_luasnip_choice').setup({ auto_open = true }) end,
            },
            {'zbirenbaum/copilot-cmp',
                -- dependencies = 'copilot.lua',
                config = function () 
                    require('copilot_cmp').setup({
                        method = "getCompletionsCycling",
                        formatters = {
                            label = require("copilot_cmp.format").format_label_text,
                            insert_text = require("copilot_cmp.format").remove_existing,
                            preview = require("copilot_cmp.format").deindent,
                        },
                    })
                end,
            },
            'hrsh7th/cmp-path',
            'kdheepak/cmp-latex-symbols',
            'hrsh7th/cmp-calc',

            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'ray-x/cmp-treesitter',
            { 'petertriho/cmp-git',
                dependencies = 'nvim-lua/plenary.nvim',
                config = function () require("cmp_git").setup({ filetypes = quboid.ft_git }) end,
            },
            'hrsh7th/cmp-nvim-lsp-document-symbol',
            { 'David-Kunz/cmp-npm',
                dependencies = 'nvim-lua/plenary.nvim'
            },
            'jcha0713/cmp-tw2css',

            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            -- { 'uga-rosa/cmp-dictionary',
            --     config = function () require('configs.cmp-dictionary') end,
            -- },
            'lukas-reineke/cmp-rg',
        },
        event = 'InsertEnter',
        config = function () require('configs.cmp') end,
    },
}

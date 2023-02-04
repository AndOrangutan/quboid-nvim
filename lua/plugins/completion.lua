return {
        { 'L3MON4D3/LuaSnip',                               -- Snippet Engine for Neovim written in Lua.
            dependencies = {
                'rafamadriz/friendly-snippets',                 -- Set of preconfigured snippets for different languages.
                { 'dsznajder/vscode-es7-javascript-react-snippets', -- Extension for React/Javascript snippets with search supporting ES7+ and babel features 
                    build = 'yarn install --frozen-lockfile && yarn compile',
                },
            },
            event = 'InsertEnter',
            config = function() require('configs.luasnip') end,
        },
        { 'hrsh7th/nvim-cmp',                               -- A completion plugin for Neovim written in Lua. New version of nvim-compe.
            dependencies = {
                'L3MON4D3/LuaSnip',
                'windwp/nvim-autopairs',

                'hrsh7th/cmp-path',                             -- nvim-cmp source for path 
                'kdheepak/cmp-latex-symbols',                   -- Add latex symbol support for nvim-cmp. 
                "hrsh7th/cmp-calc",                             -- nvim-cmp source for math calculation

                'saadparwaiz1/cmp_luasnip',                     -- nvim-cmp source for luasnip.
                'hrsh7th/cmp-nvim-lsp',                         -- nvim-cmp source for neovim builtin LSP client
                'ray-x/cmp-treesitter',                         -- cmp source for treesitter 
                "andersevenrud/cmp-tmux",                       -- Tmux completion source for nvim-cmp and nvim-compe 
                { "petertriho/cmp-git",                         -- Git source for nvim-cmp 
                    dependencies = "nvim-lua/plenary.nvim"
                },
                'hrsh7th/cmp-nvim-lsp-document-symbol',         -- nvim-cmp source for textDocument/documentSymbol via nvim-lsp.
                {'David-Kunz/cmp-npm',                              -- An additional source for nvim-cmp to autocomplete packages and its versions 
                    requires = 'nvim-lua/plenary.nvim'          
                },
                'jcha0713/cmp-tw2css',                          -- A source for nvim-cmp to convert tailwindcss classes to pure css codes
                { 'zbirenbaum/copilot-cmp',                     -- Lua plugin to turn github copilot into a cmp source
                    dependencies = 'zbirenbaum/copilot.lua',
                    config = function () require('configs.copilot-cmp') end,
                },

                'hrsh7th/cmp-buffer',                           -- nvim-cmp source for buffer words 
                'hrsh7th/cmp-cmdline',                          -- nvim-cmp source for vim's cmdline 
                { 'uga-rosa/cmp-dictionary',                    -- nvim-cmp source for dictionary.
                    config = function () require('configs.cmp-dictionary') end,
                },
                'lukas-reineke/cmp-rg',                         -- ripgrep source for nvim-cmp
            },
            -- after = 'LuaSnip',
            config = function() require('configs.cmp') end,
        },
}

return {
    { 'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'windwp/nvim-autopairs',

            'hrsh7th/cmp-nvim-lsp',
        },
        event = 'InsertEnter',
        config = function () require('configs.cmp') end,
    },
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
}

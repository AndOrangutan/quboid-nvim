return {
    {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        dependencies = {
            'rafamadriz/friendly-snippets',
            {
                'dsznajder/vscode-es7-javascript-react-snippets',
                build = 'yarn install --frozen-lockfile && yarn compile',
            },
        },
        build = 'make install_jsregexp',
        event = 'InsertEnter',
        config = function()
            local ls = require('luasnip')

            ls.config.set_config {
                history = true,
                delete_check_events = 'InsertEnter',
            }

            require('quboid.snippets').choice_node_popup()

            require('luasnip.loaders.from_vscode').lazy_load()
            require('luasnip.loaders.from_snipmate').lazy_load()
        end,
    },
}

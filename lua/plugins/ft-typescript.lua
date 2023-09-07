return {
    { 'jose-elias-alvarez/typescript.nvim',
        opts = {
            go_to_source_definition = {
                fallback = true, -- fall back to standard LSP definition on failure
            },
            server = require('lsp.util').gen_config(),
        },
    },
}

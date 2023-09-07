return {
    { 'barrett-ruth/import-cost.nvim',
        build = 'sh install.sh '..require('quboid').ft_javascript_package_manager,
        config = true,
    },
    { 'jose-elias-alvarez/typescript.nvim',
        opts = {
            go_to_source_definition = {
                fallback = true, -- fall back to standard LSP definition on failure
            },
            server = require('lsp.util').gen_config(),
        },
    },
}

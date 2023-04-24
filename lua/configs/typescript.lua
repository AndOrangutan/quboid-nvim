local lsp_util = require('lsp-util')

require('typescript').setup({
    go_to_source_definition = {
        fallback = true, -- fall back to standard LSP definition on failure
    },
    server = {
        on_attach = function (client, bufnr)
            lsp_util.on_attach(client, bufnr)
        end,
    }
})

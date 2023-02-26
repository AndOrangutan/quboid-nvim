local lsp_util = require('lsp-util')

-- local config = lsp_util.create_config()
-- vim.notify("config: " .. vim.inspect(config))

require("typescript").setup({
    go_to_source_definition = {
        fallback = true, -- fall back to standard LSP definition on failure
    },
    -- server = config,
    -- server = {
    --     on_attach = lsp_util.create_on_attach(),
    -- },
})

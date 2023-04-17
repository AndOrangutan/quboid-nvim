local util = require('util')
local quboid = require('quboid')
local lsp_util = require('lsp-util')

local lspconfig = require("lspconfig")

-- Overide border globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or quboid.border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Customize diagnostics also influences lsp_lines
vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = { only_current_line = true },
    -- signs = true,
    underline = true,
    -- update_in_insert = false,
    severity_sort = true,
    float = {
        source = "if_many",
    },
})


-- Customize the sign columns
local signs = { 
    Error = quboid.icons.Error,
    Warn = quboid.icons.Warn,
    Hint = quboid.icons.Hint,
    Info = quboid.icons.Info,
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

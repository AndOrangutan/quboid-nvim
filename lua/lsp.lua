local quboid = require('quboid')
local glance_ok, _ = pcall(require, 'glance')

local M = {}

--- Generate an extended on_atach
---@param ext nil|function (client, bufnr) Extension function tacked on to the end of standard on_attach call.
M.gen_on_attach = function (ext)
    local function on_attach(client, bufnr)
        if type(ext) == 'function' then
            ext(client, bufnr)
        end
    end

    return on_attach
end

--- Generate an extended capabilities table
---@param ext nil|table Custom capabilities to add
M.gen_capabilities = function (ext)
    local cmp_lsp_ok, _ = pcall(require, 'cmp_nvim_lsp')

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    if cmp_lsp_ok then
        capabilities = require('cmp_nvim_lsp').default_capabilities()
    end


    if (type(ext) == 'table') then
        capabilities = vim.tbl_extend('keep', ext or {}, capabilities)
    end

    local moar_capabilities = {
        textdocument = {
            foldingrange = {
                dynamicregistration = false,
                linefoldingonly = true
            },
        },
        offsetencoding = { "utf-16" },
    }
    capabilities = vim.tbl_extend('keep', moar_capabilities or {}, capabilities)

    return capabilities
end

--- Generate LSP config
---@return table config
M.gen_config = function ()
    local config = {
        on_attach = M.gen_on_attach(),
        capabilities = M.gen_capabilities(),
        flags = {
            debounce_text_changes = 80,
            allow_incremental_sync = true,
        },
    }

    return config
end


-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = 'lsp [g]oto [d]efintion', buffer = ev.buf })
        vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { desc = 'lsp [g]oto [t]ype def.', buffer = ev.buf})
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { desc = 'lsp [g]ather [i]mplementation', buffer = ev.buf})
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', { desc = 'lsp [g]ather [r]eferences', buffer = ev.buf})
        if glance_ok then
            vim.keymap.set('n', 'gd', '<cmd>glance definitions<cr>', { desc = 'lsp [g]oto glance [d]efintion', buffer = ev.buf })
            vim.keymap.set('n', 'gt', '<cmd>glance type_definitions<cr>', { desc = 'lsp [g]oto glance [t]ype def.', buffer = ev.buf})
            vim.keymap.set('n', 'gi', '<cmd>glance implementations<cr>', { desc = 'lsp [g]ather glance [i]mplementation', buffer = ev.buf})
            vim.keymap.set('n', 'gr', '<cmd>glance references<cr>', { desc = 'lsp [g]ather glance [r]eferences', buffer = ev.buf})
        end

        -- todo: rebind to something i'll actually use
        -- vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<cr>', { desc = 'lsp [g]oto [d]eclaration', buffer = ev.buf})
        vim.keymap.set('n', 'K', function ()
            local winid = nil
            -- if ufo_ok then winid = require('ufo').peekfoldedlinesundercursor() end
            if not winid then vim.lsp.buf.hover() end
            -- if not winid then require("pretty_hover").hover() end
        end, { desc = 'lsp [k]ick up hover', buffer = ev.buf})
        vim.keymap.set('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { desc = 'lsp signature help', buffer = ev.buf})
        vim.keymap.set('n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', { desc = '[l]sp [w]orkspace [a]dd dir', buffer = ev.buf})
        vim.keymap.set('n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', { desc = '[l]sp [w]orkspace [r]emove dir', buffer = ev.buf})
        vim.keymap.set('n', '<leader>lwl', '<cmd>lua vim.notify(vim.inspect(vim.lsp.buf.remove_workspace_folder()))<cr>', { desc = '[l]sp [w]orkspace [l]ist dir', buffer = ev.buf})
        -- vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = '[l]sp [r]e[n]ame', buffer = ev.buf})
        vim.keymap.set('n', '<leader>rn', function () return ':increname '..vim.fn.expand('<cword>') end, { desc = '[l]sp [r]e[n]ame', expr = true })
        vim.keymap.set('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<cr>', { desc = 'lsp [f]ormat', buffer = ev.buf})
        -- util.keymap('n', '<leader>ca', '<cmd>codeactionmenu<cr>', { desc = 'lsp [c]ode [a]ction', buffer = ev.buf})
        vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = 'lsp [c]ode [a]ction', buffer = ev.buf})
    end,
})

-- Customize diagnostics also influences lsp_lines
vim.diagnostic.config({
    virtual_text = false,
    update_in_insert = false,
    virtual_lines = { only_current_line = true },
    -- signs = true,
    underline = false,
    -- update_in_insert = false,
    severity_sort = true,
    float = {
        source = "always",
    },
})

-- Set icons
local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do kinds[i] = quboid.lsp_kind[i] or kind
end

-- Overide border globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or quboid.border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Customize the sign columns
local signs = {
    Error = quboid.icons.circle_error,
    Warn = quboid.icons.circle_warn,
    Hint = quboid.icons.circle_hint,
    Info = quboid.icons.circle_info,
}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


return M

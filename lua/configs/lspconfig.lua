local lspconfig = require("lspconfig")
local util = require('util')

local masonlsp_ok masonlsp = pcall(require, 'mason-lsp-config')
local lspsig_ok lspsig = pcall(require, 'lsp_signature')
local cmplsp_ok, cmplsp = pcall(require, 'cmp_nvim_lsp')
-- TODO: Install Navic
-- local navic_ok navic = pcall(require, 'lsp_signature')
-- TODO: Use ..._ok to loand sections safely.
-- if not masonlsp_ok then return end

----------------
-- Lsp Config --
----------------

-- Overide border globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or G.quboid_border
    -- opts.border = opts.border or G.quboid_border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Customize diagnostics also influences lsp_lines
vim.diagnostic.config({
    virtual_text = false,
    -- virtual_lines = { only_current_line = true },
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
    Error = G.quboid_icons["error"],
    Warn = G.quboid_icons["warn"],
    Hint = G.quboid_icons["hint"],
    Info = G.quboid_icons["info"],
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


-------------------
-- LSP Signature --
-------------------

-- TODO: Setup proper, removing hint, adding toggle key, adding select key
-- Setup lsp signature
local lspsig_config
if lspsig_ok then
    lspsig_config = {
        bind = true,
        hint_prefix = vim.g.quboid_eol_padding.." ",
        hint_scheme = "Comment",
        hi_parameter = "String",
        doc_lines = 69,
        max_height = 16,
        handler_opts = {
            border = {
                {'╭', 'FloatBorder'}, {'─', 'FloatBorder'}, {'╮', 'FloatBorder'}, {'│', 'FloatBorder'},
                {'╯', 'FloatBorder'}, {'─', 'FloatBorder'}, {'╰', 'FloatBorder'}, {'│', 'FloatBorder'}
            },
        },
    }
    lspsig.setup(lspsig_config)
end

-----------------------------
-- Extend LSP Capabilities --
-----------------------------

local capabilities = vim.lsp.protocol.make_client_capabilities()
if cmplsp_ok then
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
end

---------------
-- On Attach --
---------------

-- Bindings that work without lsp
util.keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float({}, {focus=false})<CR>', '[e]xamine Diagnostics (2x to enter)')
util.keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', 'Goto Prev [d]iagnostic')
util.keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', 'Goto Next [d]iagnostic')

vim.g.quboid_lsp_on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')



    if lspsig_ok then
        lspsig.on_attach(lspsig_config, bufnr)
    end

    vim.keymap.set("n", "<leader>rn", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
    end, { expr = true })

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions


    util.keymap('n', 'gD', vim.lsp.buf.declaration(), { desc = 'Lsp [g]oto [D]eclaration', buffer = bufnr})
    -- TODO: Open in split
    util.keymap('n', 'gd', vim.lsp.buf.definition(), { desc = 'Lsp [g]oto [d]efintion', buffer = bufnr })
    util.keymap('n', 'gr', vim.lsp.buf.references(), { desc = 'Lsp [g]ather [r]eferences', buffer = bufnr})
    util.keymap('n', 'K', vim.lsp.buf.hover(), { desc = 'Lsp [k]ick up Hover', buffer = bufnr})
    util.keymap('n', 'gi', vim.lsp.buf.implementation(), { desc = 'Lsp [g]ather [i]mplementation', buffer = bufnr})
    util.keymap('n', '<c-k>', vim.lsp.buf.signature_help(), { desc = 'Lsp Signature Help', buffer = bufnr})
    util.keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder(), { desc = 'Lsp [w]orkspace [a]dd dir', buffer = bufnr})
    util.keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder(), { desc = 'Lsp [w]orkspace [r]emove dir', buffer = bufnr})
    util.keymap('n', '<leader>wl', vim.notify(vim.inspect(vim.lsp.buf.remove_workspace_folder())), { desc = 'Lsp [w]orkspace [l]ist dir', buffer = bufnr})
    util.keymap('n', '<leader>D', vim.lsp.buf.type_definition(), { desc = 'Lsp Goto Symbol Type Def.', buffer = bufnr})
    util.keymap('n', '<leader>rn', vim.lsp.buf.rename(), { desc = 'Lsp [r]e[n]ame', buffer = bufnr})
    util.keymap('n', '<leader>ca', vim.lsp.buf.code_action(), { desc = 'Lsp [c]ode [a]ction', buffer = bufnr})
    util.keymap('n', '<leader>F', vim.lsp.buf.formatting(), { desc = 'Lsp [F]ormat', buffer = bufnr})

end

if masonlsp_ok then
    masonlsp.setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup({
                on_attach = vim.g.quboid_lsp_on_attach,
                capabilities = capabilities,
                -- handlers = {
                --     ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = 'shadow'}),
                --     ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = vim.g.quboid_border }),
                -- },
            })
        end,
        -- Next, you can provide targeted overrides for specific servers.
        ["sumneko_lua"] = function()
            lspconfig.sumneko_lua.setup {
                on_attach = vim.g.quboid_lsp_on_attach,
                -- handlers = {
                --     ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = 'shadow'}),
                --     ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = vim.g.quboid_border }),
                -- },

                settings = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                    },
                    Lua = {
                        diagnostics = {
                            globals = { "vim" } -- to remove "unknown global 'vim'"
                        }
                    }
                }
            }
        end,
    })

end


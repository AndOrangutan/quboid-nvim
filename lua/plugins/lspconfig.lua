local lspconfig = require("lspconfig")
local wk = require("which-key")
local masonlsp = require("mason-lspconfig")
--local navic = require("nvim-navic")

local G = vim.g

--M.icons = {
--  Class         = " ",
--  Color         = " ",
--  Constant      = " ",
--  Constructor   = " ",
--  Enum          = "了 ",
--  EnumMember    = " ",
--  Field         = " ",
--  File          = " ",
--  Folder        = " ",
--  Function      = " ",
--  Interface     = "ﰮ ",
--  Keyword       = " ",
--  Method        = "ƒ ",
--  Module        = " ",
--  Property      = " ",
--  Snippet       = "﬌ ",
--  Struct        = " ",
--  Text          = " ",
--  Unit          = " ",
--  Value         = " ",
--  Variable      = " ",
--}

-- Overide border globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or G.quboid_border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Customize diagnostics also influences lsp_lines
vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = { only_current_line = true },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        source = "always",
    },
})


-- Customize the sign columns
local signs = { Error = G.quboid_icons["error"], Warn = G.quboid_icons["warn"], Hint = G.quboid_icons["hint"], Info = G.quboid_icons["info"] }

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


local capabilities = require('cmp_nvim_lsp').default_capabilities()
--capabilities.textDocument.foldingRange = {
--    dynamicRegistration = false,
--    lineFoldingOnly = true,
--}


-- only set if lsp is setup
vim.g.quboid_lsp_on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- TODO: Setup ray-x/lsp_signature.nvim
    --require "lsp_signature".on_attach()  -- Note: add in lsp client on-attach
    -- TODO: Setup SmiteshP/nvim-navic
    --if client.server_capabilities.documentSymbolProvider then
    --    navic.attach(client, bufnr)
    --end

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    wk.register({
        ["<space>e"] = { "<cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>", "LSP [e]xamine Diag" },
        ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "LSP Goto Prev Diag" },
        ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "LSP Goto Next Diag" },
        ["<space>q"] = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "LSP Diag Loclist" },

        ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "LSP [g]oto [D]eclaration" },
        ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "LSP [g]oto [d]efinition" },
        ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "LSP Hover" }, -- Go to ufo
        --["<leader>K"] = { function() if not require('ufo').peekFoldedLinesUnderCursor() then vim.lsp.buf.hover() end end, "UFO/LSP Hover Preview" },
        ["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "LSP [g]ather [i]mplementation" },
        --["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "LSP List Impl For Symb" },
        ["<C-k>"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "LSP Signature Helpb" },
        ["<space>wa"] = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "LSP [w]orkspace [a]dd" },
        ["<space>wr"] = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "LSP [w]orkspace [r]emove" },
        ["<space>wl"] = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "LSP [w]orkspace [l]ist", },
        ["<space>D"] = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "LSP Goto Symb Type Def" },
        ["<space>rn"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "LSP [r]e[n]ame" },
        ["<space>ca"] = { "<cmd>CodeActionMenu<CR>", "LSP [c]ode [a]ction" },
        ["gr"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "LSP [g]ather [r]eferences" },
        ["<space>F"] = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "LSP [F]ormat Buffer" },
        -- WARN: This is technically not the most correct way to setup this binding since lsp might not get loaded for some things
    }, { buffer = bufnr })
end


masonlsp.setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup({
            on_attach = vim.g.quboid_lsp_on_attach,
            capabilities = capabilities,
            handlers = {
                ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = vim.g.quboid_border}),
                ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = vim.g.quboid_border }),
            },
        })
    end,
    -- Next, you can provide targeted overrides for specific servers.
    ["sumneko_lua"] = function()
        lspconfig.sumneko_lua.setup {
            on_attach = vim.g.quboid_lsp_on_attach,
            handlers = {
                ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = vim.g.quboid_border}),
                ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = vim.g.quboid_border }),
            },

            settings = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                },
                Lua = {
                    diagnostics = {
                        globals = { "vim" }
                    }
                }
            }
        }
    end,
})

local util = require('util')
local lsp_util = require('lsp-util')
local quboid = require('quboid')

local lspconfig = require("lspconfig")
local lsp_signature_ok, lsp_signature = pcall(require, 'lsp_signature')
local neodev_ok, neodev = pcall(require, 'neodev')
local masonlsp_ok, masonlsp = pcall(require, 'mason-lspconfig')
if not masonlsp_ok then
    return
end

if neodev_ok then
    neodev.setup({})
end
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



-- Bindings that work without lsp
util.keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float({}, {focus=false})<CR>', '[e]xamine Diagnostics (2x to enter)')
util.keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', 'quboid.to Prev [d]iagnostic')
util.keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', 'quboid.to Next [d]iagnostic')
-- Rest of bindings included with lspconfig can be found in lsp-util.lua

masonlsp.setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    -- default handler (optional)

    function(server_name) 
        require("lspconfig")[server_name].setup(lsp_util.new_config())
    end,
    -- Next, you canprovide targeted overrides for specific servers.
    ["jdtls"] = function()
    end,
    -- ["tsserver"] = function()
    -- end,
    ["eslint"] = function()
        local config = lsp_util.new_config()

        config.settings = {
            packageManager = quboid.quboid_ft_javascript_package_manager,
        },

        lspconfig.eslint.setup(config)
    end,
    
    ["lua_ls"] = function()
        lspconfig.lua_ls.setup {
            on_attach = function (client, bufnr) lsp_util.on_attach(client, bufnr) end,
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                    },
                    completion = {
                        callSnippet = "Replace"
                    },
                    diagnostics = {
                        globals = {
                            "vim", -- to remove "unknown global 'vim'"
                            "awesome",
                        }
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                            ["/usr/share/awesome/lib"] = true,
                            require("neodev.config").types(),
                        },
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            }
        }
    end,
})

-- https://www.reddit.com/r/neovim/comments/vdc7uo/enabling_function_call_snippets_with/
-- require('lspconfig').tsserver.setup({
--   settings = {
--     completions = {
--       completeFunctionCalls = true
--     }
--   }
-- })

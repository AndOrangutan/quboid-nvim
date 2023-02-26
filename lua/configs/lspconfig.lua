local lspconfig = require("lspconfig")
local util = require('util')
local lsp_util = require('lsp-util')

local quboid = require('quboid')

local masonlsp_ok, masonlsp = pcall(require, 'mason-lspconfig')
if not masonlsp_ok then
    return
end

----------------
-- Lsp Config --
----------------

-- Overide border globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or quboid.quboid_border
    -- opts.border = opts.border or quboid.quboid_border
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
    Error = quboid.quboid_icons["error"],
    Warn = quboid.quboid_icons["warn"],
    Hint = quboid.quboid_icons["hint"],
    Info = quboid.quboid_icons["info"],
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


-- Goto def in split
-- local function goto_definition(split_cmd)
--   local util = vim.lsp.util
--   local log = require("vim.lsp.log")
--   local api = vim.api
--
--   -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
--   local handler = function(_, result, ctx)
--     if result == nil or vim.tbl_isempty(result) then
--       local _ = log.info() and log.info(ctx.method, "No location found")
--       return nil
--     end
--
--     if split_cmd then
--       vim.cmd(split_cmd)
--     end
--
--     if vim.tbl_islist(result) then
--       util.jump_to_location(result[1])
--
--       if #result > 1 then
--         util.set_qflist(util.locations_to_items(result))
--         api.nvim_command("copen")
--         api.nvim_command("wincmd p")
--       end
--     else
--       util.jump_to_location(result)
--     end
--   end
--
--   return handler
-- end
--
-- vim.lsp.handlers["textDocument/definition"] = goto_definition('vsplit')


-----------------------------
-- Extend LSP Capabilities --
-----------------------------


-- Bindings that work without lsp
util.keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float({}, {focus=false})<CR>', '[e]xamine Diagnostics (2x to enter)')
util.keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', 'quboid.to Prev [d]iagnostic')
util.keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', 'quboid.to Next [d]iagnostic')
-- Rest of bindings included with lspconfig can be found in lsp-util.lua


--if masonlsp_ok then
    masonlsp.setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        -- default handler (optional)

        function(server_name) 
            require("lspconfig")[server_name].setup(lsp_util.create_config())
        end,
        -- Next, you can provide targeted overrides for specific servers.
        ["jdtls"] = function()
        end,
        ["tsserver"] = function()
        end,
        ["eslint"] = function()
            local config = lsp_util.create_config()

            config.settings.packageManager = quboid.quboid_ft_javascript_package_manager,

            lspconfig.eslint.setup(config)
        end,
        ["lua_ls"] = function()
            lspconfig.lua_ls.setup {
                on_attach = lsp_util.create_on_attach(),
                settings = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                    },
                    Lua = {
                        completion = {
                            callSnippet = "Replace"
                        },
                        diagnostics = {
                            globals = { "vim" } -- to remove "unknown global 'vim'"
                        }
                    }
                }
            }
        end,
    })

--end


local M = {}

local util = require('util')

local goto_lsp_ok, goto_lsp = pcall(require, 'goto-preview')
local navic_ok, navic = pcall(require, 'navic')
local cmp_lsp_ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
local ufo_ok, ufo = pcall(require, 'ufo')
local lsp_signature_ok, lsp_signature = pcall(require, 'lsp_signature')

-- Used to generate lsp on attach
M.on_attach = function (client, bufnr)

    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    if navic_ok then
        if client.server_capabilities.documentSymbolProvider then
            navic.attach(client, bufnr)
        end
    end

    if lsp_signature_ok then
        lsp_signature.on_attach({
            bind = true,
            hint_prefix = '',
            hi_parameter = "String",
            -- doc_lines = 10,
            floating_window_above_cur_line = true,
            max_height = 16,
            handler_opts = {
                border = {
                    {'╭', 'FloatBorder'}, {'─', 'FloatBorder'}, {'╮', 'FloatBorder'}, {'│', 'FloatBorder'},
                    {'╯', 'FloatBorder'}, {'─', 'FloatBorder'}, {'╰', 'FloatBorder'}, {'│', 'FloatBorder'}
                },
            },
            select_signature_key = '<M-n>', -- cycle to next signature, e.g. '<M-n>' function overloading
            toggle_key = '<M-x>', -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
        }, bufnr)
    else
        vim.notify('Failed to attach LSP Signature')
    end

    -- LSP Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functionsk
    util.keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = 'Lsp [g]oto [d]efintion', buffer = bufnr })
    util.keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { desc = 'Lsp [g]oto [t]ype Def.', buffer = bufnr})
    util.keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { desc = 'Lsp [g]ather [i]mplementation', buffer = bufnr})
    util.keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', { desc = 'Lsp [g]ather [r]eferences', buffer = bufnr})
    util.keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { desc = 'Lsp [g]oto [D]eclaration', buffer = bufnr})
    util.keymap('n', 'K', function ()
        local winid = nil
        if ufo_ok then winid = require('ufo').peekFoldedLinesUnderCursor() end
        if not winid then vim.lsp.buf.hover() end
    end, { desc = 'Lsp [k]ick up Hover', buffer = bufnr})
    util.keymap('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { desc = 'Lsp Signature Help', buffer = bufnr})
    util.keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', { desc = 'Lsp [w]orkspace [a]dd dir', buffer = bufnr})
    util.keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', { desc = 'Lsp [w]orkspace [r]emove dir', buffer = bufnr})
    util.keymap('n', '<leader>wl', '<cmd>lua vim.notify(vim.inspect(vim.lsp.buf.remove_workspace_folder()))<cr>', { desc = 'Lsp [w]orkspace [l]ist dir', buffer = bufnr})
    util.keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = 'Lsp [r]e[n]ame', buffer = bufnr})
    util.keymap('n', '<leader>F', '<cmd>lua vim.lsp.buf.format()<cr>', { desc = 'Lsp [F]ormat', buffer = bufnr})
    util.keymap('n', '<leader>ca', '<cmd>CodeActionMenu<cr>', { desc = 'Lsp [c]ode [a]ction', buffer = bufnr})
    --util.keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = 'Lsp [c]ode [a]ction', buffer = bufnr})

    if goto_lsp_ok then
        util.keymap('n', 'gpd', '<cmd>lua require("goto-preview").goto_preview_definition()<cr>', { desc = 'Lsp [g]oto [p]review of [d]efintion', buffer = bufnr })
        util.keymap('n', 'gpt', '<cmd>lua require("goto-preview").goto_preview_type_definition()<cr>', { desc = 'Lsp [g]oto [p]review of [t]ype Def.', buffer = bufnr })
        util.keymap('n', 'gpi', '<cmd>lua require("goto-preview").goto_preview_implementation()<cr>', { desc = 'Lsp [g]oto [p]review of [i]mplementation', buffer = bufnr })
        util.keymap('n', 'gpr', '<cmd>lua require("goto-preview").goto_preview_references()<cr>', { desc = 'Lsp [g]oto [p]review of [r]eferences', buffer = bufnr })
        util.keymap('n', 'gpq', '<cmd>lua require("goto-preview").close_all_win()<cr>', { desc = 'Lsp [g]oto Preview Close All Windows', buffer = bufnr })
    end

end

M.new_config = function (extend_on_attach, extend_capabilities)

    local capabilities

    if (type(extend_capabilities) ~= 'table') then
        capabilities = extend_capabilities
    else
        capabilities = vim.lsp.protocol.make_client_capabilities()
    end

    -- cmp lsp
    if cmp_lsp_ok then
        capabilities = vim.tbl_extend('keep', capabilities or {}, cmp_lsp.default_capabilities(capabilities))
    end

    capabilities.offsetEncoding = { "utf-16" }

    local config = {
        capabilities = capabilities,
        on_attach = function (client, bufnr)
            if (type(extend_on_attach) == 'function') then
                extend_on_attach(client, bufnr)
            end
            M.on_attach(client, bufnr)
        end,
        flags = {
            debounce_text_changes = 80,
            allow_incremental_sync = true,
        }
    }

    return config

end

return M

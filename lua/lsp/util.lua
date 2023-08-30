local M = {}

local cmp_lsp_ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
local glance_ok, glance = pcall(require, 'glance')
local ufo_ok, ufo = pcall(require, 'ufo')

-- M.set_keymaps = function (client, bufnr)
M.set_keymaps = function (_, bufnr)
    -- LSP Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functionsk
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = 'Lsp [g]oto [d]efintion', buffer = bufnr })
    vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { desc = 'Lsp [g]oto [t]ype Def.', buffer = bufnr})
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { desc = 'Lsp [g]ather [i]mplementation', buffer = bufnr})
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', { desc = 'Lsp [g]ather [r]eferences', buffer = bufnr})

    if glance_ok then
        vim.keymap.set('n', 'gD', '<cmd>Glance definitions<cr>', { desc = 'Lsp [g]oto Glance [d]efintion', buffer = bufnr })
        vim.keymap.set('n', 'gT', '<cmd>Glance type_definitions<cr>', { desc = 'Lsp [g]oto Glance [t]ype Def.', buffer = bufnr})
        vim.keymap.set('n', 'gI', '<cmd>Glance implementations<cr>', { desc = 'Lsp [g]ather Glance [i]mplementation', buffer = bufnr})
        vim.keymap.set('n', 'gR', '<cmd>Glance references<cr>', { desc = 'Lsp [g]ather Glance [r]eferences', buffer = bufnr})
    end

    -- TODO: Rebind to something I'll actually use
    -- vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { desc = 'Lsp [g]oto [D]eclaration', buffer = bufnr})
    vim.keymap.set('n', 'K', function ()
        local winid = nil
        if not winid then vim.lsp.buf.hover() end
        if ufo_ok then winid = require('ufo').peekFoldedLinesUnderCursor() end
        -- if not winid then require("pretty_hover").hover() end
    end, { desc = 'Lsp [k]ick up Hover', buffer = bufnr})
    vim.keymap.set('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { desc = 'Lsp Signature Help', buffer = bufnr})
    vim.keymap.set('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', { desc = 'Lsp [w]orkspace [a]dd dir', buffer = bufnr})
    vim.keymap.set('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', { desc = 'Lsp [w]orkspace [r]emove dir', buffer = bufnr})
    vim.keymap.set('n', '<leader>wl', '<cmd>lua vim.notify(vim.inspect(vim.lsp.buf.remove_workspace_folder()))<cr>', { desc = 'Lsp [w]orkspace [l]ist dir', buffer = bufnr})
    vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = 'Lsp [r]e[n]ame', buffer = bufnr})
    vim.keymap.set('n', '<leader>F', '<cmd>lua vim.lsp.buf.format()<cr>', { desc = 'Lsp [F]ormat', buffer = bufnr})
    -- util.keymap('n', '<leader>ca', '<cmd>CodeActionMenu<cr>', { desc = 'Lsp [c]ode [a]ction', buffer = bufnr})
    vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = 'Lsp [c]ode [a]ction', buffer = bufnr})
end


M.call_on_attach = function (client, bufnr)


    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Autoformat
    -- if client.supports_method("textDocument/formatting") then
    --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    --     vim.cmd("autocmd BufWritePre lua vim.lsp.buf.format()")
    -- end

    M.set_keymaps(client, bufnr)


end

M.gen_capabilities = function (ext_capabilities)

    local capabilities = {}

    capabilities = vim.lsp.protocol.make_client_capabilities()

    if (type(ext_capabilities) == 'table') then
        capabilities = vim.tbl_extend('keep', capabilities or {}, ext_capabilities)
    end

    -- cmp lsp
    if cmp_lsp_ok then
        capabilities = vim.tbl_extend('keep', capabilities or {}, cmp_lsp.default_capabilities(capabilities))
    end

    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
    }

    capabilities.offsetEncoding = { "utf-16" }

    return capabilities
end

M.gen_config = function ()
    local config = {
        on_attach = function(client, bufnr) M.call_on_attach(client, bufnr) end,
        capabilities = M.gen_capabilities(),
        flags = {
            debounce_text_changes = 80,
            allow_incremental_sync = true,
        },
    }

    return config
end

return M

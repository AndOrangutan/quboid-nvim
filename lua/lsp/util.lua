local M = {}

local quboid = require('quboid')
local lsp_signature_ok, lsp_signature = pcall(require, 'lsp_signature')
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

    -- if glance_ok then
        vim.keymap.set('n', 'gD', '<cmd>Glance definitions<cr>', { desc = 'Lsp [g]oto Glance [d]efintion', buffer = bufnr })
        vim.keymap.set('n', 'gT', '<cmd>Glance type_definitions<cr>', { desc = 'Lsp [g]oto Glance [t]ype Def.', buffer = bufnr})
        vim.keymap.set('n', 'gI', '<cmd>Glance implementations<cr>', { desc = 'Lsp [g]ather Glance [i]mplementation', buffer = bufnr})
        vim.keymap.set('n', 'gR', '<cmd>Glance references<cr>', { desc = 'Lsp [g]ather Glance [r]eferences', buffer = bufnr})
    -- end

    -- TODO: Rebind to something I'll actually use
    -- vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { desc = 'Lsp [g]oto [D]eclaration', buffer = bufnr})
    vim.keymap.set('n', 'K', function ()
        local winid = nil
        if ufo_ok then winid = require('ufo').peekFoldedLinesUnderCursor() end
        if not winid then vim.lsp.buf.hover() end
        -- if not winid then require("pretty_hover").hover() end
    end, { desc = 'Lsp [k]ick up Hover', buffer = bufnr})
    vim.keymap.set('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { desc = 'Lsp Signature Help', buffer = bufnr})
    vim.keymap.set('n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', { desc = '[l]sp [w]orkspace [a]dd dir', buffer = bufnr})
    vim.keymap.set('n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', { desc = '[l]sp [w]orkspace [r]emove dir', buffer = bufnr})
    vim.keymap.set('n', '<leader>lwl', '<cmd>lua vim.notify(vim.inspect(vim.lsp.buf.remove_workspace_folder()))<cr>', { desc = '[l]sp [w]orkspace [l]ist dir', buffer = bufnr})
    -- vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = '[l]sp [r]e[n]ame', buffer = bufnr})
    vim.keymap.set('n', '<leader>rn', function () return ':IncRename '..vim.fn.expand('<cword>') end, { desc = '[l]sp [r]e[n]ame', expr = true })
    vim.keymap.set('n', '<leader>F', '<cmd>lua vim.lsp.buf.format()<cr>', { desc = 'Lsp [F]ormat', buffer = bufnr})
    -- util.keymap('n', '<leader>ca', '<cmd>CodeActionMenu<cr>', { desc = 'Lsp [c]ode [a]ction', buffer = bufnr})
    vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = 'Lsp [c]ode [a]ction', buffer = bufnr})


end

M.call_on_attach = function (client, bufnr)

    local methods = vim.lsp.protocol.Methods
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Autoformat
    -- if client.supports_method("textDocument/formatting") then
    --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    --     vim.api.nvim_create_autocmd("BufWritePre", {
    --         pattern = "*",
    --         callback = function()
    --             vim.lsp.buf.format()
    --         end,
    --     })
    -- end

    M.set_keymaps(client, bufnr)

    if lsp_signature_ok then
        lsp_signature.on_attach({}, bufnr)
    end

    -- Extra highlights.

    local md_namespace = vim.api.nvim_create_namespace 'mariasolos/lsp_float'

    ---LSP handler that adds extra inline highlights, keymaps, and window options.
    ---Code inspired from `noice`.
    ---@param handler fun(err: any, result: any, ctx: any, config: any): integer, integer
    ---@return function
    local function enhanced_float_handler(handler)
        return function(err, result, ctx, config)
            local buf, win = handler(
                err,
                result,
                ctx,
                vim.tbl_deep_extend('force', config or {}, {
                    border = quboid.border_float,
                    max_height = math.floor(vim.o.lines * 0.5),
                    max_width = math.floor(vim.o.columns * 0.4),
                })
            )

            if not buf or not win then
                return
            end

            -- Conceal everything.
            vim.wo[win].concealcursor = 'n'

            -- Extra highlights.
            for l, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
                for pattern, hl_group in pairs {
                    ['|%S-|'] = '@text.reference',
                    ['@%S+'] = '@parameter',
                    ['^%s*(Parameters:)'] = '@text.title',
                    ['^%s*(Return:)'] = '@text.title',
                    ['^%s*(See also:)'] = '@text.title',
                    ['{%S-}'] = '@parameter',
                } do
                    local from = 1 ---@type integer?
                    while from do
                        local to
                        from, to = line:find(pattern, from)
                        if from then
                            vim.api.nvim_buf_set_extmark(buf, md_namespace, l - 1, from - 1, {
                                end_col = to,
                                hl_group = hl_group,
                            })
                        end
                        from = to and to + 1 or nil
                    end
                end
            end

            -- Add keymaps for opening links.
            if not vim.b[buf].markdown_keys then
                vim.keymap.set('n', 'K', function()
                    -- Vim help links.
                    local url = (vim.fn.expand '<cWORD>' --[[@as string]]):match '|(%S-)|'
                    if url then
                        return vim.cmd.help(url)
                    end

                    -- Markdown links.
                    local col = vim.api.nvim_win_get_cursor(0)[2] + 1
                    local from, to
                    from, to, url = vim.api.nvim_get_current_line():find '%[.-%]%((%S-)%)'
                    if from and col >= from and col <= to then
                        vim.system({ 'open', url }, nil, function(res)
                            if res.code ~= 0 then
                                vim.notify('Failed to open URL' .. url, vim.log.levels.ERROR)
                            end
                        end)
                    end
                end, { buffer = buf, silent = true })
                vim.b[buf].markdown_keys = true
            end
        end
    end

    vim.lsp.handlers[methods.textDocument_hover] = enhanced_float_handler(vim.lsp.handlers.hover)
    vim.lsp.handlers[methods.textDocument_signatureHelp] = enhanced_float_handler(vim.lsp.handlers.signature_help)
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with( vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,

        -- update_in_insert = false,
        -- virtual_lines = { only_current_line = true },
        -- -- signs = true,
        -- underline = false,
        -- -- update_in_insert = false,
        -- severity_sort = true,
        -- float = {
        --     source = "always",
        -- },
    })
end

M.gen_capabilities = function (ext_capabilities)

    local capabilities = vim.lsp.protocol.make_client_capabilities()


    -- cmp lsp 
    if cmp_lsp_ok then
        capabilities = require('cmp_nvim_lsp').default_capabilities()
    end

    if (type(ext_capabilities) == 'table') then
        capabilities = vim.tbl_extend('keep', capabilities or {}, ext_capabilities)
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

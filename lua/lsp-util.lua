local M = {}

local util = require('util')
local quboid = require('quboid')

local cmplsp_ok, cmplsp = pcall(require, 'cmp_nvim_lsp')
local lspsig_ok, lspsig = pcall(require, 'lsp_signature')
local wk_ok, wk = pcall(require, 'which-key')
local ufo_ok, ufo = pcall(require, 'ufo')
local gotodef_ok, gotodef = pcall(require, 'goto-preview')
local null_ls_ok, null_ls = pcall(require, 'null-ls')
local codeaction_ok, codeaction = pcall(require, 'nvim-code-action-menu')
local lsp_lines_ok, lsp_lines = pcall(require, 'lsp_lines')


local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end


-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Extend On attach by providing a function(client, buffer)
M.create_on_attach = function (extend_on_attach)

    
    local on_attach  = function (client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


        -- if null_ls_ok then
        --     if client.supports_method("textDocument/formatting") then
        --         -- vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        --         -- vim.api.nvim_create_autocmd("BufWritePre", {
        --         --     group = augroup,
        --         --     buffer = bufnr,
        --         --     callback = function()
        --         --         lsp_formatting(bufnr)
        --         --     end,
        --         -- })
        --         
        --     end
        -- end

        if (type(extend_on_attach)=='function') then
            extend_on_attach(client, bufnr)
        end

        -- LSP Signature
        if lspsig_ok and wk_ok then
            lspsig.on_attach({
                bind = true,
                -- hint_prefix = quboid.quboid_eol_padding.." ",
                hint_prefix = '',
                hint_scheme = "Comment",
                hi_parameter = "String",
                doc_lines = 10,
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

            wk.register({
                ['<M-x>'] = { 'LSP Signature Toggle' },
                ['<M-n>'] = { 'LSP Signature Cycle' },
            },{})
        else
            vim.notify('Failed to attach LSP Signature')
        end


        -- LSP Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        -- TODO: Open in split
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

        if lsp_lines_ok then
            util.keymap('n', '<leader>ll', '<cmd>lua require("lsp_lines").toggle()<cr>', { desc = '[L]sp [l]ines Toggle', buffer = bufnr})
        end

        if gotodef_ok then
            util.keymap('n', 'gpd', '<cmd>lua require("goto-preview").goto_preview_definition()<cr>', { desc = 'Lsp [g]oto [p]review of [d]efintion', buffer = bufnr })
            util.keymap('n', 'gpt', '<cmd>lua require("goto-preview").goto_preview_type_definition()<cr>', { desc = 'Lsp [g]oto [p]review of [t]ype Def.', buffer = bufnr })
            util.keymap('n', 'gpi', '<cmd>lua require("goto-preview").goto_preview_implementation()<cr>', { desc = 'Lsp [g]oto [p]review of [i]mplementation', buffer = bufnr })
            util.keymap('n', 'gpr', '<cmd>lua require("goto-preview").goto_preview_references()<cr>', { desc = 'Lsp [g]oto [p]review of [r]eferences', buffer = bufnr })
            util.keymap('n', 'gpq', '<cmd>lua require("goto-preview").close_all_win()<cr>', { desc = 'Lsp [g]oto Preview Close All Windows', buffer = bufnr })
        end

    end



    return on_attach
end

M.create_config = function (extend_on_attach)

    local on_attach

    if (type(extend_on_attach)=='function') then
        on_attach = M.create_on_attach(extend_on_attach)
    else
        on_attach = M.create_on_attach()
    end

    -- Extend LSP Capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- Ultra FOlds in Neovim
    if ufo_ok then
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }
    end

    -- cmp lsp
    if cmplsp_ok then
        capabilities = cmplsp.default_capabilities(capabilities)
    end

    -- Create config
    local config = {
        handlers = {
            -- ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = quboid.quboid_border}),
            -- ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = quboid.quboid_border }),
        },
        capabilities = capabilities,

        on_attach = on_attach,
        settings = {},
        init_options = {},
        flags = {
            debounce_text_changes = 80,
            allow_incremental_sync = true,
        }

    }

    if ufo_ok then
        local handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = ('   %d '):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    local hlGroup = chunk[2]
                    table.insert(newVirtText, {chunkText, hlGroup})
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    -- str width returned from truncate() may less than 2nd argument, need padding
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, {suffix, 'MoreMsg'})
            return newVirtText
        end

        ufo.setup({
            close_fold_kinds = {'comment', 'imports'},
            -- close_fold_kinds = {'comment', 'imports', 'region'},
            fold_virt_text_handler = handler,
            preview = {
                win_config = {
                    border = quboid.quboid_border_float,
                },
                mappings = {
                    scrollU = '<C-u>',
                    scrollD = '<C-d>'
                },
            },
        })


        util.keymap('n', 'zR', require('ufo').openAllFolds, 'Open All Folds')
        util.keymap('n', 'zM', require('ufo').closeAllFolds, 'Close All Folds')
    end

    return config
end


return M

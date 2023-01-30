local M = {}

local util = require('util')

local cmplsp_ok, cmplsp = pcall(require, 'cmp_nvim_lsp')
local lspsig_ok, lspsig = pcall(require, 'lsp_signature')
local wk_ok, wk = pcall(require, 'which-key')


-- extend = fun(client, bufnr)
M.create_on_attach = function (extend)
    -- Enable completion triggered by <c-x><c-o>

    --
    local on_attach  = function (client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


        if (type(extend)=='function') then
            extend(client, bufnr)
        end

        -- LSP Signature
        if lspsig_ok and wk_ok then
            lspsig.on_attach({
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
                select_signature_key = '<M-n>', -- cycle to next signature, e.g. '<M-n>' function overloading
                toggle_key = '<M-x>', -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
            }, bufnr)
            wk.register({
                ['<M-x>'] = { 'LSP Signature Toggle' },
                ['<M-n>'] = { 'LSP Signature Cycle' },
            })
            -- TODO: Setup bindings to toggle signature
        else
            vim.notify('Failed to attach LSP Signature')
        end

        -- LSP Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        util.keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { desc = 'Lsp [g]oto [D]eclaration', buffer = bufnr})
        -- TODO: Open in split
        util.keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = 'Lsp [g]oto [d]efintion', buffer = bufnr })
        util.keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', { desc = 'Lsp [g]ather [r]eferences', buffer = bufnr})
        util.keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = 'Lsp [k]ick up Hover', buffer = bufnr})
        util.keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { desc = 'Lsp [g]ather [i]mplementation', buffer = bufnr})
        util.keymap('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { desc = 'Lsp Signature Help', buffer = bufnr})
        util.keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', { desc = 'Lsp [w]orkspace [a]dd dir', buffer = bufnr})
        util.keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', { desc = 'Lsp [w]orkspace [r]emove dir', buffer = bufnr})
        util.keymap('n', '<leader>wl', '<cmd>lua vim.notify(vim.inspect(vim.lsp.buf.remove_workspace_folder()))<cr>', { desc = 'Lsp [w]orkspace [l]ist dir', buffer = bufnr})
        util.keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { desc = 'Lsp vim.g.to Symbol Type Def.', buffer = bufnr})
        util.keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = 'Lsp [r]e[n]ame', buffer = bufnr})
        util.keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = 'Lsp [c]ode [a]ction', buffer = bufnr})
        util.keymap('n', '<leader>F', '<cmd>lua vim.lsp.buf.formatting()<cr>', { desc = 'Lsp [F]ormat', buffer = bufnr})

    end



    return on_attach
end

M.create_config = function (custom_on_attach)
    local on_attach
    if not custom_on_attach then
        on_attach = M.create_on_attach()
    else
        on_attach = custom_on_attach
    end

    -- Extend LSP Capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- cmp lsp
    if cmplsp_ok then
        capabilities = cmplsp.default_capabilities(capabilities)
    end

    -- Create config
    local config = {
        handlers = {},
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {},
        init_options = {},
        flags = {
            debounce_text_changes = 80,
            allow_incremental_sync = true,
        }

    }

    return config
end


return M

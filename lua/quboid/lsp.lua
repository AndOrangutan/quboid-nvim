local M = {}

local icons = require('quboid.icons')
local quboid = require('quboid')

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local glance_ok, _ = pcall(require, 'glance')
        local actions_preview_ok, _ = pcall(require, 'glance')

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>',
            { desc = 'LSP [g]oto [t]ype def.', buffer = ev.buf })
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>',
            { desc = 'LSP [g]oto [d]efintion', buffer = ev.buf })
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>',
            { desc = 'LSP [g]ather [i]mplementation', buffer = ev.buf })
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>',
            { desc = 'LSP [g]ather [r]eferences', buffer = ev.buf })
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>',
            { desc = 'LSP [g]et [s]ignature', buffer = ev.buf })

        -- todo: rebind to something i'll actually use
        -- vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<cr>', { desc = 'lsp [g]oto [d]eclaration', buffer = ev.buf})
        vim.keymap.set('n', 'K', function()
            local winid = nil
            -- if ufo_ok then winid = require('ufo').peekfoldedlinesundercursor() end
            if not winid then
                vim.lsp.buf.hover()
            end
            -- if not winid then require("pretty_hover").hover() end
        end, { desc = 'LSP [k]ick up hover', buffer = ev.buf })
        vim.keymap.set('n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>',
            { desc = '[l]SP [w]orkspace [a]dd dir', buffer = ev.buf })
        vim.keymap.set('n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>',
            { desc = '[l]SP [w]orkspace [r]emove dir', buffer = ev.buf })
        vim.keymap.set('n', '<leader>lwl', '<cmd>lua vim.notify(vim.inspect(vim.lsp.buf.remove_workspace_folder()))<cr>',
            { desc = '[l]SP [w]orkspace [l]ist dir', buffer = ev.buf })
        -- vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = '[l]sp [r]e[n]ame', buffer = ev.buf})
        vim.keymap.set('n', '<leader>rn', function() return ':IncRename ' .. vim.fn.expand('<cword>') end,
            { desc = 'LSP [r]e[n]ame', expr = true })
        vim.keymap.set('n', '<leader>F', '<cmd>lua vim.lsp.buf.format({ async = true })<cr>',
            { desc = 'LSP [f]ormat', buffer = ev.buf })
        vim.keymap.set('n', '<leader>ca', '<cmd>FzfLua lsp_code_actions<cr>',
            { desc = 'LSP [c]ode [a]ction', buffer = ev.buf })

        -- -- Float on hold
        -- vim.o.updatetime = 500
        -- vim.api.nvim_create_autocmd('CursorHold', {
        --     buffer = ev.buf,
        --     callback = function()
        --         local opts = {
        --             focus = false,
        --             close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
        --             -- prefix = ' ',
        --             scope = 'cursor',
        --         }
        --         vim.diagnostic.open_float({}, opts)
        --     end
        -- })
    end,
})

-- Customize diagnostics
vim.diagnostic.config({
    virtual_text = false,
    update_in_insert = true,
    -- signs = true,
    underline = true,
    severity_sort = true,
    float = {
        source = 'always',
    },
})

-- Set icons
local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
    kinds[i] = icons.lsp_kind[i] or kind
end

-- Overide border globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or quboid.border
    opts.max_width = opts.max_width or 160
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Customize the sign columns
local signs = {
    Error = icons.gen.circle_error,
    Warn = icons.gen.circle_warn,
    Hint = icons.gen.circle_hint,
    Info = icons.gen.circle_info,
}
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/lsp.lua
local md_namespace = vim.api.nvim_create_namespace('mariasolos/lsp_float')

--- Adds extra inline highlights to the given buffer.
---@param buf integer
local function add_inline_highlights(buf)
    for l, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
        for pattern, hl_group in pairs({
            ['@%S+'] = '@parameter',
            ['^%s*(Parameters:)'] = '@text.title',
            ['^%s*(Return:)'] = '@text.title',
            ['^%s*(See also:)'] = '@text.title',
            ['{%S-}'] = '@parameter',
        }) do
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
end

--- LSP handler that adds extra inline highlights, keymaps, and window options.
--- Code inspired from `noice`.
---@param handler fun(err: any, result: any, ctx: any, config: any): integer?, integer?
---@param border string|nil Border style
---@return fun(err: any, result: any, ctx: any, config: any)
local function enhanced_float_handler(handler, border)
    return function(err, result, ctx, config)
        if border == nil then
            border = quboid.border
        end
        local bufnr, winnr = handler(
            err,
            result,
            ctx,
            vim.tbl_deep_extend('force', config or {}, {
                border = border,
                max_height = math.floor(vim.o.lines * 0.5),
                max_width = math.floor(vim.o.columns * 0.4),
            })
        )

        if not bufnr or not winnr then
            return
        end

        -- Conceal everything.
        vim.wo[winnr].concealcursor = 'n'

        -- Extra highlights.
        add_inline_highlights(bufnr)

        -- Add keymaps for opening links.
        if not vim.b[bufnr].markdown_keys then
            vim.keymap.set('n', 'K', function()
                -- Vim help links.
                local url = (vim.fn.expand('<cWORD>') --[[@as string]]):match('|(%S-)|')
                if url then
                    return vim.cmd.help(url)
                end

                -- Markdown links.
                local col = vim.api.nvim_win_get_cursor(0)[2] + 1
                local from, to
                from, to, url = vim.api.nvim_get_current_line():find('%[.-%]%((%S-)%)')
                if from and col >= from and col <= to then
                    vim.system({ 'open', url }, nil, function(res)
                        if res.code ~= 0 then
                            vim.notify('Failed to open URL' .. url, vim.log.levels.ERROR)
                        end
                    end)
                end
            end, { buffer = bufnr, silent = true })
            vim.b[bufnr].markdown_keys = true
        end
    end
end

vim.lsp.handlers['textDocument/hover'] = enhanced_float_handler(vim.lsp.handlers.hover, require('quboid').border)
vim.lsp.handlers['textDocument/signatureHelp'] = enhanced_float_handler(vim.lsp.handlers.signature_help,
    require('quboid').border)

--- HACK: Override `vim.lsp.util.stylize_markdown` to use Treesitter.
---@param bufnr integer
---@param contents string[]
---@param opts table
---@return string[]
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.util.stylize_markdown = function(bufnr, contents, opts)
    contents = vim.lsp.util._normalize_markdown(contents, {
        width = vim.lsp.util._make_floating_popup_size(contents, opts),
    })
    vim.bo[bufnr].filetype = 'markdown'
    vim.treesitter.start(bufnr)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)

    add_inline_highlights(bufnr)

    return contents
end

--- Generate an extended capabilities table
---@param ext nil|table Custom capabilities to add
M.gen_capabilities = function(ext)
    local cmp_lsp_ok, _ = pcall(require, 'cmp_nvim_lsp')

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    if cmp_lsp_ok then
        capabilities = require('cmp_nvim_lsp').default_capabilities()
    end

    if type(ext) == 'table' then
        capabilities = vim.tbl_extend('keep', ext or {}, capabilities)
    end

    local moar_capabilities = {
        textdocument = {
            foldingrange = {
                denamicregistration = false,
                linefoldingonly = true,
            },
        },
        offsetencoding = { 'utf-16' },
    }
    capabilities = vim.tbl_extend('keep', moar_capabilities or {}, capabilities)

    return capabilities
end

--- Generate LSP config
---@return table config
M.gen_config = function()
    local config = {
        capabilities = M.gen_capabilities(),
        flags = {
            debounce_text_changes = 80,
            allow_incremental_sync = true,
        },
    }

    return config
end

return M

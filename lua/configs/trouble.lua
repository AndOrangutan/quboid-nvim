local quboid = require('quboid')
local util = require('util')

local wk_ok, wk = pcall(require, 'which-key')

require('trouble').setup({
    padding = false,
    auto_preview = false,
    indent_lines = false,
    action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" }, -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        open_tab = { "<c-t>" }, -- open buffer in new tab
        jump_close = {"o"}, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = {"zM", "zm"}, -- close all folds
        open_folds = {"zR", "zr"}, -- open all folds
        toggle_fold = {"zA", "za"}, -- toggle fold of current file
        previous = "k", -- previous item
        next = "j" -- next item
    },
    -- signs = {
    --     -- icons / text used for a diagnostic
    --     error = quboid.icons.Error,
    --     warning = quboid.icons.Warn,
    --     hint = quboid.icons.Hint,
    --     information = quboid.icons.Info,
    --     other = quboid.icons.Ok,
    -- },
    use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
})

util.keymap('n', '<leader>xx', '<cmd>TroubleToggle<cr>', 'Trouble Toggle E[x]plorer E[x]tensive (workspace)')
util.keymap('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Trouble E[x]plore [w]orkspace Diagnostics')
util.keymap('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', 'Trouble E[x]plore [d]ocument Diagnostics')
-- TODO: Look into quickfix and loclist
util.keymap('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>', 'Trouble E[x]plore [q]uickfix Diagnostics')
util.keymap('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>', 'Trouble E[x]plore [l]oclist Diagnostics')

if wk_ok then
    wk.register({
        ["<leader>x"] = { name = "Trouble E[x]plore Diagnostics" },
    },{})
end

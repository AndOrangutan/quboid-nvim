local util = require('util')
local quboid = require('quboid')

local ufo = require('ufo')

vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- TODO: Setup with signcolumn and ufo

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
-- Config moved to util-lsp.lua


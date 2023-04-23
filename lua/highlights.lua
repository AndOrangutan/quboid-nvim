local util = require('util')

local lualine_ok, lualine = pcall(require, 'lualine')

vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = function()

        vim.api.nvim_set_hl(0, 'CursorLineNr', {link = 'Normal' })

        vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {link = 'CmpItemKindString'})

        vim.api.nvim_set_hl(0, 'FoldColumn', {link = 'Normal'})

        -- HACK: to change borders to solid by default
        vim.api.nvim_set_hl(0, 'FloatBorder', { fg = util.get_hl_val('NormalFloat', 'background'), bg = util.get_hl_val('NormalFloat', 'background') })


        vim.api.nvim_set_hl(0, 'CodiVirtualText', {link = 'Comment'})
        vim.api.nvim_set_hl(0, 'MiniMapNormal', {link = 'Comment'})
        vim.api.nvim_set_hl(0, 'MiniIndentscopePrefix', {link = 'Comment'})
        vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', {link = 'Comment'})
        vim.api.nvim_set_hl(0, 'ReverseSearch', { fg = util.get_hl_val('Search', 'background'), bg = util.get_hl_val('Normal', 'background') })
        vim.api.nvim_set_hl(0, 'StatusLineNCSearch', { fg = util.get_hl_val('Search', 'background'), bg = util.get_hl_val('StatusLineNC', 'background') })
        vim.api.nvim_set_hl(0, 'StatusLineNCVisual', { fg = util.get_hl_val('Constant', 'foreground'), bg = util.get_hl_val('StatusLineNC', 'background') })
        vim.api.nvim_set_hl(0, 'StatusLineNCComment', { fg = util.get_hl_val('Comment', 'foreground'), bg = util.get_hl_val('StatusLineNC', 'background') })

        vim.api.nvim_set_hl(0, 'EyelinerPrimary', { bold = true, underline = true })
        vim.api.nvim_set_hl(0, 'EyelinerSecondary', { underline = true })


        vim.api.nvim_set_hl(0, 'TreesitterContext', {link = 'Normal'})
        vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', {link = 'Normal'})

    end,
})

vim.o.background = 'dark'
vim.cmd('colorscheme onedark')

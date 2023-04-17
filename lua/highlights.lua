
-- sauce https://www.reddit.com/r/neovim/comments/oxddk9/how_do_i_get_the_value_from_a_highlight_group/
function get_hl_val(name,val)
    local ok, hl = pcall(vim.api.nvim_get_hl_by_name, name, true)
    if not ok then
        return
    end
    return string.format("#%06x",hl[val])
end

vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = function()
        vim.api.nvim_set_hl(0, 'CursorLineNr', {link = 'Normal' })

        vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {link = 'CmpItemKindString'})

        vim.api.nvim_set_hl(0, 'FoldColumn', {link = 'Normal'})

        -- HACK: to change borders to solid by default
        vim.api.nvim_set_hl(0, 'FloatBorder', { fg = get_hl_val('NormalFloat', 'background'), bg = get_hl_val('NormalFloat', 'background') })


        vim.api.nvim_set_hl(0, 'CodiVirtualText', {link = 'Comment'})
        vim.api.nvim_set_hl(0, 'MiniMapNormal', {link = 'Comment'})
        vim.api.nvim_set_hl(0, 'MiniIndentscopePrefix', {link = 'Comment'})
        vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', {link = 'Comment'})
        vim.api.nvim_set_hl(0, 'ReverseSearch', { fg = get_hl_val('Search', 'background'), bg = get_hl_val('Normal', 'background') })

        vim.api.nvim_set_hl(0, 'EyelinerPrimary', { bold = true, underline = true })
        vim.api.nvim_set_hl(0, 'EyelinerSecondary', { underline = true })


        vim.api.nvim_set_hl(0, 'TreesitterContext', {link = 'Normal'})
        vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', {link = 'Normal'})
    end,
})

vim.o.background = 'dark'
vim.cmd('colorscheme onedark')

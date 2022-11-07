
vim.cmd[[colorscheme onedark]]


vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = function()
        vim.api.nvim_set_hl(0, "CodiVirtualText", {link = "Comment"})
        vim.api.nvim_set_hl(0, "MiniMapNormal", {link = "Comment"})
        vim.api.nvim_set_hl(0, "MiniIndentscopePrefix", {link = "Comment"})
        vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", {link = "Comment"})
        vim.api.nvim_set_hl(0, "ReverseSearch", { link = "Search", reverse = true })

        vim.api.nvim_set_hl(0, 'EyelinerPrimary', { bold = true, underline = true })
        vim.api.nvim_set_hl(0, 'EyelinerSecondary', { underline = true })


    end,
})

require('eyeliner').setup({
    highlight_on_key = true,
    -- dim = false 
})

-- Update colors on colorscheme change
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    vim.api.nvim_set_hl(0, 'EyelinerPrimary', { bold = true, underline = true })
  end,
})

require('symbols-outline').setup({
    auto_close = true,
    relative_width = false,
    width  = 40,

})

vim.cmd[[autocmd FileType Outline setlocal signcolumn=no]]

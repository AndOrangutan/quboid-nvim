return {
    { 'navarasu/onedark.nvim',
        config = function () 
            require('onedark').setup({
                code_style = {
                    comments = 'italic',
                    keywords = 'italic,bold',
                    functions = 'bold',
                    strings = 'italic',
                    variables = 'none'
                },
                lualine = {
                    transparent = false, -- lualine center bar transparency
                },
                diagnostics = {
                    undercurl = false,
                }
            })
        end,
        lazy = true,
    }
}

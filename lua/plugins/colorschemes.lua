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
        priority = 1000,
    },
    { 'neanias/everforest-nvim',
        priority = 1000,
    },
    { 'rebelot/kanagawa.nvim',
        priority = 1000,
    },
    { "Shatur/neovim-ayu",
        config = function()
            require('ayu').setup({ mirage = true })
        end,
        priority = 1000,
    },
}

return {
    { 'navarasu/onedark.nvim',
        opts = {
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
        },
        lazy = true,
    },
    { 'neanias/everforest-nvim',
        lazy = true,
    },
    { 'rebelot/kanagawa.nvim',
        lazy = true,
    },
    { "Shatur/neovim-ayu",
        config = function()
            require('ayu').setup({ mirage = true })
        end,
        lazy = true,
        priority = 1000,
    },
}

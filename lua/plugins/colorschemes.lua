return {
    { 'rktjmp/lush.nvim' },
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
        priority = 1000,
    },
    { 'neanias/everforest-nvim',
        config = function () require('everforest').setup() end,
        priority = 1000,
    },
    { 'rebelot/kanagawa.nvim',
        config = function () require('kanagawa').setup() end,
        priority = 1000,
    },
    { "Shatur/neovim-ayu",
        config = function()
            require('ayu').setup({ mirage = true })
        end,
        priority = 1000,
    },
    { 'scysta/pink-panic.nvim' },
}

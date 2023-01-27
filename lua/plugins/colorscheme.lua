return {
    { 'navarasu/onedark.nvim',                          -- One dark and light colorscheme for neovim >= 0.5.0 written in lua based on Atom's One Dark and Light theme. Additionally, it comes with 5 color variant styles
        config = function () require('configs.onedark') end,
    },

    { 'neanias/everforest-nvim' },                     -- Lua port: A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favourite languages.
}

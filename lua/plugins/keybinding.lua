return { 
    { 'folke/which-key.nvim',                   -- Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing.
        config = function ()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require('which-key').setup()
        end
    },
}

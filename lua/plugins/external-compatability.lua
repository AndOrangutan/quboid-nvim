return {
    -- TODO: Properly remove tmux.nvim
    -- { 'aserowy/tmux.nvim',                              -- Tmux integration for Neovim features pane movement and resizing from within Neovim.
    --     config = function() require('configs.tmux') end,
    -- },
    { 'numToStr/Navigator.nvim',                        -- Smoothly navigate between neovim and terminal multiplexer(s)
        config = function () require('configs.navigator') end,
    },
}

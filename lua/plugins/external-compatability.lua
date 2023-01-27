return {
    { 'aserowy/tmux.nvim',                              -- Tmux integration for Neovim features pane movement and resizing from within Neovim.
        config = function() require('configs.tmux') end,
    },
}

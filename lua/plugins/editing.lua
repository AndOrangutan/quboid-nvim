return {
    -- TODO: install vim-visual-multi
    -- { 'mg979/vim-visual-multi' }                        -- Multiple cursor plugin fot vim/neovim}
    -- TODO: add TS support with pre_hook
    { 'windwp/nvim-autopairs',                          -- Autopairs for neovim written by !ua
        config = function () require('configs.nvim-autopairs') end,
    },
    { 'NMAC427/guess-indent.nvim',                      -- Automatic indentation style detection for Neovim 
        config = function () require('guess-indent').setup() end,
    }
}

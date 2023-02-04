return {
    -- TODO: install vim-visual-multi
    -- { 'mg979/vim-visual-multi' }                        -- Multiple cursor plugin fot vim/neovim}
    -- TODO: add TS support with pre_hook
    { 'windwp/nvim-autopairs',                          -- Autopairs for neovim written by !ua
        config = function () require('configs.nvim-autopairs') end,
    },
    { 'numToStr/Comment.nvim',                          -- Smart and powerful comment plugin for neovim. Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more 
        config = true,
    }

}

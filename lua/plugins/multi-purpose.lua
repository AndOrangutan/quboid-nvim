return {
    -- TODO: Replace cinnamon and windows.nvim with this https://github.com/echasnovski/mini.nvim/issues/177#issuecomment-1364064915
    { 'echasnovski/mini.nvim',  -- Mini, multi purpose plugin, used for minimap and indent scope 
        --event = 'VimEnter',
        config = function () require('configs.mini') end,
    },
}

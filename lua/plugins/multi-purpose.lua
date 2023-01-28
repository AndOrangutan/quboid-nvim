return {
    { 'echasnovski/mini.nvim',  -- Mini, multi purpose plugin, used for minimap and indent scope 
        --event = 'VimEnter',
        config = function () require('configs.mini') end,
    },
}

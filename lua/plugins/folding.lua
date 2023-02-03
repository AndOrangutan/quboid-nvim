return {
    { 'kevinhwang91/nvim-ufo',                          --  Not UFO in the sky, but an ultra fold in Neovim.
        dependencies = {
            'kevinhwang91/promise-async',
        },
        config = function () require('configs.ufo') end,
    },
}

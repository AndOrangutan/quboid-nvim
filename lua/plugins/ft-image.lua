return {
    { 'princejoogie/chafa.nvim',                                --  A neovim plugin for viewing images. 
        config = function() require('chafa').setup() end,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'm00qek/baleia.nvim'
        }, },

}

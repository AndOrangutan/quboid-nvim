return {
    -- { 'princejoogie/chafa.nvim',                                --  A neovim plugin for viewing images. 
    --     config = function() require('chafa').setup() end,
    --     dependencies = {
    --         'nvim-lua/plenary.nvim',
    --         'm00qek/baleia.nvim'
    --     },
    -- },
    { 'samodostal/image.nvim',                                  --  Image Viewer as ASCII Art for Neovim written in Lua 
        config = function() require('image').setup({render = { foreground_color = true, background_color = true }}) end,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'https://github.com/m00qek/baleia.nvim',
        },
    },

}

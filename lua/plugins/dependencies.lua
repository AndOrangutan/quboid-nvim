return {
    -- Fixes, dependencies, and other needed util
    { 'DaikyXendo/nvim-material-icon',                  -- Icon set using nonicons for neovim plugins and settings
        dependencies = 'nvim-tree/nvim-web-devicons',       -- A Lua fork of vim-devicons.
        config = function () require('configs.nvim-material-icon') end,
    },
    { 'antoinemadec/FixCursorHold.nvim' },              -- Fix CursorHold Performance.
    { 'nvim-lua/plenary.nvim' },                        -- plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write twice.
    { 'MunifTanjim/nui.nvim' },                         -- UI Component Library for Neovim. 
    { 'tpope/vim-repeat' },                             -- repeat.vim: enable repeating supported plugin maps with "." 
    -- Cool but doesn't work with mini.animate
    -- { 'Aasim-A/scrollEOF.nvim',                         -- Scroll past the end of file just like scrolloff option 
    --     config = true,
    -- }
}

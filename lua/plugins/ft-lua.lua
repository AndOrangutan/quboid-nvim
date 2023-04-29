return {
    -- { 'milisims/nvim-luaref' },                         -- Add a vim :help reference for lua
    { 'folke/neodev.nvim',                              -- Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API. 
        config = function () require('neodev').setup() end,
    },
}

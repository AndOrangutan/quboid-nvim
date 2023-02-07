return {
    { 'michaelb/sniprun',                               -- A neovim plugin to run lines/blocs of code (independently of the rest of the file), supporting multiples languages
        build = 'bash ./install.sh',
        config = function () require('configs.sniprun') end,
    },
    { 'metakirby5/codi.vim' },                          -- The interactive scratchpad for hackers.
}

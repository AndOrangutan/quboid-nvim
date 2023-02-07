return {
    { 'jinh0/eyeliner.nvim',                            -- Move faster with unique f/F and t/T indicators. 
        config = function () require('configs.eyeliner') end,
    },
    { 'ThePrimeagen/harpoon',                           -- A per project, auto updating and editable marks utility for fast file navigation.
        config = function () require('configs.harpoon') end,
    },
}

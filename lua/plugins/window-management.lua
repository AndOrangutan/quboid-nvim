return {
    { 'famiu/bufdelete.nvim',
        keys = {
            { '<C-q>', function () require('bufdelete').bufdelete(0) end, 'Save and Close Buffer' }
        },

    },
}

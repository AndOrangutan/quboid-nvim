require('noice').setup({
    views = {
        cmdline_popup = {
            border = {
                style = 'none' ,
                padding = { 2, 3 },

            },
            filter_options = {},
            --text = {
            --    top = '',
            --},
            win_options = {
                winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            }
        },

    }
})

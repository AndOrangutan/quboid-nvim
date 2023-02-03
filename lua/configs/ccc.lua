local ccc = require('ccc')

-- TODO: Add mappings for ccc
-- https://github.com/uga-rosa/ccc.nvim
local mapping = ccc.mapping

ccc.setup({
    -- Your favorite settings
    default_color = "#000000",
    bar_char        = '■ ',
    point_chaar     = '◇ ',
    win_opts = {
        border = vim.g.quboid_border,
    },
    highlighter = {
        auto_enable = true,
        exclude = vim.g.quboid_ft_exclude,
    },
    pickers = {
        ccc.picker.hex,
        ccc.picker.css_rgb,
        ccc.picker.css_hsl,
        -- ccc.picker.css_name,
    },


})


require("dressing").setup {
    input = {
        border = vim.g.quboid_border,
        override = function(conf)
            conf.col = -1
            conf.row = 0
            return conf
        end,

    },
}

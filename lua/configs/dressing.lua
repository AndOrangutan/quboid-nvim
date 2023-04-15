local quboid = require('quboid')

require("dressing").setup {
    input = {
        border = quboid.boarder,
        override = function(conf)
            -- TODO: Determine if these lines are useful
            -- conf.col = -1
            -- conf.row = 0
            return conf
        end,

    },
}

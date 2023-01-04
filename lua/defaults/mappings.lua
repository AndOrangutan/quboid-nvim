local wk = require("which-key")

wk.register({
     ['Q'] = { '<cmd>w | bd<cr>', 'Save and Close Buffer' },
},{mode = "n"})


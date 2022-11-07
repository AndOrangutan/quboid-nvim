local wk = require('which-key')

require('trouble').setup()

wk.register({
    ["<leader>x"] = { name = "Trouble Inde[x]" },
    ["<leader>xx"] = { "<cmd>TroubleToggle<cr>", "Trouble Inde[x] E[x]tensive" },
    ["<leader>xw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Trouble Inde[x] [W]orkspace Diag." },
    ["<leader>xd"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "Trouble Inde[x] [D]ocument Diag." },
    ["<leader>xq"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "Trouble Inde[x] [Q]uickfix" },
    ["<leader>xl"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "Trouble Inde[x] [L]oclist" },
},{})


local wk = require("which-key")

require("lsp_lines").setup()

wk.register({
    ["<leader>ll"] = { function() require('lsp_lines').toggle() vim.notify('LSPLines Toggled') end, "[l]SP_[l]ines Toggle" },

})

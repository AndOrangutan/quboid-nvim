local quoid = require('quboid')

require('smartcolumn').setup({
   colorcolumn = 80,
   disabled_filetypes = quoid.quboid_ft_exclude_strict,
})

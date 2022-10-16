local minimap = require('mini.map')

local wk = require('which-key')


require('mini.indentscope').setup()
minimap.setup()

wk.register({
    ['ii'] = { 'Mini Scope Object' },
    ['ai'] = { 'Mini Scope Object Border' },
    ['[i'] = { 'Mini Scope Top' },
    [']i'] = { 'Mini Scope Bottom' },


    ['<leader>mm'] = { minimap.toggle, '[m]ini [m]Map Toggle' },
    ['<leader>mf'] = { minimap.toggle_focus, 'Mini [m]ap [t]oggle' },
    ['<leader>ms'] = { minimap.toggle_side, 'Mini [m]ap [s]withc' },
})

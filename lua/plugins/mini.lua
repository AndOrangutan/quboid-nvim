local minimap = require('mini.map')

local wk = require('which-key')


require('mini.indentscope').setup()


for _, key in ipairs({ 'n', 'N', '*', '#' }) do
    vim.keymap.set(
      'n',
      key,
      key ..
        '<Cmd>lua MiniMap.refresh({}, {lines = false, scrollbar = false})<CR>'
    )
  end


minimap.setup({ 
    integrations = {
        minimap.gen_integration.builtin_search({
            search = 'ReverseSearch',
        }),
        minimap.gen_integration.diagnostic({
            error = 'DiagnosticFloatingError',
            warn  = 'DiagnosticFloatingWarn',
            info  = 'DiagnosticFloatingInfo',
            hint  = 'DiagnosticFloatingHint',
        })
    }
})


for _, exludefile in pairs(vim.g.quboid_ft_exclude) do
    vim.cmd('autocmd Filetype '..exludefile..' lua vim.b.miniindentscope_disable = true')
end

for _, exludefile in pairs(vim.g.quboid_ft_marktex) do
    vim.cmd('autocmd Filetype '..exludefile..' lua vim.b.miniindentscope_disable = true')
end

wk.register({
    --['ii'] = { 'Mini Scope Object' },
    ['ai'] = { 'Mini Scope Object Border' },
    ['[i'] = { 'Mini Scope Top' },
    [']i'] = { 'Mini Scope Bottom' },


    ['<leader>mm'] = { minimap.toggle, '[m]ini [m]Map Toggle' },
    ['<leader>mf'] = { minimap.toggle_focus, 'Mini [m]ap [t]oggle' },
    ['<leader>ms'] = { minimap.toggle_side, 'Mini [m]ap [s]withc' },
},{mode = "n"})

local wk = require('which-key')

local indentscope = require('mini.indentscope')
local map = require('mini.map')
local autopairs = require('mini.pairs')
local animate = require("mini.animate")


indentscope.setup()

for _, exludefile in pairs(vim.g.quboid_ft_exclude) do
    vim.cmd('autocmd Filetype '..exludefile..' lua vim.b.miniindentscope_disable = true')
end

for _, exludefile in pairs(vim.g.quboid_ft_marktex) do
    vim.cmd('autocmd Filetype '..exludefile..' lua vim.b.miniindentscope_disable = true')
end


map.setup({ 
    symbols = { scroll_line = '▶ ', scroll_view = '┃' },
    window = { show_integration_count = false },
    integrations = {
        map.gen_integration.builtin_search(
            {
            search = 'ReverseSearch',
        }),
        map.gen_integration.diagnostic(),
    }
})

for _, key in ipairs({ 'n', 'N', '*', '#' }) do
    vim.keymap.set(
        'n',
        key,
        key ..
        '<Cmd>lua MiniMap.refresh({}, {lines = false, scrollbar = false})<CR>'
    )
end


autopairs.setup({
    mappings = {
        ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
        ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
        ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },

        [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
        [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
        ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

        ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
        ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
        ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
        [' '] = { action = 'open', pair = '  ', neigh_pattern = '[%(%[{][%)%]}]' },
        ['<'] = { action = 'open', pair = '<>' },
        ['>'] = { action = 'close', pair = '<>' },
    },
})

-- animate.setup()
--
-- local map_scroll_with_center = function(lhs)
--   local center_command =
--     [[if MiniAnimate ~= nil then MiniAnimate.execute_after('scroll', 'normal! zz') else vim.cmd('normal! zz') end]]
--
--   local rhs = string.format([[<Cmd>lua pcall(vim.cmd, 'normal! %s'); %s<CR>]], lhs, center_command)
--   vim.keymap.set('n', lhs, rhs, {})
-- end
--
-- map_scroll_with_center('<C-d>')
-- map_scroll_with_center('<C-u>')
-- map_scroll_with_center('gg')
-- map_scroll_with_center('G')
-- map_scroll_with_center('n')
-- map_scroll_with_center('N')

wk.register({
    --['ii'] = { 'Mini Scope Object' },
    ['ai'] = { 'Mini Scope Object Border' },
    ['[i'] = { 'Mini Scope Top' },
    [']i'] = { 'Mini Scope Bottom' },

    ['<leader>mm'] = { map.toggle, '[m]ini [m]Map Toggle' },
    ['<leader>mf'] = { map.toggle_focus, 'Mini [m]ap [t]oggle' },
    ['<leader>ms'] = { map.toggle_side, 'Mini [m]ap [s]withc' },
},{mode = "n"})

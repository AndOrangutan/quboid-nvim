local util = require('util')

local indentscope = require('mini.indentscope')
local map = require('mini.map')
local animate = require("mini.animate")

local quboid = require('quboid')

local wk_ok wk = pcall(require, 'which-key')
------------------
-- Indent Scope --
------------------
for _, exludefile in pairs(quboid.quboid_ft_exclude) do
    vim.cmd('autocmd filetype '..exludefile..' lua vim.b.miniindentscope_disable = true')
end

for _, exludefile in pairs(quboid.quboid_ft_marktex) do
    vim.cmd('autocmd filetype '..exludefile..' lua vim.b.miniindentscope_disable = true')
end

indentscope.setup()
---------
-- Map --
---------

map.setup({ 
    symbols = { scroll_line = '⏵', scroll_view = '┃' },
    window = { show_integration_count = false },
    integrations = {
        map.gen_integration.builtin_search( {
            search = 'ReverseSearch',CurrentDir
        }),
        map.gen_integration.diagnostic(),
    }
})

for _, key in ipairs({ 'n', 'N', '*', '#' }) do
    vim.keymap.set( 'n', key, key .. '<Cmd>lua MiniMap.refresh({}, {lines = false, scrollbar = false})<CR>'
    )
end


local map_scroll_with_center = function(lhs)
    local center_command =
    [[if MiniAnimate ~= nil then MiniAnimate.execute_after('scroll', 'normal! zz') else vim.cmd('normal! zz') end]]

    local rhs = string.format([[<Cmd>lua pcall(vim.cmd, 'normal! %s'); %s<CR>]], lhs, center_command)
    vim.keymap.set('n', lhs, rhs, {})
end

local mouse_scrolled = false
for _, scroll in ipairs({ "Up", "Down" }) do
    local key = "<ScrollWheel" .. scroll .. ">"
    vim.keymap.set("", key, function()
        mouse_scrolled = true
        return key
    end, { noremap = true, expr = true })
end

local animate = require("mini.animate")
animate.setup({
    scroll = {
        timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
        subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
                if mouse_scrolled then
                    mouse_scrolled = false
                    return false
                end
                return total_scroll > 1
            end,
        }),
    },
})


map_scroll_with_center('<C-d>')
map_scroll_with_center('<C-u>')
map_scroll_with_center('gg')
map_scroll_with_center('G')
map_scroll_with_center('n')
map_scroll_with_center('N')

-- Animate windows
local function sizes()
    vim.g.winwidth = math.max(64, math.floor(vim.go.columns * 0.5))
    vim.g.winminwidth = 32
    -- quboid..winheight = math.max(40, math.floor(quboid..lines * 0.5))
    vim.g.winheight = 8
    vim.g.winminheight = 8
end

sizes()

util.keymap('n', '<leader>mm', map.toggle, '[m]ini [m]Map Toggle')
util.keymap('n', '<leader>mf', map.toggle_focus, 'Mini [m]ap [t]oggle')
util.keymap('n', '<leader>ms', map.toggle_side, 'Mini [m]ap [s]witch sides')


if wk_ok then
    wk.register({
        --['ii'] = { 'Mini Scope Object' },
        ['ai'] = { 'Mini Scope Object Border' },
        ['[i'] = { 'Mini Scope Top' },
        [']i'] = { 'Mini Scope Bottom' },
    },{mode = "n"})
end

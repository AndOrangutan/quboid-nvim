local util = require('util')

local indentscope = require('mini.indentscope')
local map = require('mini.map')
local autopairs = require('mini.pairs')
local animate = require("mini.animate")

local wk_ok wk = pcall(require, 'which-key')
------------------
-- Indent Scope --
------------------

indentscope.setup()

-- Exclude for base exclude files
for _, exludefile in pairs(vim.g.quboid_ft_exclude) do
    vim.cmd('autocmd Filetype '..exludefile..' lua vim.b.miniindentscope_disable = true')
end

for _, exludefile in pairs(vim.g.quboid_ft_marktex) do
    vim.cmd('autocmd Filetype '..exludefile..' lua vim.b.miniindentscope_disable = true')
end

---------
-- Map --
---------

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
    vim.keymap.set( 'n', key, key .. '<Cmd>lua MiniMap.refresh({}, {lines = false, scrollbar = false})<CR>'
    )
end


---------------
-- Autopairs --
---------------

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


local mouse_scrolled = false
for _, scroll in ipairs({ 'Up', 'Down' }) do
    local key = '<ScrollWheel'..'>'
    vim.keymap.set('', key, function ()
        mouse_scrolled = true
        return key
    end, { noremap = true, expr = true })
end

local map_scroll_with_center = function(lhs)
  local center_command =
    [[if MiniAnimate ~= nil then MiniAnimate.execute_after('scroll', 'normal! zz') else vim.cmd('normal! zz') end]]

  local rhs = string.format([[<Cmd>lua pcall(vim.cmd, 'normal! %s'); %s<CR>]], lhs, center_command)
  vim.keymap.set('n', lhs, rhs, {})
end

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
    vim.go.winwidth = math.max(64, math.floor(vim.go.columns * 0.5))
    vim.go.winminwidth = 24
    -- vim.go.winheight = math.max(40, math.floor(vim.go.lines * 0.5))
    vim.go.winheight = 8
    vim.go.winminheight = 8
end

sizes()

vim.api.nvim_create_autocmd("VimResized", { 
    callback = function ()
        for i, ft in pairs(vim.g.quboid_ft_exclude) do
            if vim.bo.filetype == ft then
                -- vim.o.winwidth = 10
                -- vim.o.winminwidth = 10
                -- vim.o.winheight = 8
                -- vim.o.winminheight = 8

                return
            end
            sizes()
        end
    end
})

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

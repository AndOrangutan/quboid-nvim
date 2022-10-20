
local G = vim.g

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        section_separators = { left = '', right = ''},
        component_separators = { left = '｜', right = '｜'},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch',
            'diff',
            { 'diagnostics', symbols = { error = G.quboid_icons['Error'], warn = G.quboid_icons['Warn'], info = G.quboid_icons['Info'], hint = G.quboid_icons['Hint']}}
        },
        lualine_c = {''},

        lualine_x = {'filesize', 'encoding', 'filetype'},
        lualine_y = {''}, --progress
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

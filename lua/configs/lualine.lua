
local quboid = require('quboid')

local lsp_progress_ok, lsp_progress = pcall(require, 'lsp-progress')

config = {
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
            { 'diagnostics', symbols = { error = quboid.quboid_icons['Error'], warn = quboid.quboid_icons['Warn'], info = quboid.quboid_icons['Info'], hint = quboid.quboid_icons['Hint']}}
        },
        lualine_c = { lsp_progress.progress },

        lualine_x = {},
        lualine_y = {'filesize', 'encoding', 'filetype'}, --progress
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

-- Color for highlights
local colors = {
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98be65',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ec5f67'
}





require('lualine').setup(config)

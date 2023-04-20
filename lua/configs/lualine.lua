local quboid = require('quboid')
local util = require('util')

local lsp_progress = require('lsp-progress')

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        section_separators = { left = '', right = ''},
        component_separators = { left = quboid.icons.bar_thin, right = quboid.icons.bar_thin},
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
        lualine_a = {
            {'mode', fmt = function(str) return str:sub(1,1) end },
        },
        lualine_b = {
            'branch',
            'diff',
        },
        lualine_c = {
            { 'diagnostics',
                update_in_insert = true,
                symbols = {
                    error = quboid.icons.Error,
                    warn = quboid.icons.Warn,
                    info = quboid.icons.Info,
                    hint = quboid.icons.Hint
                }
            },
            -- TODO: Confirm funcitonality
            { lsp_progress.progress,
                icon = quboid.icons.LSP,
                color = 'StatusLineNCComment',
            },
        },
        lualine_x = {
            { 'searchcount',
                icon = ' ',
                color = 'StatusLineNCSearch',
            },
            { 'selectioncount',
                icon = ' ',
                color = 'StatusLineNCVisual',
            },
        },
        lualine_y = {'filesize', 'encoding', 'filetype'},
        lualine_z = {
            { 'location' },
        },
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


-- listen to user event and trigger lualine refresh
vim.cmd([[
augroup lualine_augroup
    autocmd!
    autocmd User LspProgressStatusUpdated lua require("lualine").refresh()
augroup END
]])

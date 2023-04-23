local quboid = require('quboid')
local util = require('util')

local lsp_progress_ok, lsp_progress = pcall(require, 'lsp-progress')

local bar = { '', icon = quboid.icons.bar_thin }

local function filetype_name()
    return vim.bo.filetype
end

local function min_window_width(width)
  return function() return vim.fn.winwidth(0) > width end
end

local function encoding()
  local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
  return ret
end

local function bar()
    return quboid.icons.bar_thin
end

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
            {'mode', fmt = function(str) return string.lower(str:sub(1,1)) end },
        },
        lualine_b = {
            { 'branch', 
                cond = min_window_width(120),
                icon = quboid.icons.Git_Branch,
                separator = '',
            },
            { 'diff',
                symbols = {added = quboid.icons.Git_Added, modified = quboid.icons.Git_Modified, removed = quboid.icons.Git_Removed}, -- Changes the symbols used by the diff.
                cond = min_window_width(120),
                on_click = function() vim.cmd('Neogit') end,
            },
        },
        lualine_c = {
            { 'diagnostics',
                update_in_insert = true,
                symbols = {
                    error = quboid.icons.Error,
                    warn = quboid.icons.Warn,
                    info = quboid.icons.Info,
                    hint = quboid.icons.Hint
                },
                on_click = function() vim.cmd('TroubleToggle document_diagnostics') end,
            },
            -- TODO: Confirm funcitonality
            { lsp_progress.progress,
                icon = quboid.icons.LSP,
                cond = min_window_width(80),
                color = 'StatusLineNCComment',
            on_click = function() vim.cmd('LspInfo') end,
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
            { require('lazy.status').updates,
                cond = require('lazy.status').has_updates,
                color = 'StatusLineNCString',
                on_click = function() vim.cmd('Lazy') end,
            },
        },
        lualine_y = {
            { 'filetype',
                cond = min_window_width(120),
            },
            { 'filesize',
                cond = min_window_width(120)
            },
            { encoding,
                cond = min_window_width(120)
            },
        },
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

require('onedark').setup({
    code_style = {
        comments = 'italic',
        keywords = 'italic,bold',
        functions = 'bold',
        strings = 'italic',
        variables = 'none'
    },
    lualine = {
        transparent = false, -- lualine center bar transparency
    },
})

--require("onedark").setup({
--    comment_style = 'italic',
--    keyword_style = 'bold',
--    function_style = 'bold',
--    msg_area_style = 'NONE',
--    variable_style = 'NONE',
--    dark_float = true,
--    dark_sidebar = true,
--    hide_end_of_buffer = false,
--    hide_inactive_statusline = false,
--    highlight_linenumber = false,
--    lualine_bold = true,
--    transparent = false,
--    transparent_sidebar = false,
--
--    sidebars = {'qf', 'vista_kind', 'terminal', 'packer'},
--
--    -- Change the "hint" color to the "orange" color, and make the "error" color bright red
--    --colors = {hint = "orange", error = "#ff0000"},
--    -- Overwrite the highlight groups
--    overrides = function(c)
--        return {
--            htmlTag = {fg = c.red, bg = '#282c34', sp = c.hint, style = 'underline'},
--            Folded = { fg = c.fg_dark, bg = c.bg },
--            DiagnosticHint = {link = 'LspDiagnosticsDefaultHint'},
--            -- this will remove the highlight groups
--            TSField = {},
--            NotifyERRORBody = { bg = c.bg1 },
--            NotifyWARNBody = { bg = c.bg1 },
--            NotifyINFOBody = { bg = c.bg1 },
--            NotifyDEBUGBody = { bg = c.bg1 },
--            NotifyTRACEBody = { bg = c.bg1 },
--            TelescopeBorder = { fg = c.bg1, bg = c.bg1 },
--            TelescopePromptBorder = { fg = c.bg_highlight, bg = c.bg_highlight },
--            TelescopePromptNormal = { fg = c.fg0, bg = c.bg_highlight},
--            TelescopePromptPrefix = { fg = c.red0, bg = c.green0 },
--            TelescopeNormal = { bg = c.bg1},
--            TelescopePreviewTitle = { fg = c.bg1, bg = c.green0 },
--            TelescopePromptTitle = { fg = c.bg1, bg = c.red0 },
--            TelescopeResultTitle = { fg = c.bg1, bg = c.bg1 },
--            TelescopeSelection = { bg = c.bg_highlight},
--            CursorLine = { bg = nil },
--            CursorLineNr = { bg = nil },
--            CodiVirtualText = { link = 'Comment' },
--            MiniIndentscopePrefix = { link = 'Comment' },
--            MiniMapNormal = { link = 'Comment' },
--
--        }
--    end
--})

--vim.defer_fn(function()
vim.api.nvim_set_hl(0, "CodiVirtualText", {link = "Comment"})
vim.api.nvim_set_hl(0, "MiniMapNormal", {link = "Comment"})
    --end, 101)

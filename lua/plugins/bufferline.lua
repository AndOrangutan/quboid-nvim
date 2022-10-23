local wk = require("which-key")

local G = vim.g

require("bufferline").setup{
    options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        numbers = "none",
        close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
        -- NOTE: tis plugin is designed with this icon in mind,
        -- and so changing this is NOT recommended, this is intended
        -- as an escape hatch for people who cannot bear it for whatever reason
        --indicator_icon      = '  ',
        indicator = {
            icon = " ",
            style = "none",
        },
        buffer_close_icon   = G.quboid_icons['Close'],
        modified_icon       = G.quboid_icons['Modified'],
        close_icon          = G.quboid_icons['Close'],
        left_trunc_marker   = G.quboid_icons['ArrowLeft'],
        right_trunc_marker  = G.quboid_icons['ArrowRight'],
        --- name_formatter can be used to change the buffer's label in the bufferline.
        --- Please note some names can/will break the
        --- bufferline so use this at your discretion knowing that it has
        --- some limitations that will *NOT* be fixed.
        max_name_length = 14,
        max_prefix_length = 13, -- prefix used when a buffer is de-duplicated
        tab_size = 20,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            return "("..count..")"
        end,
        -- NOTE: this will be called a lot so don't do any heavy processing here
        custom_filter = function(buf_number, buf_numbers)
            -- filter out filetypes you don't want to see
            if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
                return true
            end
            -- filter out by buffer name
            if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
                return true
            end
            -- filter out based on arbitrary rules
            -- e.g. filter out vim wiki buffer from tabline in your work repo
            if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
                return true
            end
            -- filter out by it's index number in list (don't show first buffer)
            if buf_numbers[1] ~= buf_number then
                return true
            end
        end,
        offsets = {
            {filetype = "neo-tree", text = "Neo Tree", highlight = "NvimTreeNormal", text_align = "center", padding = 0 },
            {filetype = "NvimTree", text = "File Tree", highlight = "NvimTreeNormal", text_align = "center", padding = 0 },
            {filetype = "Outline", text = "Symbol Outline", highlight = "NvimTreeNormal", text_align = "center", padding = 0 },
        },
        color_icons = true, -- whether or not to add the filetype icon highlights
        show_buffer_icons = true, -- disable filetype icons for buffers
        show_buffer_close_icons = true,
        show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
        show_close_icon = false,
        show_tab_indicators = false,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        separator_style = "thick",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        sort_by = 'id',
    }
}

-- 

wk.register({
    ["<M-.>"] = { "<cmd>BufferLineCycleNext<cr>", "Bufferline Cycle Next" },
    ["<M-,>"] = { "<cmd>BufferLineCyclePrev<cr>", "Bufferline Cycle Prev" },
}, {})

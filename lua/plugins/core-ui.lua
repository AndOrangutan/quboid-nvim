return {
    { 'akinsho/bufferline.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function ()

            local util = require('util')
            local quboid = require('quboid')

            require("bufferline").setup({
                options = {
                    indicator = {
                        icon = " ",
                        style = "none",
                    },
                    buffer_close_icon   = quboid.icons.close,
                    modified_icon       = quboid.icons.pencil,
                    close_icon          = quboid.icons.close,
                    left_trunc_marker   = quboid.icons.arrowLeft,
                    right_trunc_marker  = quboid.icons.arrowRight,
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
                    show_close_icon = false,
                    show_tab_indicators = false,
                    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
                    -- can also be a table containing 2 custom separators
                    -- [focused and unfocused]. eg: { '|', '|' }
                    separator_style = "thick",
                    enforce_regular_tabs = false,
                    always_show_bufferline = true,
                    sort_by = 'id',
                },
            })
        end,
        event = { 'BufReadPre', 'BufNewFile' }, -- NOTE: Needed for autocmd to work
        keys = {
            { '<M-.>', '<cmd>BufferLineCycleNext<cr>', desc = 'Bufferline Cycle Next' },
            { '<M-,>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Bufferline Cycle Prev' },
        },
    },
    { 'echasnovski/mini.notify',
        config = function ()
            local quboid = require('quboid')

            local opts = { ERROR = { duration = 10000 } }
            vim.notify = require('mini.notify').make_notify(opts)

            require('mini.notify').setup({
                -- Content management
                content = {
                    -- Function which formats the notification message
                    -- By default prepends message with notification time
                    format = nil,

                    -- Function which orders notification array from most to least important
                    -- By default orders first by level and then by update timestamp
                    sort = function(notif_arr)
                        table.sort(
                            notif_arr,
                            function(a, b) return a.ts_update > b.ts_update end
                        )
                        return notif_arr
                    end,
                },
                lsp_progress = {
                    enable = false,
                    duration_last = 500,
                },
                window = {
                    config = {
                        border = require('quboid').border,
                    },
                    winblend = require('quboid').winblend,
                },
            })

            vim.api.nvim_create_user_command("MiniNotifyHistory", function()
                vim.cmd[[split]]
                require('mini.notify').show_history()
            end, {})
            vim.lsp.handlers['window/showMessage'] = function (_, result, ctx)
                local client = vim.lsp.get_client_by_id(ctx.client_id)

                print("Did a thing, look")
                vim.notify( result.message, result.type { title = 'LSP | ' .. client.name, timeout = 10000, } )
            end
        end,
        -- event = { 'BufReadPre', 'BufNewFile' },
    },
    { 'luukvbaal/statuscol.nvim',
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                foldfunc = "builtin",
                ft_ignore = require('quboid').ft_exclude,
                bt_ignore = require('quboid').ft_exclude,
                setopt = true,
                thousands = false,
                relculright = true,
                segments = {
                    { text = { "%s" }, click = "v:lua.ScSa" },
                    { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
                    -- { sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
                    --     click = "v:lua.ScSa"
                    -- },
                    { text = { builtin.foldfunc, " " },
                        condition = { builtin.not_empty, true, builtin.not_empty },
                        click = "v:lua.ScFa"
                    },
                }
            })
        end
    },
    { 'kevinhwang91/nvim-ufo',
        dependencies = {
            'kevinhwang91/promise-async',
        },
        event = 'VeryLazy',
        config = function ()

            local quboid = require('quboid')
            local ufo = require('ufo')

            vim.o.foldcolumn = '1' -- '0' is not bad
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            -- TODO: Setup with signcolumn and ufo

            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (' '..quboid.icons.pound..' %d '):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, {chunkText, hlGroup})
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, {suffix, 'MoreMsg'})
                return newVirtText
            end

            ufo.setup({
                close_fold_kinds = {'comment', 'imports'},
                -- close_fold_kinds = {'comment', 'imports', 'region'},
                fold_virt_text_handler = handler,
                preview = {
                    win_config = {
                        border = quboid.border_float,
                    },
                    mappings = {
                        scrollU = '<C-u>',
                        scrollD = '<C-d>'
                    },
                },
            })
        end,
        keys = {
            { 'zR', function() require('ufo').openAllFolds() end, desc = 'Open All Folds' },
            { 'zM', function() require('ufo').closeAllFolds() end, desc = 'Close All Folds' },
        },

    }
}

return {
    { 'stevearc/dressing.nvim',
    },
    { 'ibhagwan/fzf-lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            config = true,
        },
        config = function ()
            local img_previewer = vim.fn.executable("ueberzug") == 1 and { "ueberzug" } or { "viu", "-b" }

            require('fzf-lua').setup({
                multiprocess=true,
                file_icon_padding = ' ',
                fzf_opts = { 
                    ['--no-separator'] = '',
                    ['--border'] = false
                },
                winopts = {
                    border = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '  },
                    hl = {
                        normal         = 'NormalFloat', -- window normal color (fg+bg)
                        border         = 'NormalFloat',        -- border color (try 'FloatBorder')
                        -- Only valid with the builtin previewer:
                        cursor         = 'Cursor',      -- cursor highlight (grep/LSP matches)
                        cursorline     = 'NormalFloat',  -- cursor line
                        search         = 'Search',      -- search matches (ctags)
                        title           = 'FloatBorder',    -- preview border title (file/buffer)
                        -- scrollbar_f = 'PmenuThumb',  -- scrollbar "full" section highlight
                        -- scrollbar_e = 'PmenuSbar',   -- scrollbar "empty" section highlight
                    },
                },
                winopts_fn = function ()
                    return { 
                        width = vim.o.columns>80 and 0.85 or 1,
                        hight = vim.o.columns>80 and 0.85 or 1,
                    }
                end,
                previewers = {
                    builtin = {
                        ueberzug_scaler = "cover",
                        extensions = {
                            ["gif"] = img_previewer,
                            ["png"] = img_previewer,
                            ["jpg"] = img_previewer,
                            ["jpeg"] = img_previewer,
                        },
                    },
                },
            })
        end,
        keys = {
            { '<leader>f', '<cmd>FzfLua<cr>', desc = '[f]zf All' },
            { '<leader>ff', '<cmd>FzfLua files<cr>', desc = '[f]zf Find [f]iles' },
            { '<leader>fc', '<cmd>FzfLua colorschemes<cr>', desc = '[f]zf [c]olorschemes' },
            { '<leader>fg', '<cmd>FzfLua live_grep_resume<cr>', desc = '[f]zf [g]rep files' },
            { '<leader>fh', '<cmd>FzfLua help_tags<cr>', desc = '[f]zf Neovim [h]elp tags' },
        },
        event = { 'BufReadPre', 'BufNewFile' },
    }
}

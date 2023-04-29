return {
    { 'akinsho/bufferline.nvim',
        dependencies = {
            'DaikyXendo/nvim-material-icon',
        },
        config = function () require('configs.bufferline') end,
    },
    { 'nvim-lualine/lualine.nvim',
        dependencies = {
            'DaikyXendo/nvim-material-icon',
            'linrongbin16/lsp-progress.nvim'
        },
        config = function () require('configs.lualine') end,
        event = { 'VimEnter' },
    },

    { 'linrongbin16/lsp-progress.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'DaikyXendo/nvim-material-icon',
        },
        config = function () require('configs.lsp-progress') end,
        event = { 'VimEnter' },
    },
    { 'rcarriga/nvim-notify',
        config = function () require('configs.notify') end,
    },
    { 'luukvbaal/statuscol.nvim',
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                foldfunc = "builtin",
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
        config = function () require('configs.ufo') end,
    },
}

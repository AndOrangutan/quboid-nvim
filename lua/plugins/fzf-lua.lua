local wk = require('which-key')

require('fzf-lua.config')._devicons_setup = '~/.local/share/nvim/site/pack/packer/opt/nvim-material-icon/lua/nvim-material-icon.lua'

require('fzf-lua').setup({
    file_icon_padding = ' ',
    multiprocess=false,
    winopts = {
        border = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '  },
        hl = {
            normal         = 'NormalFloat', -- window normal color (fg+bg)
            border         = 'NormalFloat',        -- border color (try 'FloatBorder')
            -- Only valid with the builtin previewer:
            cursor         = 'Cursor',      -- cursor highlight (grep/LSP matches)
            cursorline     = 'CursorLine',  -- cursor line
            search         = 'Search',      -- search matches (ctags)
            title       = 'FloatBorder',    -- preview border title (file/buffer)
            -- scrollbar_f = 'PmenuThumb',  -- scrollbar "full" section highlight
            -- scrollbar_e = 'PmenuSbar',   -- scrollbar "empty" section highlight
        },
    },
})



wk.register({
    ["<leader>f"] = { "<cmd>FzfLua<cr>", "[F]zf Options" },
    ["<leader>ff"] = { "<cmd>FzfLua files<cr>", "[F]ZF Find [F]iles" },
    ["<leader>fg"] = { "<cmd>FzfLua live_grep_resume<cr>", "[F]ZF R[G]rep Files" },
    ["<leader>fh"] = { "<cmd>FzfLua help_tags<cr>", "[F]ZF [H]elp Tags" },
    ["<leader>fb"] = { "<cmd>Legendary<cr>", "[F]ZF Legendary [B]indings" },
})

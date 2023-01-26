local util = require('util')

local legendary_ok legendary = pcall(require, 'legendary')

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


-- TODO: Add More fzf
util.keymap('n', '<leader>fa', '<cmd>FzfLua<cr>', '[f]zf [a]ll options')
util.keymap('n', '<leader>ff', '<cmd>FzfLua files<cr>', '[f]zf [f]ind files')
util.keymap('n', '<leader>fg', '<cmd>FzfLua grep_resume<cr>', '[f]zf [g]rep files')
util.keymap('n', '<leader>fh', '<cmd>FzfLua help_tags<cr>', '[f]zf Neovim [h]elp tags')
if legendary_ok then
    util.keymap('n', '<leader>fb', '<cmd>Legendary<cr>', '[f]zf Keymap [b]indings')
end


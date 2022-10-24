local wk = require('which-key')

local G = vim.g

G.mkdp_auto_start = 0
G.mkdp_auto_close = 1
G.mkdp_browser = 'electron'
G.mkdp_echo_preview_url = 1
G.mkdp_theme = 'light'

wk.register({
    ['<f5>'] = { '<cmd>MarkdownPreviewToggle<cr>', 'Markdown Preview' }
})

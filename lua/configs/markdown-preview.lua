local util = require('util')
local G = vim.g

G.mkdp_auto_start = 0
G.mkdp_auto_close = 1
G.mkdp_browser = 'electron'
G.mkdp_echo_preview_url = 1
G.mkdp_theme = 'light'

util.keymap('n', '<f5>', '<cmd>MarkdownPreviewToggle<cr>', 'Markdown Preview')


local quboid              = require('quboid')
local icons               = require('quboid.icons')

local o                   = vim.o
local wo                  = vim.wo -- Window options
local bo                  = vim.bo -- Buffer options
local g                   = vim.g

-- Set leader
g.mapleader               = ' '

g.editorconfig            = true

g.loaded_perl_provider    = 0
g.loaded_ruby_provider    = 0
g.loaded_node_provider    = 0
g.loaded_python_provider  = 0
g.loaded_python3_provider = 0

-- Mouse
o.mouse                   = 'a'

-- Clipboard
o.clipboard               = 'unnamedplus'

-- Cursor
o.cursorline              = false
o.scrolloff               = 999
o.sidescrolloff           = 16

-- Indent
local indentsize          = quboid.indentsize
o.tabstop                 = indentsize
o.softtabstop             = indentsize
o.shiftwidth              = indentsize
o.shiftround              = true
o.expandtab               = true
o.smarttab                = true
o.smartindent             = true
o.autoindent              = true
o.wrap                    = false
o.breakindent             = true
o.breakindentopt          = 'list:-1'
o.formatoptions           = 'tqj'

-- History
o.hidden                  = true
o.backup                  = false
o.swapfile                = false
o.undofile                = true
o.undodir                 = '/tmp/.nvim-undodir'
o.history                 = 100
vim.cmd [[
if !isdirectory("/tmp/.vim-undo-dir")
  call mkdir("/tmp/.vim-undo-dir", "", 0700)
endif
]]

-- Number lines
o.number         = true
o.relativenumber = true

-- Search
o.ignorecase     = true
o.incsearch      = true
o.smartcase      = true

-- Spelling
o.dictionary     = '/usr/share/dict/words'

-- Windows
o.pumheight      = 24
o.splitkeep      = 'screen'
o.winwidth       = 10
o.winminwidth    = 10
o.winheight      = 8
o.winminheight   = 8
o.equalalways    = false
o.splitbelow     = true
o.splitright     = true

-- Visual
o.list           = true
o.showmode       = false
o.conceallevel   = 2
o.listchars      = 'eol:¬'
o.signcolumn     = 'yes:1'
o.fillchars      = 'foldsep: ,foldopen:' .. icons.ui.expand .. ',foldclose:' .. icons.ui.expand

o.cmdheight      = 0
o.termguicolors  = true
o.errorbells     = false
o.encoding       = 'utf-8'
o.completeopt    = 'menu,menuone,noselect'
o.pumheight      = 16

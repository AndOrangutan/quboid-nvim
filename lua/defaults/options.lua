
local o = vim.o     -- For global options
local w = vim.wo    -- For the window local options
local b = vim.bo    -- For the buffer local options
local g = vim.g

vim.g.editorconfig = true;          -- Enable editor config
vim.o.textwidth = 80

--local utils = require('utils')

-- TODO: Move to quboid.lua
local indentSize = 4

g.mapleader = " "

vim.opt.pumheight = 24
--o.concealcursor="nc"


-- wrapped
o.smoothscroll         = true

o.splitkeep = 'screen'
-- o.spell             = true
o.dictionary        = '/usr/share/dict/words'
-- Sane(er) defaults
o.termguicolors     = true
o.timeoutlen        = 500
-- TODO: Move to a workflow that includes use of all the clipboard buffers
o.clipboard         = "unnamedplus"
o.mouse             = "a"
o.errorbells        = false
o.encoding          = "utf-8"
o.completeopt       = "menu,menuone,noselect"

-- Visual
o.list              = true
o.number            = true
o.relativenumber    = true
o.showmode          = false
o.conceallevel      = 2
vim.opt.listchars   = "tab:  ,eol:¬"
vim.opt.fillchars   = "foldsep: ,foldopen:,foldclose:"
o.signcolumn        = "yes:1"
--o.background        = "dark" -- Moved to colorscheme
o.laststatus        = 3
o.cmdheight         = 0

-- Tabbing, breaking, wraping and indentation
o.tabstop           = indentSize
o.softtabstop       = indentSize
o.shiftwidth        = indentSize
o.shiftround        = true
o.expandtab         = true
o.smarttab          = true
o.smartindent       = true
o.autoindent        = true
o.wrap              = false
o.breakindent       = true
o.breakindentopt    = "list:-1"
o.formatoptions     = "tcqj"
-- o.formatlistpat     = "^\s*\d\+[\]:.)}\t ]\s*"

-- Window
o.winwidth = 10
o.winminwidth = 10
o.winheight = 8
o.winminheight = 8
o.equalalways = false

-- Cursor
o.cursorline        = true
o.scrolloff         = 999
o.sidescrolloff     = 16
o.pumheight         = 16

-- Splits
o.splitbelow        = true
o.splitright        = true

-- Search
o.ignorecase        = true
o.incsearch         = true
o.smartcase         = true

-- Folds
--o.foldmethod        = "marker"
--o.foldmethod        = "expr"
--o.foldexpr          = "nvim_treesitter#foldexpr()"
--o.foldtext          = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend))]]
--o.fillchars         = [[fold: ]]
--o.foldnestmax       = 3
--o.foldminlines      = 1

-- History

o.hidden            = true
o.backup            = false
o.swapfile          = false
o.undofile          = true
o.undodir           = "/tmp/.nvim-undodir"
o.history           = 100
vim.cmd[[
if !isdirectory("/tmp/.vim-undo-dir")
  call mkdir("/tmp/.vim-undo-dir", "", 0700)
endif
]]


-- disable language provider support (lua and vimscript plugins only).
-- This is mostly just here because I am likely to want some other plugin.
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0


-- vim.cmd[[
-- set formatlistpat=^\\s*                     " Optional leading whitespace
-- set formatlistpat+=[                        " Start character class
-- set formatlistpat+=\\[({]\\?                " |  Optionally match opening punctuation
-- set formatlistpat+=\\(                      " |  Start group
-- set formatlistpat+=[0-9]\\+                 " |  |  Numbers
-- set formatlistpat+=\\\|                     " |  |  or
-- set formatlistpat+=[a-zA-Z]\\+              " |  |  Letters
-- set formatlistpat+=\\)                      " |  End group
-- set formatlistpat+=[\\]:.)}                 " |  Closing punctuation
-- set formatlistpat+=]                        " End character class
-- set formatlistpat+=\\s\\+                   " One or more spaces
-- set formatlistpat+=\\\|                     " or
-- set formatlistpat+=^\\s*[-–+o*•]\\s\\+      " Bullet points
-- ]]

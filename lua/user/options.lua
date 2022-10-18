
local o = vim.o     -- For global options
local w = vim.wo    -- For the window local options
local b = vim.bo    -- For the buffer local options
local g = vim.g   

local utils = require('utils')

local indentSize = 4

g.mapleader = " "

o.concealcursor="nc"

-- Sane(er) defaults
o.termguicolors     = true
o.timeoutlen        = 500
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
o.listchars         = "eol:¬"
o.fillchars         = "foldsep: ,foldopen:,foldclose:"
o.signcolumn        = "yes:1"
o.background        = "dark"
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
o.breakindentopt    = true

-- Cursor
o.cursorline        = false
o.scrolloff         = 16
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


--vim.cmd[[
--set formatlistpat=^\\s*                     " Optional leading whitespace
--set formatlistpat+=[                        " Start character class
--set formatlistpat+=\\[({]\\?                " |  Optionally match opening punctuation
--set formatlistpat+=\\(                      " |  Start group
--set formatlistpat+=[0-9]\\+                 " |  |  Numbers
--set formatlistpat+=\\\|                     " |  |  or
--set formatlistpat+=[a-zA-Z]\\+              " |  |  Letters
--set formatlistpat+=\\)                      " |  End group
--set formatlistpat+=[\\]:.)}                 " |  Closing punctuation
--set formatlistpat+=]                        " End character class
--set formatlistpat+=\\s\\+                   " One or more spaces
--set formatlistpat+=\\\|                     " or
--set formatlistpat+=^\\s*[-–+o*•]\\s\\+      " Bullet points
--]]


------------------------------------------- Autoinstall and autoupdate for Packer --
-------------------------------------------
-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path, }) print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
--vim.cmd([[
--    augroup packer_user_config
--        autocmd!
--        autocmd BufWritePost plugins.lua source <afile> | PackerSync
--    augroup end
--]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = vim.g.quboid_border })
        end,
    },
})

---------------------
-- Install plugins --
----------------------
return packer.startup(function(use)

    ------------------
    -- Core Plugins --
    -------------------

    -- Startup
    use { 'wbthomason/packer.nvim', -- A use-package inspired plugin manager for Neovim. Uses native packages, supports Luarocks dependencies, written in Lua, allows for expressive config.
        --opt = true,
    }
    -- Treesitter for highlighting and syntax parsing
    use { 'nvim-treesitter/nvim-treesitter', -- Neovim Treesitter configurations and abstraction layer.
        requires = {
            --"nvim-treesitter/nvim-treesitter-textobjects",  -- TODO: Setup textobjects
            --'lukas-reineke/headlines.nvim',
            "MDeiml/tree-sitter-markdown", -- A markdown grammar for tree-sitter 'RRethy/nvim-treesitter-endwise', -- Wisely add "end" in Ruby, Vimscript, Lua, etc. Tree-sitter aware alternative to tpope's vim-endwise.
            --'JoosepAlviste/nvim-ts-context-commentstring', -- Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
            --{ 'nvim-treesitter/playground', --Treesitter playground integrated into Neovim
            --    cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' }
            --},
        },
        --event = 'BufRead',
        run = ':TSUpdate',
        config = function() require('plugins.nvim-treesitter') end,
    }
    -- Git
    --use { 'preservim/vim-markdown', -- Markdown Vim Mode
    --    ft = 'markdown',
    --    setup = function () require('plugins.vim-markdown') end,
    --}


    use { 'lukas-reineke/headlines.nvim', -- This plugin adds horizontal highlights for text filetypes, like markdown, orgmode, and neorg.
        --ft =  'markdown',
        confug = function ()  require('headlines').setup() end,
    }

end)

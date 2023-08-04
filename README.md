# quboid-nvim

Resiliant, fast, text-based Personal Development Environment

## What is quboid

## Requirements

## Core

### Features

#### LSP (Language Server Protocol)

This is what makes modern languages and IDEs feel like a well oiled machine. Completion allows us to use longer and more descriptive names, goto-definition allows us to navigate quickly, proper renaming, and diagnostics. 

Many of these are the exact same ones you can use in VSCode, except the configuration differs largely, so they are not always feature equivalent.

| Language                  | Server            | Extension     |
|---------------------------|-------------------|---------------|
|  swk_ls                   | Awk               |               |
|  angularls                | Angular           |               |
|  arduino_language_server  | Aruino            |               |
|  bashls                   | Bash              |               |
|  clangd                   | C, C++            |               |
|  omnisharp                | C#                |               |
|  cmake                    | CMake             |               |
|  cssls                    | CSS               |               |
|  clojure_lsp              | Clojure           |               |
|  dockerls                 | Docker            |               |
|  emmet_ls                 | Emmet             |               |
|  fortls                   | Fortran           |               |
|  gopls                    | Go                |               |
|  html                     | HTML              |               |
|  eslint                   | Javascript        |               |
|  jsonls                   | JSON              |               |
|  jdtls                    | JAVA              |               |
|  tsserver                 | Typescript        |               |
|  kotlin_language_server   | Kotlin            |               |
|  lua_ls                   | Lua               |               |
|  rnix                     | Nix               |               |
|  intelephense             | PHP               |               |
|  pyright                  | Python            |               |
|  Rust                     | Rust              |               |
|  sqlls                    | SQL               |               |
|  Svelte                   | Svelte            |               |
|  taplo                    | TOML              |               |
|  tailwindcss              | Tailwind CSS      |               |
|  vimls                    | VimL              |               |
|  vuels                    | Vue               |               |
|  lemminx                  | XML               |               |
|  yamlls                   | YAML              |               |
|  zls                      | Zig               |               |

<!-- #### DAP (Debug Adapter Protocol) -->

#### By Language

##### Go

##### Java

### Plugins

- [folke/lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin Manager, best one I have tried.

#### Bloat (Totally deserves to be this high up haha)

#### Colorschemes

- [Shatur/neovim-ayu](https://github.com/Shatur/neovim-ayu) - Ayu theme for Neovim
- [neanias/everforest-nvim](https://github.com/neanias/everforest-nvim) - A Lua port of the Everforest colour scheme.
- [rebelot/kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) - NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai.
- [navarasu/onedark.nvim](https://github.com/navarasu/onedark.nvim) - One dark and light colorscheme for neovim >= 0.5.0 written in lua based on Atom's One Dark and Light theme. Additionally, it comes with 5 color variant styles.

#### Completion

- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - A completion plugin for neovim coded in Lua.
    - [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer) - nvim-cmp source for buffer words.
    - [hrsh7th/cmp-calc](https://github.com/hrsh7th/cmp-calc) - nvim-cmp source for math calculations.
    - [kdheepak/cmp-latex-symbols](https://github.com/kdheepak/cmp-latex-symbols) - Add latex symbol support for nvim-cmp.
    - [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) - luasnip completion source for nvim-cmp.
    - [L3MON4D3/cmp-luasnip-choice](https://github.com/L3MON4D3/cmp-luasnip-choice) - Luasnip choice node completion source for nvim-cmp.
    - [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) - nvim-cmp source for neovim builtin LSP client.
    - [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path) - nvim-cmp source for path.
    - https://github.com/petertriho/cmp-git
    - https://github.com/kdheepak/cmp-latex-symbols

#### Core UI

- [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim) - A snazzy bufferline for Neovim.
- [rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify) - A fancy, configurable, notification manager for NeoVim.

#### Editing

- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) - Autopairs for neovim written by lua.

#### General Purpose

- [echasnovski/mini.nvim](https://github.com/echasnovski/mini.nvim/) - Library of 25+ independent Lua modules improving overall Neovim (version 0.7 and higher) experience with minimal effort.
    - [mini.animate](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-animate.md) - Animate common Neovim actions.
    - [mini.comment](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md) - Comment lines.
    - [mini.indentscope](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-indentscope.md) - Visualize and work with indent scope.
    - [mini.map](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-map.md) - Window with buffer text overview, scrollbar, and highlights.

#### Git

- [sindrets/diffview.nvim](https://github.com/sindrets/diffview.nvim) - Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
- [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive) - fugitive.vim: A Git wrapper so awesome, it should be illegal.
- [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git integration for buffers

#### Keybinding

- [folke/which-key.nvim](https://github.com/folke/which-key.nvim) - Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing.

#### LSP (Language Server Protocol)

- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - Quickstart configs for Nvim LSP.
- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) - Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim. Strongly recommended for Windows users.

#### Package Manager

- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) - Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.

#### Search

- [romainl/vim-cool](https://github.com/romainl/vim-cool) - A very simple plugin that makes hlsearch more useful.

#### Treesitter

- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Nvim Treesitter configurations and abstraction layer.
    - [nvim-treesitter/playground](https://github.com/nvim-treesitter/playground) - Treesitter playground integrated into Neovim.
- [nvim-treesitter/nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) - Show code context.
- [nvim-treesitter/textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) - Syntax aware text-objects, select, move, swap, and peek support.
- [RRethy/nvim-treesitter-textsubjects)](https://github.com/RRethy/nvim-treesitter-textsubjects) - Location and syntax aware text objects which *do what you mean*.
    

## Custom

## TODO

- Completion
    - fix luasnip node shit
- Plugins
    - https://github.com/DNLHC/glance.nvim
    - https://github.com/jcdickinson/wpm.nvim
    - https://github.com/nvim-neotest/neotest
    - https://github.com/smjonas/inc-rename.nvim
    - https://github.com/koenverburg/peepsight.nvim
    - https://github.com/uga-rosa/ccc.nvim
    - https://github.com/jbyuki/nabla.nvim
    - https://github.com/VidocqH/lsp-lens.nvim
    - https://github.com/chrisgrieser/nvim-early-retirement
    - https://github.com/t-troebst/perfanno.nvim
    - https://github.com/ThePrimeagen/refactoring.nvim
    - https://github.com/zbirenbaum/copilot.lua
    - https://github.com/zbirenbaum/copilot-cmp
    - https://github.com/jmbuhr/otter.nvim
- LSP
    - Toggle underlines
    - Toggle autoformat
    - Java
        - Add runtime select
- Treesitter
    - keymaps
    - https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    - https://github.com/RRethy/nvim-treesitter-textsubjects

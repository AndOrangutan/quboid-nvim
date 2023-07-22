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

- [folke/lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin Manager, best one I have tried

#### Colorschemes

- [Shatur/neovim-ayu](https://github.com/Shatur/neovim-ayu) - Ayu theme for Neovim
- [neanias/everforest-nvim](https://github.com/neanias/everforest-nvim) - A Lua port of the Everforest colour scheme
- [rebelot/kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) - NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai.
- [navarasu/onedark.nvim](https://github.com/navarasu/onedark.nvim) - One dark and light colorscheme for neovim >= 0.5.0 written in lua based on Atom's One Dark and Light theme. Additionally, it comes with 5 color variant styles

#### Core UI

- [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim) - A snazzy bufferline for Neovim
- [rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify) - A fancy, configurable, notification manager for NeoVim

#### General Purpose

- [echasnovski/mini.nvim](https://github.com/echasnovski/mini.nvim/) - Library of 25+ independent Lua modules improving overall Neovim (version 0.7 and higher) experience with minimal effort.
    - [mini.animate](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-animate.md) - Animate common Neovim actions
    - [mini.comment](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md) - Comment lines
    - [mini.indentscope](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-indentscope.md) - Visualize and work with indent scope
    - [mini.map](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-map.md) - Window with buffer text overview, scrollbar, and highlights

#### Keybinding

- [folke/which-key.nvim](https://github.com/folke/which-key.nvim) - Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing.

### LSP (Language Server Protocol)

- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - Quickstart configs for Nvim LSP 
- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) - Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim. Strongly recommended for Windows users.

#### Package Manager

- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) - Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.

#### Search

- [romainl/vim-cool](https://github.com/romainl/vim-cool) - A very simple plugin that makes hlsearch more useful. 

## Custom

## TODO

- LSP
    - Toggle underlines
    - Toggle autoformat

# quboid-nvim

Resiliant, fast, text-based Personal Development Environment

## What is Quboid?

<!-- fill in  -->

## Requirements 

- fd
- rg
- chafa
- viu
- ueberzug

## Todo 

- Look up best way to store global variables ()
- Lead with documentation.
- Add
    - https://github.com/ThePrimeagen/git-worktree.nvim

## File Structure

```
$ tree -d
.
├── configs
├── ftplugin
├── init.lua
├── LICENSE
├── lua
│   ├── colorscheme.lua
│   ├── defaults
│   │   ├── autocmds.lua
│   │   ├── keymaps.lua
│   │   └── options.lua
│   ├── plugins
│   ├── plugins.lua
│   ├── quboid.lua
│   ├── user
│   │   ├── autocmds.lua
│   │   ├── keymaps.lua
│   │   └── options.lua
│   └── util.lua
└── README.md           <-- You are here
```

## Plugins

- [folke/lazy.nvim](https://github.com/folke/lazy.nvim)

### Colorschemes

- [navarasu/onedark.nvim](https://github.com/navarasu/onedark.nvim) - One dark and light colorscheme for neovim >= 0.5.0 written in lua based on Atom's One Dark and Light theme. Additionally, it comes with 5 color variant styles

### Completion

### Core Ui

- [rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify) - A fancy, configurable, notification manager for NeoVim 
- [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) - A fancy, configurable, notification manager for NeoVim

### Core Ui Buffers

### Cosmetic Bloat

- [mvllow/modes.nvim](https://github.com/mvllow/modes.nvim) - Prismatic line decorations for the adventurous vim user

### DAP (Debug Adapter Protocol)

### Filetype Specific

### General Purpose

- [echasnovski/mini.nvim](https://github.com/echasnovski/mini.nvim/) - Library of 25+ independent Lua modules improving overall Neovim (version 0.7 and higher) experience with minimal effort.
    - [mini.ai](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md) - Extend and create a/i textobjects.
    ```
    |Key|     Name      |   Example line   |   a    |   i    |   2a   |   2i   |
    |---|---------------|-1234567890123456-|--------|--------|--------|--------|
    | ( |  Balanced ()  | (( *a (bb) ))    |        |        |        |        |
    | [ |  Balanced []  | [[ *a [bb] ]]    | [2;12] | [4;10] | [1;13] | [2;12] |
    | { |  Balanced {}  | {{ *a {bb} }}    |        |        |        |        |
    | < |  Balanced <>  | << *a <bb> >>    |        |        |        |        |
    |---|---------------|-1234567890123456-|--------|--------|--------|--------|
    | ) |  Balanced ()  | (( *a (bb) ))    |        |        |        |        |
    | ] |  Balanced []  | [[ *a [bb] ]]    |        |        |        |        |
    | } |  Balanced {}  | {{ *a {bb} }}    | [2;12] | [3;11] | [1;13] | [2;12] |
    | > |  Balanced <>  | << *a <bb> >>    |        |        |        |        |
    | b |  Alias for    | [( *a {bb} )]    |        |        |        |        |
    |   |  ), ], or }   |                  |        |        |        |        |
    |---|---------------|-1234567890123456-|--------|--------|--------|--------|
    | " |  Balanced "   | "*a" " bb "      |        |        |        |        |
    | ' |  Balanced '   | '*a' ' bb '      |        |        |        |        |
    | ` |  Balanced `   | `*a` ` bb `      | [1;4]  | [2;3]  | [6;11] | [7;10] |
    | q |  Alias for    | '*a' " bb "      |        |        |        |        |
    |   |  ", ', or `   |                  |        |        |        |        |
    |---|---------------|-1234567890123456-|--------|--------|--------|--------|
    | ? |  User prompt  | e*e o e o o      | [3;5]  | [4;4]  | [7;9]  | [8;8]  |
    |   |(typed e and o)|                  |        |        |        |        |
    |---|---------------|-1234567890123456-|--------|--------|--------|--------|
    | t |      Tag      | <x>*</x><y>b</y> | [1;8]  | [4;4]  | [9;16] |[12;12] |
    |---|---------------|-1234567890123456-|--------|--------|--------|--------|
    | f | Function call | f(a, g(*b, c) )  | [6;13] | [8;12] | [1;15] | [3;14] |
    |---|---------------|-1234567890123456-|--------|--------|--------|--------|
    | a |   Argument    | f(*a, g(b, c) )  | [3;5]  | [3;4]  | [5;14] | [7;13] |
    |---|---------------|-1234567890123456-|--------|--------|--------|--------|
    |   |    Default    |                  |        |        |        |        |
    |   |   (digits,    | aa_*b__cc___     | [4;7]  | [4;5]  | [8;12] | [8;9]  |
    |   | punctuation,  | (example for _)  |        |        |        |        |
    |   | or whitespace)|                  |        |        |        |        |
    |---|---------------|-1234567890123456-|--------|--------|--------|--------|
    ```
    - [mini.animate](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-animate.md) - Animate common Neovim actions
    - [mini.comment](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md) - Comment lines
    - [mini.indentscope](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-indentscope.md) - Visualize and work with indent scope
    - [mini.map](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-map.md) - Window with buffer text overview, scrollbar, and highlights

### Git

- [sindrets/diffview.nvim](https://github.com/sindrets/diffview.nvim) - Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
- [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git integration for buffers
- [akinsho/git-conflict.nvim](https://github.com/akinsho/git-conflict.nvim) - A plugin to visualise and resolve merge conflicts in neovim
    - Keymaps
        - `c` `o` — choose ours
        - `c` `t` — choose theirs
        - `c` `b` — choose both
        - `c` `0` — choose none
        - `]` `x` — move to previous conflict
        - `[` `x` — move to next conflict
- [TimUntersberger/neogit](https://github.com/TimUntersberger/neogit) - magit for neovim

### Filetype Specific

#### Java

#### Lua

#### Markdown

### Keybinding

- [folke/which-key.nvim](https://github.com/folke/which-key.nvim) - Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing.

### LSP (Language Server Protocol)

- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - Quickstart configs for Nvim LSP 
    - [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) - Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim. Strongly recommended for Windows users.

### Package Manager

- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) - Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.

### Picker

- [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim) - Neovim plugin to improve the default vim.ui interfaces.
- [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua) - Improved fzf.vim written in lua

### Treesitter

- [kylechui/nvim-surround](https://github.com/kylechui/nvim-surround) - Add/change/delete surrounding delimiter pairs with ease. Written with `<3` in Lua.
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Nvim Treesitter configurations and abstraction layer
    - [nvim-treesitter/nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) - Show code context
    - [RRethy/nvim-treesitter-endwise](https://github.com/RRethy/nvim-treesitter-endwise) - Wisely add "end" in Ruby, Vimscript, Lua, etc. Tree-sitter aware alternative to tpope's vim-endwise
    - [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) - Use treesitter to auto close and auto rename html tag
    - [JoosepAlviste/nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring) - Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
- [ckolkey/ts-node-action](https://github.com/CKolkey/ts-node-action) - Neovim Plugin for running functions on nodes.

### Window Management

- [mrjones2014/smart-split.nvim](https://github.com/mrjones2014/smart-splits.nvim) - Smart, seamless, directional navigation and resizing of Neovim + terminal multiplexer splits. Supports tmux, Wezterm, and Kitty. Think about splits in terms of "up/down/left/right".
- 
## Tips

## Resources

- [awesome-nvim](https://github.com/rockerBOO/awesome-neovim)

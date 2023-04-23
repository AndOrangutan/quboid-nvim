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
    - https://github.com/jcdickinson/wpm.nvim

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

- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - A completion plugin for neovim coded in Lua.
    - [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path) - nvim-cmp source for path 
    - [kdheepak/cmp-latex-symbols](https://github.com/kdheepak/cmp-latex-symbols) -  Add latex symbol support for nvim-cmp
    - [hrsh7th/cmp-calc](https://github.com/hrsh7th/cmp-calc) - nvim-cmp source for math calculation
    - [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) - luasnip completion source for nvim-cmp
    - [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) -  nvim-cmp source for neovim builtin LSP client
    - [ray-x/cmp-treesitter](https://github.com/ray-x/cmp-treesitter) - cmp source for treesitter
    - [petertriho/cmp-git](petertriho/cmp-git) - Git source for nvim-cmp
    - [hrsh7th/cmp-nvim-lsp-document-symbol](https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol) - nvim-cmp source for textDocument/documentSymbol via nvim-lsp
    - [David-Kunz/cmp-npm](https://github.com/David-Kunz/cmp-npm) - An additional source for nvim-cmp to autocomplete packages and its versions
    - [jcha0713/cmp-tw2css](https://github.com/jcha0713/cmp-tw2css) - A source for nvim-cmp to convert tailwindcss classes to pure css codes
    - [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer) - nvim-cmp source for buffer words
    - [hrsh7th/cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline) - nvim-cmp source for vim's cmdline
    - [uga-rosa/cmp-dictionary](https://github.com/uga-rosa/cmp-dictionary) - nvim-cmp source for dictionary
    - [lukas-reineke/cmp-rg](https://github.com/lukas-reineke/cmp-rg) - ripgrep source for nvim-cmp
- [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) - Snippet Engine for Neovim written in Lua.

### Core Ui

- [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim) - A snazzy bufferline for Neovim
- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - A blazing fast and easy to configure neovim statusline plugin written in pure lua.
- [rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify) - A fancy, configurable, notification manager for NeoVim
- [luukvball/statuscol.nvim](https://github.com/luukvbaal/statuscol.nvim) - Status column plugin that provides a configurable 'statuscolumn' and click handlers.
- [kevinhwang91/nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) - Not UFO in the sky, but an ultra fold in Neovim.

### Core Ui Buffers

- [goolord/alpha-vim](https://github.com/goolord/alpha-nvim) - a lua powered greeter like vim-startify / dashboard-nvim 
- [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) - A fancy, configurable, notification manager for NeoVim
- [simrat39/symbols-outline.nvim](https://github.com/simrat39/symbols-outline.nvim) - A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favorite languages.
- [folke/trouble.nvim](https://github.com/folke/trouble.nvim) - A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
    - [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim) - Highlight, list and search todo comments in your projects.
- [mbbill/undotree](https://github.com/mbbill/undotree) - The undo history visualizer for VIM

### Cosmetic Bloat

- [m4xshen/smartcolumn.nvim](https://github.com/m4xshen/smartcolumn.nvim) - A Neovim plugin hiding your colorcolumn when unneeded.

### DAP (Debug Adapter Protocol)

### Editing

- [NMAC427/guess-indent.nvim](https://github.com/NMAC427/guess-indent.nvim) - Automatic indentation style detection for Neovim

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
- [ThePrimeagen/git-worktree.nvim](https://github.com/ThePrimeagen/git-worktree.nvim) - A simple wrapper around git worktree operations, create, switch, and delete.
- [TimUntersberger/neogit](https://github.com/TimUntersberger/neogit) - magit for neovim

### Filetype Specific

#### Java

#### Lua

- [folke/neodev.nvim](https://github.com/folke/neodev.nvim) - Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.

#### Markdown

### Keybinding

- [folke/which-key.nvim](https://github.com/folke/which-key.nvim) - Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing.

### LSP (Language Server Protocol)

- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - Quickstart configs for Nvim LSP 
    - [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) - Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim. Strongly recommended for Windows users.
    - [weilbith/nvim-code-action-menu](https://github.com/weilbith/nvim-code-action-menu) - Pop-up menu for code actions to show meta-information and diff preview
    - [rmagatti/goto-preview](https://github.com/rmagatti/goto-preview) - A small Neovim plugin for previewing definitions using floating windows
    - [whynothugo/lsp_lines.nvim](https://sr.ht/~whynothugo/lsp_lines.nvim/) - A simple neovim plugin that renders diagnostics using virtual lines on top of the real line of code.
    - [ray-x/lsp_signature.nvim](https://github.com/ray-x/lsp_signature.nvim) - LSP signature hint as you type
- [utilyre/barbecue.nvim](https://github.com/utilyre/barbecue.nvim) - A VS Code like winbar for Neovim
    - [SmiteshP/nvim-navic](https://github.com/SmiteshP/nvim-navic) - Simple winbar/statusline plugin that shows your current code context
- [RRethy/vim-illuminate](https://github.com/RRethy/vim-illuminate) - (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching
- [jose-elias-alvarez/null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim) - Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
    - [jay-babu/mason-null-ls.nvim](https://github.com/jay-babu/mason-null-ls.nvim) - mason-null-ls bridges mason.nvim with the null-ls plugin - making it easier to use both plugins together.

### Package Manager

- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) - Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.

### Picker

- [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim) - Neovim plugin to improve the default vim.ui interfaces.
- [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua) - Improved fzf.vim written in lua

### Session Manager

- [Shatur/neovim-session-manager](https://github.com/Shatur/neovim-session-manager) - A simple wrapper around :mksession.

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

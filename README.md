# quboid-nvim

Resiliant, fast, text-based Personal Development Environment

## What is Quboid?

<!-- fill in  -->

## Todo 

- Look up best way to store global variables ()
- Lead with documentation.

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

#### Onedark

#### Everforrest

#### Ayu

### Completion

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
    - 


#### Java

#### Lua

#### Markdown

### Keybinding

- [folke/which-key.nvim](https://github.com/folke/which-key.nvim) - Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing.

### LSP (Language Server Protocol)

### Picker

- [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim) - Neovim plugin to improve the default vim.ui interfaces.

### Window Management

- [mrjones2014/smart-split.nvim](https://github.com/mrjones2014/smart-splits.nvim) - Smart, seamless, directional navigation and resizing of Neovim + terminal multiplexer splits. Supports tmux, Wezterm, and Kitty. Think about splits in terms of "up/down/left/right".
- 
## Tips

## Resources

- [awesome-nvim](https://github.com/rockerBOO/awesome-neovim)

# Quboid Nvim

**Core Features:**

- FAST
- Dependable

**Dependencies:**

- **Hard**
- **Soft**
    - Tmux
## Directory

```
I.
├── after
│   └── syntax          Loaded after syntax
│       ├── markdown
│       └── tex
├── ftplugin            filetype specific configs
└── lua                 General Config
    ├── configs         Plugin specific configs
    ├── defaults        Mainly stock neovim settings
    └── plugins         Plugin install specs
```

## Features

### Git

### Keymapping

Keymaps can be easily set with `vim.keymap.set()` or custom `util.keymap()`. Main plugins are [which-key.nvim](https://github.com/folke/which-key.nvim) for keymap preview and [legendary.nvim](https://github.com/mrjones2014/legendary.nvim) to search said mappings.

<!-- TODO: Add preview here -->


### General Editing

### General UI

### Treesitter and Textobj

### Language Server Protocol (LSP)

### Debug Adapter Protocol (DAP)

### Filetype Specific

#### Markdown


## TODO

- Plugins
    - Change statusline
    - better lists
    - [x] Fix autopairs 
    - [x] Mini ? 
    - [ ] Spelling 
    - [ ] Add guess-indent 
    - [ ] Notebook 
        - Use this to create a template picker :) https://github.com/AndOrangutan/nvim-config/blob/main/lua/configs/alpha.lua
    - [ ] Null-ls 
    - [ ] https://github.com/tpope/vim-dadbod
    - [ ] Convert from lualine -> heirline 
    - [ ] Copiolot.lua 
    - [ ] cmp 
        - https://github.com/uga-rosa/cmp-dictionary
        - https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol
        - https://github.com/lukas-reineke/cmp-rg
        - https://github.com/David-Kunz/cmp-npm
        - https://github.com/jcha0713/cmp-tw2css
        - https://github.com/zbirenbaum/copilot-cmp
        - https://github.com/rcarriga/cmp-dap
        - https://github.com/chrisgrieser/cmp-nerdfont
        - https://github.com/ray-x/cmp-treesitter
        - https://github.com/kristijanhusak/vim-dadbod-completion
    - [ ] git 
        - octo
        - diffview
    - [ ] Investigate :Neogit Killing bufferline 
    - [ ] Bufferline toggle theme 
    - [ ] Convert keybinds to `vim.keymap.set('n', 'gq', '<cmd>lua vim.lsp.buf.formatting()<CR>', { desc = "format document [LSP]" })` 
    - [ ] Folds (ufo) 
    - [ ] Testing 
    - [ ] Dap 
    - [ ] Mouse 
        - Menu items
            - LSP
                -  Code act
                - format
                - Rename
                - Goto Def
                - Goto Dec
                - 
            - UI
                -   Symbol Outline (_)
                -   Fuzzy Search (_f)
                -   Quickfix (_xx)
            - Refactoring
        - Make items safe with pcalls for plug-in
    - [ ] https://github.com/mfussenegger/nvim-jdtls 
    - [ ] https://github.com/zbirenbaum/copilot.lua 
    - [ ] https://www.reddit.com/r/neovim/comments/rw4imi/what_is_the_most_interesting_part_of_your_lua/ 
    - [ ] 
    - Note taking
        - [ ] Easy output
            - PDF
            - HTML
            - DOCX
- README.md
    - Projectify it


esilient, fast, text-based Personal Development Environment

- Make it pretty 
    - DOCUMENTATION :')

```bash
nvim -u ~/dev/quboid-nvim/init.lua
```

```java
public class lua_N5sjf7 {
    public static void main(String[] args) {
        System.out.println("Hello WOrld");
    }
}
```

- Creat binding to open

## Goals

## Install

### Dependencies
- Necessary 
    - neovim-git
- Optional
    - glow

```
neovim-git qutebrowser
```

## Add to somewher later

### Useful Commands

code
Replace Unicode characters in the form `\uXXXX` to their respective icon

```
:%s/\\u\(\x\{4\}\)/\=nr2char('0x'.submatch(1),1)/g
:lua print(require('nvim-nonicons').get('alert'))
```

## Resources

- [Tips and tricks to reduce startup and Improve your lua config](https://www.reddit.com/r/neovim/comments/opipij/guide_tips_and_tricks_to_reduce_startup_and/)
- [ibhagwan's config](https://github.com/ibhagwan/nvim-lua)
- 


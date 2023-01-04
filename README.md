# Quboid Nvim
 
## TODO


- Plugins
    - [x] Fix autopairs
    - [x] Mini ? 
    - [ ] Spelling 
    - [ ] LSP 
    - [ ] Null-ls 
        - Incremental rename (other functions?)
    - [ ] Gitsins extract icons to quboid 
    - [ ] Bufferline toggle theme 
    - [ ] Snippets 
    - [ ] Folds (ufo) 
    - [ ] TODO trouble 
        - [ ] also fix it so it doesn't jump when scrolling.
    - [ ] Testing 
    - [ ] Dap 
    - [ ] Session 
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

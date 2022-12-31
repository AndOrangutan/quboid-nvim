# Quboid Nvim


- Plugins
    - [ ] Fix autopairs
    - [ ] Mini 
    - [ ] LSP 
        - Lines Alternative
        - Better CMP
        - Animation [link](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-animate.md)
    - [ ] Null-ls 
    - [ ] Snippets 
        - Fix conflict with auto bullet
    - [ ] Folds (ufo) 
    - [ ] Testing 
    - [ ] Dap 
    - [ ] Session 
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

Resilient, fast, text-based Personal Development Environment

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

## Todo

- [ ] Add docs/
- [ ] Add lua/

## Add to somewher later

### Useful Commands

Replace Unicode characters in the form `\uXXXX` to their respective icon

```
:%s/\\u\(\x\{4\}\)/\=nr2char('0x'.submatch(1),1)/g
:lua print(require('nvim-nonicons').get('alert'))
```

## Resources

- [Tips and tricks to reduce startup and Improve your lua config](https://www.reddit.com/r/neovim/comments/opipij/guide_tips_and_tricks_to_reduce_startup_and/)
- [ibhagwan's config](https://github.com/ibhagwan/nvim-lua)
- 

# Quboid Neovim 2.0

My fast, fun, text-based playground. Rewriting instead of continuing this never
ending migration to new tastes.

## Why not use a pre-config?

I want my editor to be mine, and feel like a videogame. While neovim generally
does the latter, if I am using a "niche" editor I want it to be mine.

## Goals

- Minimally modify configs, with sane default bindings.
- Document as we go.
- Never compromising snappy feel; whether pc or personal performance.
- Low noise.
- Integrate (theme changing) with Aweseomewm

## Requirements

### Dependencies

- Operating system
  - `Linux` or `MacOS` (duh)
- Command line tools
  - `[fzf](https://github.com/junegunn/fzf)`
  - `[fd](https://github.com/sharkdp/fd)`
  - `[rg](https://github.com/BurntSushi/ripgrep)`
  - `[dleta](https://github.com/dandavison/delta)`
  - `[ueberzug](https://github.com/seebye/ueberzug)`
  - `[wordnet](https://wordnet.princeton.edu/)`

```
paru -S fzf fd ripgrep git-delta ueberzug wordnet-cli
```

### Plugins

- [Plugin list](docs/Plugins.md)

## Examples

### Creating and managing files and directories

1. Neovim has many options, that work great if you know exactly which file you
   want to creat and then edit.
2. To open a more standard file tree, wee have neo-tree bound to `<leader>nn`.

## TODO

- Make the editor debuggable
  - https://github.com/jbyuki/one-small-step-for-vimkind
- Documentation
  - LSP
  - Picker
  - Filetree

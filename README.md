# quboid-nvim

Resiliant, fast, text-based Personal Development Environment

## What is quboid

## Requirements

### Dependencies



## Core

### Features

#### Git workflow

##### Fugative

##### Neogetting into a UI

##### Conflict Resolution

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

#### Navigation

##### Marks

Keymaps:

```
    mx              Set mark x
    m,              Set the next available alphabetical (lowercase) mark
    m;              Toggle the next available mark at the current line
    dmx             Delete mark x
    dm-             Delete all marks on the current line
    dm<space>       Delete all marks in the current buffer
    m]              Move to next mark
    m[              Move to previous mark
    m:              Preview mark. This will prompt you for a specific mark to
                    preview; press <cr> to preview the next mark.
                    
    m[0-9]          Add a bookmark from bookmark group[0-9].
    dm[0-9]         Delete all bookmarks from bookmark group[0-9].
    m}              Move to the next bookmark having the same type as the bookmark under
                    the cursor. Works across buffers.
    m{              Move to the previous bookmark having the same type as the bookmark under
                    the cursor. Works across buffers.
    dm=             Delete the bookmark under the cursor.
```

#### By Language

##### Go

##### Java

### Plugins

- [folke/lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin Manager, best one I have tried.

#### Bloat (Totally deserves to be this high up haha)

#### Colorschemes

- [rktjmp/lush.nvim](https://github.com/rktjmp/lush.nvim) - Create Neovim themes with real-time feedback, export anywhere.
- [Shatur/neovim-ayu](https://github.com/Shatur/neovim-ayu) - Ayu theme for Neovim
- [neanias/everforest-nvim](https://github.com/neanias/everforest-nvim) - A Lua port of the Everforest colour scheme.
- [rebelot/kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) - NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai.
- [navarasu/onedark.nvim](https://github.com/navarasu/onedark.nvim) - One dark and light colorscheme for neovim >= 0.5.0 written in lua based on Atom's One Dark and Light theme. Additionally, it comes with 5 color variant styles.
- [scysta/pink-panic.nvim](https://github.com/scysta/pink-panic.nvim) - A simple and pretty pink colorscheme for Neovim made with Lush.

#### Completion

- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - A completion plugin for neovim coded in Lua.
    - [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer) - nvim-cmp source for buffer words.
    - [hrsh7th/cmp-calc](https://github.com/hrsh7th/cmp-calc) - nvim-cmp source for math calculations.
    - [petertriho/cmp-git](https://github.com/petertriho/cmp-git) - Git source for nvim-cmp.
    - [kdheepak/cmp-latex-symbols](https://github.com/kdheepak/cmp-latex-symbols) - Add latex symbol support for nvim-cmp.
    - [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) - luasnip completion source for nvim-cmp.
    - [L3MON4D3/cmp-luasnip-choice](https://github.com/L3MON4D3/cmp-luasnip-choice) - Luasnip choice node completion source for nvim-cmp.
    - [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) - nvim-cmp source for neovim builtin LSP client.
    - [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path) - nvim-cmp source for path.

#### Core UI

- [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim) - A snazzy bufferline for Neovim.
- [rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify) - A fancy, configurable, notification manager for NeoVim.
- [luukvball/statuscol.nvim](https://github.com/luukvbaal/statuscol.nvim) - Status column plugin that provides a configurable 'statuscolumn' and click handlers.
- [kevinhwang91/nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) - Not UFO in the sky, but an ultra fold in Neovim.

#### Core UI Buffers

- [goolord/alpha-nvim](https://github.com/goolord/alpha-nvim) - a lua powered greeter like vim-startify / dashboard-nvim 
- [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) - Neovim plugin to manage the file system and other tree like structures.
- [folke/trouble.nvim](https://github.com/folke/trouble.nvim) - A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
    - [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim) - Highlight, list and search todo comments in your projects.
- [mbbill/undotree](https://github.com/mbbill/undotree) - The undo history visualizer for VIM.

#### Dependencies

- [stefanlogue/hydrate.nvim](https://github.com/stefanlogue/hydrate.nvim) - Reminders to keep hydrated while you code.
- [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) - lua `fork` of vim-web-devicons for neovim.

#### Editing

- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) - Autopairs for neovim written by lua.

#### Filetype Specific

##### Lua

- [folke/neodev.nvim](https://github.com/folke/neodev.nvim) - Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.

##### Markdown

- [postfen/clipboard-image.nvim](https://github.com/postfen/clipboard-image.nvim) - Neovim Lua plugin to paste image from clipboard.
- [AckslD/nvim-FeMaco.lua](https://github.com/AckslD/nvim-FeMaco.lua) - Catalyze your Fenced Markdown Code-block editing!
- [lukas-reineke/headlines.nvim](https://github.com/lukas-reineke/headlines.nvim) - This plugin adds horizontal highlights for text filetypes, like markdown, orgmode, and neorg.
- [preservim/vim-markdown](https://github.com/preservim/vim-markdown) - Markdown Vim Mode
- [iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) - markdown preview plugin for (neo)vim
- [mickael-menu/zk-nvim](https://github.com/mickael-menu/zk-nvim) - Neovim extension for zk.

#### General Purpose

- [echasnovski/mini.nvim](https://github.com/echasnovski/mini.nvim/) - Library of 25+ independent Lua modules improving overall Neovim (version 0.7 and higher) experience with minimal effort.
    - [mini.animate](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-animate.md) - Animate common Neovim actions.
    - [mini.comment](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md) - Comment lines.
    - [mini.indentscope](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-indentscope.md) - Visualize and work with indent scope.
    - [mini.map](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-map.md) - Window with buffer text overview, scrollbar, and highlights.

#### Git

- [sindrets/diffview.nvim](https://github.com/sindrets/diffview.nvim) - Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
- [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive) - fugitive.vim: A Git wrapper so awesome, it should be illegal.
- [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git integration for buffers.
- [ThePrimeagen/git-worktree.nvim](https://github.com/ThePrimeagen/git-worktree.nvim) - A simple wrapper around git worktree operations, create, switch, and delete.
- [TimUntersberger/neogit](https://github.com/TimUntersberger/neogit) - magit for neovim.

#### Keybinding

- [folke/which-key.nvim](https://github.com/folke/which-key.nvim) - Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing.

#### LSP (Language Server Protocol)

- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - Quickstart configs for Nvim LSP.
    - [whynothugo/lsp_lines.nvim](https://sr.ht/~whynothugo/lsp_lines.nvim/) - A simple neovim plugin that renders diagnostics using virtual lines on top of the real line of code.
    - [ray-x/lsp_signature.nvim](https://github.com/ray-x/lsp_signature.nvim) - LSP signature hint as you type.
- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) - Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim. Strongly recommended for Windows users.
- [jose-elias-alvarez/null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim) - Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
- [jay-babu/mason-null-ls.nvim](https://github.com/jay-babu/mason-null-ls.nvim) - mason-null-ls bridges mason.nvim with the null-ls plugin - making it easier to use both plugins together.
- [DNLHC/glance.nvim](https://github.com/DNLHC/glance.nvim) - A pretty window for previewing, navigating and editing your LSP locations.
- [zbirenbaum/neodim](https://github.com/zbirenbaum/neodim) - Neovim plugin for dimming the highlights of unused functions, variables, parameters, and more.

#### Package Manager

- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) - Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.

#### Navigation

- [jinh0/eyeliner.nvim](https://github.com/jinh0/eyeliner.nvim) - Move faster with unique f/F indicators.
- [ThePrimeagen/harpoon](https://github.com/ThePrimeagen/harpoon) - Getting you where you want with the fewest keystrokes.
- [chentoast/marks.nvim](https://github.com/chentoast/marks.nvim) - A better user experience for viewing and interacting with Vim marks.

#### Picker

- [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim) - Neovim plugin to improve the default vim.ui interfaces.
- [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua) - Improved fzf.vim written in lua

#### Search

- [romainl/vim-cool](https://github.com/romainl/vim-cool) - A very simple plugin that makes hlsearch more useful.

### Sessions

- [Shatur/neovim-session-manager](https://github.com/Shatur/neovim-session-manager) - A simple wrapper around :mksession.

#### Statusline

- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - A blazing fast and easy to configure neovim statusline plugin written in pure lua.
    - [linrongbin16/lsp-progress.nvim](https://github.com/linrongbin16/lsp-progress.nvim) - A performant lsp progress status for Neovim. 

#### Treesitter

- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Nvim Treesitter configurations and abstraction layer.
    - [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) - Use treesitter to auto close and auto rename html tag
    - [JoosepAlviste/nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring) - Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
    - [RRethy/nvim-treesitter-endwise](https://github.com/RRethy/nvim-treesitter-endwise) - Wisely add "end" in Ruby, Vimscript, Lua, etc. Tree-sitter aware alternative to tpope's vim-endwise
    - [nvim-treesitter/playground](https://github.com/nvim-treesitter/playground) - Treesitter playground integrated into Neovim.
    - [nvim-treesitter/textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) - Syntax aware text-objects, select, move, swap, and peek support.
    - [RRethy/nvim-treesitter-textsubjects)](https://github.com/RRethy/nvim-treesitter-textsubjects) - Location and syntax aware text objects which *do what you mean*.
- [nvim-treesitter/nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) - Show code context.
- [hiphish/rainbow-delimiters.nvim](https://github.com/hiphish/rainbow-delimiters.nvim) - Rainbow delimiters for Neovim with Tree-sitter.
- [ckolkey/ts-node-action](https://github.com/CKolkey/ts-node-action) - Neovim Plugin for running functions on nodes.

#### Window Management

- [famiu/bufdelete.nvim](https://github.com/famiu/bufdelete.nvim) - Delete Neovim buffers without losing window layout.
- [mrjones2014/smart-split.nvim](https://github.com/mrjones2014/smart-splits.nvim) - Smart, seamless, directional navigation and resizing of Neovim + terminal multiplexer splits. Supports tmux, Wezterm, and Kitty. Think about splits in terms of "up/down/left/right".

## Custom

## TODO

- Completion
    - fix luasnip node shit
- Plugins
    - https://github.com/m4xshen/hardtime.nvim
    - https://github.com/nvim-neotest/neotest
    - https://github.com/andythigpen/nvim-coverage
    - https://github.com/JMarkin/cmp-diag-codes
    - https://github.com/tpope/vim-dadbod
    - https://github.com/kristijanhusak/vim-dadbod-completion
    - https://github.com/paopaol/cmp-doxygen
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
    - https://github.com/dkarter/bullets.vim
    - https://github.com/martineausimon/nvim-xresources
    https://www.reddit.com/r/neovim/comments/15cza0z/created_a_little_utility_for_tailwind_to_get_all/
    - https://github.com/MaximilianLloyd/tw-values.nvim
- LSP
    - Toggle underlines
    - Toggle autoformat
    - Java
        - Add runtime select
- Treesitter
    - keymaps
    - https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    - https://github.com/RRethy/nvim-treesitter-textsubjects

# quboid-nvim

Resiliant, fast, text-based Personal Development Environment

## What is quboid

## Requirements

### Dependencies and External Tools

- [junegunn/fzf](https://github.com/junegunn/fzf)
- [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep)
- [ImageMagick/ImageMagick](https://github.com/ImageMagick/ImageMagick)
- [jstkdng/ueberzugpp](https://github.com/jstkdng/ueberzugpp)
- `luarocks --local --lua-version=5.1 install magick`


## Core

### Features

#### Language Support

| Language          | LSP                                       | Format            | Lint              | DAP               |
|-------------------|-------------------------------------------|-------------------|-------------------|-------------------|
| AWK               | `awk_ls`                                  | -                 | -                 | -                 |
| Angular           | `angluarls`                               | -                 | -                 | -                 |
| Ansible           | `als`                                     | -                 | -                 | -                 |
| Arduino           | `arduino_language_server`                 | -                 | -                 | -                 |
| Assembly          | `asm_lsp`                                 | -                 | -                 | -                 |
| Azure Pipeline    | `azure_pipelines_ls`                      | -                 | -                 | -                 |
| Bash              | `bashls`<br>`pkgbuild_language_server`    | -                 | -                 | -                 |
| C                 | `clangd`                                  | -                 | -                 | -                 |
| C#                | `omnisharp`<br>`omnisharp_mono`           | -                 | -                 | -                 |
| CMake             | `neocmake`                                | -                 | -                 | -                 |
| CSS               | `cssls`                                   | -                 | -                 | -                 |
| Clojure           | `clojure_lsp`                             | -                 | -                 | -                 |
| Custom Elements   | `custom_elements_ls`                      | -                 | -                 | -                 |
| Deno              | `denols`                                  | -                 | -                 | -                 |
| Docker            | `dockerls`                                | -                 | -                 | -                 |
| Docker Compose    | `docker_compose_language_service`         | -                 | -                 | -                 |
| ESLint            | `eslint`                                  | -                 | -                 | -                 |
| Elixer            | `elixerls`                                | -                 | -                 | -                 |
| Fennel            | `fennel_language_server`                  | -                 | -                 | -                 |
| Fortran           | `fortls`                                  | -                 | -                 | -                 |
| Go                | `gopls`<br>`golangci_lint_ls`<br>`templ`  | -                 | -                 | -                 |
| Gradle            | `gradle_ls`                               | -                 | -                 | -                 |
| GraphQL           | `graphql`                                 | -                 | -                 | -                 |
| HTML              | `html`<br>`emmet_language_server`         | -                 | -                 | -                 |
| Haskell           | `hls`                                     | -                 | -                 | -                 |
| JSON              | `jsonls`                                  | -                 | -                 | -                 |
| Java              | `jdtls`                                   | -                 | -                 | -                 |
| JavaScript(TS)    | `tsserver`                                | -                 | -                 | -                 |
| Kotlin            | `kotlin_language_server`                  | -                 | -                 | -                 |
| LaTeX             | `ltex`<br>`texlab`                        | -                 | -                 | -                 |
| Lua               | `lua_ls`                                  | -                 | -                 | -                 |
| Markdown          | `zk`<br>`ltex`                            | -                 | -                 | -                 |
| Mathlab           | `matlab_ls`                               | -                 | -                 | -                 |
| (Neo)Mutt         | `mutt_ls`                                 | -                 | -                 | -                 |
| OCaml             | `ocamllsp`                                | -                 | -                 | -                 |
| PHP               | `intelephense`                            | -                 | -                 | -                 |
| Powershell        | `powershell_es`                           | -                 | -                 | -                 |
| Python            | `pyright`<br>`pyre`<br>`ruff_lsp`         | -                 | -                 | -                 |
| Ruby              | `ruby_ls`                                 | -                 | -                 | -                 |
| Rust              | `rust_analyzeer`                          | -                 | -                 | -                 |
| SQL               | `sqlls`                                   | -                 | -                 | -                 |
| Svelte            | `svelte`                                  | -                 | -                 | -                 |
| SystemVerilog     | `verible`                                 | -                 | -                 | -                 |
| TOML              | `taplo`                                   | -                 | -                 | -                 |
| Tailwind CSS      | `tailwindcss`                             | -                 | -                 | -                 |
| Terraform         | `terraformls`<br>`tflint`                 | -                 | -                 | -                 |
| UnoCSS            | `unocss`                                  | -                 | -                 | -                 |
| VimL              | `vimls`                                   | -                 | -                 | -                 |
| Vue               | `vtsls`                                   | -                 | -                 | -                 |
| XML               | `lemminx`                                 | -                 | -                 | -                 |
| YAML              | `yamlls`                                  | -                 | -                 | -                 |
| Zig               | `zls`                                     | -                 | -                 | -                 |



#### Git workflow

##### Fugative

##### Neogetting into a UI

##### Conflict Resolution

#### LSP (Language Server Protocol)

This is what makes modern languages and IDEs feel like a well oiled machine. Completion allows us to use longer and more descriptive names, goto-definition allows us to navigate quickly, proper renaming, and diagnostics. 

Many of these are the exact same ones you can use in VSCode, except the configuration differs largely, so they are not always feature equivalent.

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

- [echasnovski/mini.animate](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-animate.md) - Animate common Neovim actions.
- [echasnovski/mini.indentscope](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-indentscope.md) - Visualize and work with indent scope.
- [echasnovski/mini.map](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-map.md) - Window with buffer text overview, scrollbar, and highlights.

#### Code Runner

- [michaelb/sniprun](https://github.com/michaelb/sniprun) - A neovim plugin to run lines/blocs of code (independently of the rest of the file), supporting multiples languages.

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
    <!-- TODO: Fix - [petertriho/cmp-git](https://github.com/petertriho/cmp-git) - Git source for nvim-cmp. -->
    - [kdheepak/cmp-latex-symbols](https://github.com/kdheepak/cmp-latex-symbols) - Add latex symbol support for nvim-cmp.
    - [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) - luasnip completion source for nvim-cmp.
    - [L3MON4D3/cmp-luasnip-choice](https://github.com/L3MON4D3/cmp-luasnip-choice) - Luasnip choice node completion source for nvim-cmp.
    - [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) - nvim-cmp source for neovim builtin LSP client.
    - [hrsh7th/cmp-omni](https://github.com/hrsh7th/cmp-omni) - nvim-cmp source for omnifunc.
    - [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path) - nvim-cmp source for path.
    - [kristijanhusak/vim-dadbod-completion](https://github.com/kristijanhusak/vim-dadbod-completion)

#### Core UI

- [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim) - A snazzy bufferline for Neovim.
- [echasnovski/mini.notify](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-notify.md) - Show notifications.
- [luukvball/statuscol.nvim](https://github.com/luukvbaal/statuscol.nvim) - Status column plugin that provides a configurable 'statuscolumn' and click handlers.
- [kevinhwang91/nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) - Not UFO in the sky, but an ultra fold in Neovim.

#### Core UI Buffers

- [echasnovski/mini.starter](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-starter.md) - Fast and flexible start screen.
- [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) - Neovim plugin to manage the file system and other tree like structures.
- [folke/trouble.nvim](https://github.com/folke/trouble.nvim) - A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
    - [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim) - Highlight, list and search todo comments in your projects.
- [mbbill/undotree](https://github.com/mbbill/undotree) - The undo history visualizer for VIM.

#### Database

- [tpope/vim-dadbod](https://github.com/tpope/vim-dadbod) - Modern database interface for Vim .
    - [kristijanhusak/vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui) - Simple UI for vim-dadbod.

#### Dependencies

- [tpope/vim-dispatch](https://github.com/tpope/vim-dispatch) - Asynchronous build and test dispatcher.
- [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) - lua `fork` of vim-web-devicons for neovim.

#### Editing

- [echasnovski/mini.ai](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md) - Extend and create a/i textobjects.
    - [nvim-treesitter/textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) - Syntax aware text-objects.

- [echasnovski/mini.align](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-align.md) - Align text interactively.
- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) - Autopairs for neovim written by lua.
- [echasnovski/mini.comment](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md) - Comment lines.
- [NMAC427/guess-indent.nvim](https://github.com/NMAC427/guess-indent.nvim) - Automatic indentation style detection for Neovim.
- [kylechui/nvim-surround](https://github.com/kylechui/nvim-surround) - Add/change/delete surrounding delimiter pairs with ease. Written with in Lua.

#### Filetype Specific

##### Go

- [ray-x/go.nvim](https://github.com/ray-x/go.nvim) - A feature-rich Go development plugin, leveraging gopls, treesitter AST, Dap, and various Go tools to enhance the development experience.

##### Image

- [3rd/image.nvim](https://github.com/3rd/image.nvim) - Bringing images to Neovim.

##### Java

- [mfussenegger/nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls) - Extensions for the built-in LSP support in Neovim for eclipse.jdt.ls
https://github.com/Vigemus/iron.nvim
##### Lua

- [folke/neodev.nvim](https://github.com/folke/neodev.nvim) - Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.
- [milisims/nvim-luaref](https://github.com/milisims/nvim-luaref) - Add a vim :help reference for lua.

##### Markdown

- [postfen/clipboard-image.nvim](https://github.com/postfen/clipboard-image.nvim) - Neovim Lua plugin to paste image from clipboard.
- [nfrid/due.nvim](https://github.com/nfrid/due.nvim) - Neovim plugin for displaying due dates
- [AckslD/nvim-FeMaco.lua](https://github.com/AckslD/nvim-FeMaco.lua) - Catalyze your Fenced Markdown Code-block editing!
- [lukas-reineke/headlines.nvim](https://github.com/lukas-reineke/headlines.nvim) - This plugin adds horizontal highlights for text filetypes, like markdown, orgmode, and neorg.
- [preservim/vim-markdown](https://github.com/preservim/vim-markdown) - Markdown Vim Mode
- [iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) - markdown preview plugin for (neo)vim
- [mickael-menu/zk-nvim](https://github.com/mickael-menu/zk-nvim) - Neovim extension for zk.

##### Tex

- [lervag/vimtex](https://github.com/lervag/vimtex) - VimTeX: A modern Vim and neovim filetype plugin for LaTeX files.

##### Typescript/javasvript

- [barrett-ruth/import-cost.nvim](https://github.com/barrett-ruth/import-cost.nvim) - Display javascript import costs inside of neovim
- [jose-elias-alvarez/typescript.nvim](https://github.com/jose-elias-alvarez/typescript.nvim) - A Lua plugin, written in TypeScript, to write TypeScript (Lua optional).

#### General Purpose

- [echasnovski/mini.nvim](https://github.com/echasnovski/mini.nvim/) - Library of 25+ independent Lua modules improving overall Neovim (version 0.7 and higher) experience with minimal effort.

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
    - [aznhe21/actions-preview.nvim](https://github.com/aznhe21/actions-preview.nvim) - Fully customizable previewer for LSP code actions.
- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) - Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim. Strongly recommended for Windows users.
- [jose-elias-alvarez/null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim) - Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
- [jay-babu/mason-null-ls.nvim](https://github.com/jay-babu/mason-null-ls.nvim) - mason-null-ls bridges mason.nvim with the null-ls plugin - making it easier to use both plugins together.
- [DNLHC/glance.nvim](https://github.com/DNLHC/glance.nvim) - A pretty window for previewing, navigating and editing your LSP locations.
- [RRethy/vim-illuminate](https://github.com/RRethy/vim-illuminate) - (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching
- [smjonas/inc-rename.nvim](https://github.com/smjonas/inc-rename.nvim) - Incremental LSP renaming based on Neovim's command-preview feature.
- [Wansmer/symbol-usage.nvim](https://github.com/Wansmer/symbol-usage.nvim) - Display references, definitions and implementations of document symbols.

#### Package Manager

- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) - Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.

#### Navigation

- [jinh0/eyeliner.nvim](https://github.com/jinh0/eyeliner.nvim) - Move faster with unique f/F indicators.
- [ThePrimeagen/harpoon](https://github.com/ThePrimeagen/harpoon) - Getting you where you want with the fewest keystrokes.
- [chentoast/marks.nvim](https://github.com/chentoast/marks.nvim) - A better user experience for viewing and interacting with Vim marks.

#### Picker

- [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim) - Neovim plugin to improve the default vim.ui interfaces.
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Find, Filter, Preview, Pick. All lua, all the time.
    - [nvim-telescope/telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) - FZF sorter for telescope written in c

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
    - [RRethy/nvim-treesitter-textsubjects)](https://github.com/RRethy/nvim-treesitter-textsubjects) - Location and syntax aware text objects which *do what you mean*.
- [nvim-treesitter/nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) - Show code context.
- [hiphish/rainbow-delimiters.nvim](https://github.com/hiphish/rainbow-delimiters.nvim) - Rainbow delimiters for Neovim with Tree-sitter.
- [ckolkey/ts-node-action](https://github.com/CKolkey/ts-node-action) - Neovim Plugin for running functions on nodes.

#### Window Management

- [famiu/bufdelete.nvim](https://github.com/famiu/bufdelete.nvim) - Delete Neovim buffers without losing window layout.
- [mrjones2014/smart-split.nvim](https://github.com/mrjones2014/smart-splits.nvim) - Smart, seamless, directional navigation and resizing of Neovim + terminal multiplexer splits. Supports tmux, Wezterm, and Kitty. Think about splits in terms of "up/down/left/right".

## Custom

## TODO

- Fix notifications so they are above lazy popup
- Fix gotempl lsp (gotmpl + html)
- have lsp display in completion and statusbar :o
- Completion
    - fix luasnip node shit
- Zk
    - Have dir passed into dir-title input
- Plugins
    - AI
        - [zbirenbaum/copilot.lua](https://github.com/zbirenbaum/copilot.lua) - Fully featured & enhanced replacement for copilot.vim complete with API for interacting with Github Copilot 
        - [zbirenbaum/copilot-cmp](https://github.com/zbirenbaum/copilot-cmp) - Lua plugin to turn github copilot into a cmp source.
    - High Priority
        - https://github.com/pmizio/typescript-tools.nvim
        - https://github.com/lewis6991/fileline.nvim
        - https://github.com/uga-rosa/ccc.nvim
    - Nice to have
        - https://github.com/rest-nvim/rest.nvim
        - https://github.com/Bekaboo/dropbar.nvim
        - https://github.com/Bekaboo/deadcolumn.nvim
        - https://github.com/ThePrimeagen/refactoring.nvim
        - [metakirby5/codi.vim](https://github.com/metakirby5/codi.vim) - The interactive scratchpad for hackers.
        - https://github.com/folke/edgy.nvim
        - https://github.com/jcdickinson/wpm.nvim
        - https://github.com/VidocqH/data-viewer.nvim
        - https://github.com/koenverburg/peepsight.nvim
        - https://github.com/chrisgrieser/nvim-various-textobjs
    - Maybe
        - https://github.com/jpalardy/vim-slime
        - https://github.com/miversen33/netman.nvim
        - [MaximilianLloyd/tw-values.nvim](https://github.com/MaximilianLloyd/tw-values.nvim) - View all applied tailwindcss values on an element
        - https://github.com/chrisgrieser/nvim-early-retirement
        - https://github.com/Jezda1337/nvim-html-css
        - https://github.com/pwntester/octo.nvim
    - Completion
        - https://github.com/lukas-reineke/cmp-under-comparator
        - https://github.com/roobert/tailwindcss-colorizer-cmp.nvim
        - [uga-rosa/cmp-dictionary](https://github.com/uga-rosa/cmp-dictionary) - nvim-cmp source for dictionary
        - [jcha0713/cmp-tw2css](https://github.com/jcha0713/cmp-tw2css) - A source for nvim-cmp to convert tailwindcss classes to pure css codes
        - [David-Kunz/cmp-npm](https://github.com/David-Kunz/cmp-npm) - An additional source for nvim-cmp to autocomplete packages and its versions
        - https://github.com/JMarkin/cmp-diag-codes
        - https://github.com/paopaol/cmp-doxygen
        - https://github.com/Gelio/cmp-natdat/
    - Smellescope
        - https://github.com/benfowler/telescope-luasnip.nvim
        - https://github.com/nvim-telescope/telescope-media-files.nvim
        - https://github.com/dimaportenko/telescope-simulators.nvim
        - https://github.com/axkirillov/easypick.nvim
        - https://github.com/luckasRanarison/nvim-devdocs
    - Lsp
        - https://github.com/barreiroleo/ltex_extra.nvim
        - https://github.com/fmbarina/pick-lsp-formatter.nvim
        - https://github.com/hinell/lsp-timeout.nvim
        - https://github.com/lvimuser/lsp-inlayhints.nvim
        - https://github.com/nvimtools/none-ls.nvim
        - https://github.com/aznhe21/actions-preview.nvim
    - DAP
        - https://github.com/mfussenegger/nvim-dap
        - https://github.com/ofirgall/goto-breakpoints.nvim
        - https://github.com/rcarriga/nvim-dap-ui
        - https://github.com/Weissle/persistent-breakpoints.nvim
        - https://github.com/LiadOz/nvim-dap-repl-highlights
        - https://github.com/nvim-telescope/telescope-dap.nvim
    - Testing
        - https://github.com/Vigemus/iron.nvim
        - https://github.com/nvim-neotest/neotest
        - https://github.com/andythigpen/nvim-coverage
        - https://github.com/t-troebst/perfanno.nvim
    - Lua
        - https://github.com/milisims/nvim-luaref
    - Markdown
        - https://github.com/3rd/image.nvim
        - https://github.com/jbyuki/nabla.nvim
        - https://github.com/jmbuhr/otter.nvim
        - https://github.com/dkarter/bullets.vim
        - https://github.com/jbyuki/venn.nvim
    - Rust
        - https://github.com/Saecki/crates.nvim
    - Colorscheme
        - https://github.com/martineausimon/nvim-xresources
    - https://www.reddit.com/r/neovim/comments/14yjftv/massive_update_to_neogit_and_new_home/
    - https://www.reddit.com/r/neovim/comments/10cigze/minimove_move_any_selection_in_any_direction/
    - https://www.reddit.com/r/neovim/comments/14k7pbc/what_is_the_nvimcmp_comparatorsorting_you_are/
    - https://www.reddit.com/r/neovim/comments/170ykc0/tailwind_lsp_hover_documentation_multiple_lsps/
- override netrw.
- LSP
    - Toggle underlines
    - Toggle autoformat
    - Java
        - Add runtime select
- Treesitter
    - keymaps
    - https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    - https://github.com/RRethy/nvim-treesitter-textsubjects

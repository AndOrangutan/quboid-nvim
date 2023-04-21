local masonlsp = require('mason-lspconfig')

masonlsp.setup({
    ensure_installed = { 
        "awk_ls",                   -- Awk
        "angularls",                -- Angular
        "arduino_language_server",  -- Aruino
        --"asm_lsp",                  -- GAS/NASM and GO Assembly
        "bashls",                   -- Bash
        "clangd",                   -- C, C++
        "omnisharp",                -- C#
        "cmake",                    -- CMake
        "cssls",                    -- CSS
        "clojure_lsp",              -- Clojure
        "dockerls",                 -- Docker
        "emmet_ls",                 -- Emmet: The essential toolkit for web-developers 
        "fortls",                   -- Fortran
        "gopls",                    -- Go
        "html",                     -- HTML
        "eslint",                   -- Javascript
        --"hls",                      -- Haskell
        "jsonls",                   -- JSON
        "jdtls",                    -- JAVA
        "tsserver",                 -- Javascript, Typescript
        "kotlin_language_server",   -- Kotlin
        -- "ltex",
        --"texlab",                   -- LaTeX
        "lua_ls",              -- Lua
        "rnix",                     -- Nix
        "intelephense",             -- PHP
        "pyright",                  -- Python
        --"solargraph",               -- Ruby
        --"Rust",                     -- Rust
        "sqlls",                     -- SQL
        --"Svelte",                   -- Svelte
        "taplo",                    -- TOML
        "tailwindcss",              -- Tailwind CSS
        "vimls",                    -- VimL
        "vuels",                    -- Vue
        "lemminx",                  -- XML
        "yamlls",                   -- YAML
        "zls",                      -- Zig
    }
})

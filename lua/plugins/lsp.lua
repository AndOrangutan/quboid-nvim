return {
        { 'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            { url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
                config = function() require('lsp_lines').setup() end,
            },
        },
        config = function ()
            local quboid = require('quboid')
            local lspconfig = require('lspconfig')
            local masonlsp = require('mason-lspconfig')
            local lsp_util = require('lsp.util')

            -- Customize diagnostics also influences lsp_lines
            vim.diagnostic.config({
                virtual_text = false,
                update_in_insert = false,
                virtual_lines = { only_current_line = true },
                -- signs = true,
                underline = true,
                -- update_in_insert = false,
                severity_sort = true,
                float = {
                    source = "if_many",
                },
            })

            -- Overide border globally
            local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
            function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
                opts = opts or {}
                opts.border = opts.border or quboid.border
                return orig_util_open_floating_preview(contents, syntax, opts, ...)
            end

            -- Customize the sign columns
            local signs = {
                Error = quboid.icons.circle_error,
                Warn = quboid.icons.circle_warn,
                Hint = quboid.icons.circle_hint,
                Info = quboid.icons.circle_info,
            }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            masonlsp.setup_handlers({
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                -- default handler (optional)

                function(server_name)
                    require("lspconfig")[server_name].setup(lsp_util.gen_config())
                end,
                -- Next, you canprovide targeted overrides for specific servers.
                ["jdtls"] = function()
                end,
                -- ["tsserver"] = function()
                -- end,
                ["eslint"] = function()
                    local config = lsp_util.gen_config()

                    config.settings = {
                        packageManager = quboid.ft_javascript_package_manager,
                    },

                    lspconfig.eslint.setup(config)
                end,
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        on_attach = function (client, bufnr) lsp_util.call_on_attach(client, bufnr) end,
                        capabilities = lsp_util.gen_capabilities(),
                        settings = {
                            Lua = {
                                runtime = {
                                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                                    version = 'LuaJIT',
                                },
                                completion = {
                                    callSnippet = "Replace"
                                },
                                diagnostics = {
                                    globals = { "awesome", "vim" }
                                },
                                workspace = {
                                    checkThirdParty = false,
                                    library = {
                                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                                        ["/usr/share/awesome/lib"] = true,
                                        -- require("neodev.config").types(),
                                    },
                                },
                                telemetry = {
                                    enable = false,
                                },
                            },
                        }
                    } )
                end,
            })


        end,
        keys = {
            { '<leader>e', '<cmd>lua vim.diagnostic.open_float({}, {focus=false})<CR>', '[e]xamine Diagnostics (2x to enter)' },
            { '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', 'Prev [d]iagnostic'},
            { ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', 'Next [d]iagnostic'},
        },
        event = 'VeryLazy',
    },

    { 'williamboman/mason-lspconfig.nvim',
        opts = {
            automatic_installation = true,
            ensure_installed = { 
                -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
                'awk_ls',
                'angularls',
                -- 'arduino_language_server',
                'bashls',
                'clangd',
                'omnisharp',
                'cmake',
                'cssls',
                -- 'clojure_lsp',
                'dockerls',
                'emmet_language_server',
                'eslint',
                'fortls',
                'gopls',
                'gradle_ls',
                'graphql',
                'html',
                'jsonls',
                'jdtls',
                'tsserver',
                'kotlin_language_server',
                'lua_ls',
                'rnix',
                'intelephense',
                'pyright',
                'sqlls',
                'svelte',
                'taplo',
                'tailwindcss',
                'vimls',
                'vuels',
                'lemminx',
                'yamlls',
                'zls',
            }
        },
    },
}

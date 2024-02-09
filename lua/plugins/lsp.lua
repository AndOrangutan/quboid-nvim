return {
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'williamboman/mason.nvim'
        },
        event = 'VeryLazy',
        opts = {
            automatic_installation = true,
            ensure_installed = require('quboid').lsp_ensure_installed,
        },
    },
    {
        'neovim/nvim-lspconfig',
        depdencies = {
            'williamboman/mason.nvim',
        },
        event = 'VeryLazy',
        config = function()
            -- lsp utils and settings
            local lsp = require('quboid.lsp')

            local lspconfig = require('lspconfig')
            local masonlsp = require('mason-lspconfig')

            masonlsp.setup_handlers({

                function(server_name)
                    require('lspconfig')[server_name].setup(lsp.gen_config())
                end,

                -- Disable
                ['jdtls'] = function() end,
                ['zk'] = function() end,
                ['tsserver'] = function() end,
                ['eslint'] = function() end,

                -- -- Next, you canprovide targeted overrides for specific servers.
                -- ['gopls'] = function()
                --     local install_root_dir = vim.fn.stdpath('data') .. '/lsp_servers'
                --     local config = require('lsp').gen_config()
                --
                --     local ext_config = {
                --         gopls_cmd = { install_root_dir .. '/go/gopls' },
                --         fillstruct = 'gopls',
                --         dap_debug = true,
                --         dap_debug_gui = true,
                --         filetypes = quboid.ft_go,
                --         settings = {
                --             gopls = {
                --                 ['build.templateExtensions'] = { 'gohtml', 'html', 'gotmpl', 'tmpl' },
                --             }
                --         }
                --     }
                --     config = vim.tbl_extend('keep', ext_config or {}, config)
                --     require('lspconfig').gopls.setup(config)
                -- end,
                -- ['tailwindcss'] = function()
                --     local config = require('lsp').gen_config()
                --     config.root_dir = function(fname)
                --         local root_pattern = require('lspconfig').util.root_pattern(
                --             'tailwind.config.cjs',
                --             'tailwind.config.js',
                --             'postcss.config.js'
                --         )
                --         return root_pattern(fname)
                --     end
                --     lspconfig.tailwindcss.setup(config)
                -- end,
                -- ['clangd'] = function()
                --     require('lspconfig').clangd.setup {
                --         on_attach = require('lsp').gen_on_attach(),
                --         capabilities = require('lsp').gen_capabilities(),
                --         cmd = {
                --             'clangd',
                --             '--offset-encoding=utf-16',
                --         },
                --         root_pattern = {
                --             '.clangd',
                --             '.clang-tidy',
                --             '.clang-format',
                --             'compile_commands.json',
                --             'compile_flags.txt',
                --             'configure.ac',
                --             '.git'
                --         },
                --     }
                -- end,
                ['lua_ls'] = function()
                    lspconfig.lua_ls.setup({
                        capabilities = require('quboid.lsp').gen_capabilities(),
                        settings = {
                            Lua = {
                                runtime = {
                                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                                    version = 'LuaJIT',
                                },
                                completion = {
                                    callSnippet = 'Replace',
                                },
                                diagnostics = {
                                    globals = { 'awesome', 'vim' },
                                },
                                workspace = {
                                    checkThirdParty = false,
                                    library = {
                                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                                        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                                        ['/usr/share/awesome/lib'] = true,
                                    },
                                },
                                telemetry = {
                                    enable = false,
                                },
                            },
                        },
                    })
                end,
            })
        end,
        keys = {
            {
                '<leader>e',
                '<cmd>lua vim.diagnostic.open_float({}, {focus=false})<CR>',
                desc = '[e]xamine Diagnostics (2x to enter)',
            },
            { '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', desc = 'Prev [d]iagnostic' },
            { ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', desc = 'Next [d]iagnostic' },
            {
                '<leader>q',
                '<cmd> lua vim.diagnostic.setloclist()<cr',
                desc = 'Add [d]iagnostics to Loclist'
            }
        },
    }
}

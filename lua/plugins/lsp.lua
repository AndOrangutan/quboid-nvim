return {
    {
        'neovim/nvim-lspconfig',
        depdencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
        -- event = 'VeryLazy',
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
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'williamboman/mason.nvim',
        },
        -- event = 'VeryLazy',
        opts = {
            automatic_installation = false,
            ensure_installed = require('quboid').lsp_ensure_installed,
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup(require('quboid.lsp').gen_config())
                end,
                -- Disable
                ['zk'] = function() end,
                ['tsserver'] = function() end,
                ['eslint'] = function() end,

                ['clangd'] = function()
                    require('lspconfig').clangd.setup {
                        capabilities = require('quboid.lsp').gen_capabilities(),
                        cmd = {
                            'clangd',
                            '--offset-encoding=utf-16',
                        },
                        root_pattern = {
                            '.clangd',
                            '.clang-tidy',
                            '.clang-format',
                            'compile_commands.json',
                            'compile_flags.txt',
                            'configure.ac',
                            '.git'
                        },
                    }
                end,
                ["jdtls"] = function ()
                    -- print(require('java').setup())
                    print("test shit")
                    require('lspconfig').jdtls.setup({
                        capabilities = require('quboid.lsp').gen_capabilities(),
                    })
                end,
                ['lua_ls'] = function()
                    require('lspconfig').lua_ls.setup({
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
                end,
            }
        },
    },

    {
        'nvimtools/none-ls.nvim',
        dependencies = {
            {
                'jay-babu/mason-null-ls.nvim',
                config = function()
                    require('mason-null-ls').setup({
                        ensure_installed = require('quboid').none_ls_ensure_installed,
                    })
                end,
            },
        },
        config = function()
            local null_ls = require('null-ls')

            local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

            null_ls.setup({
                sources = {

                    ------------------
                    -- Code Actions --
                    ------------------
                    -- Buitlin
                    null_ls.builtins.code_actions.gitrebase,
                    null_ls.builtins.code_actions.gitsigns,
                    -- Installed
                    null_ls.builtins.code_actions.eslint,
                    null_ls.builtins.code_actions.shellcheck,
                    null_ls.builtins.code_actions.ts_node_action,

                    ----------------
                    -- Completion --
                    ----------------
                    --- Builtin
                    null_ls.builtins.completion.spell,
                    null_ls.builtins.completion.tags,

                    -----------------
                    -- Diagnostics --
                    -----------------
                    --- Installed
                    null_ls.builtins.diagnostics.actionlint,
                    null_ls.builtins.diagnostics.checkstyle.with({
                        extra_args = { '-c', '/google_checks.xml' }, -- or "/sun_checks.xml" or path to self written rules
                    }),
                    null_ls.builtins.diagnostics.cmake_lint,
                    null_ls.builtins.diagnostics.cppcheck,
                    null_ls.builtins.diagnostics.gdlint,
                    null_ls.builtins.diagnostics.eslint,
                    null_ls.builtins.diagnostics.php,
                    null_ls.builtins.diagnostics.ruff,
                    null_ls.builtins.diagnostics.shellcheck,

                    ----------------
                    -- Formatting --
                    ----------------
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.cbfmt,
                    null_ls.builtins.formatting.clang_format.with({
                        filetypes = {
                            'c', 'cpp', 'cs', 'cuda', 'proto'
                        },
                    }),
                    null_ls.builtins.formatting.cmake_format,
                    null_ls.builtins.formatting.gdformat,
                    null_ls.builtins.formatting.jq,
                    null_ls.builtins.formatting.prettierd,
                    null_ls.builtins.formatting.ruff,

                    -----------
                    -- Hover --
                    -----------
                    -- Builtin
                    null_ls.builtins.hover.dictionary,
                },
                on_attach = function(client, bufnr)
                    if client.supports_method('textDocument/formatting') then
                        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                                -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                                vim.lsp.buf.format({ async = false })
                            end,
                        })
                    end
                end,
            })
        end,
    },

    {
        'ray-x/lsp_signature.nvim',
        opts = {
            hint_prefix = '',
            hi_parameter = 'String',
            floating_window_above_cur_line = true,
            handler_opts = {
                border = require('quboid').border,
            },
        },
        event = 'VeryLazy',
    },
        config = function(_, opts)
            require('lsp_signature').setup(opts)
        end,
    {
        'RRethy/vim-illuminate',
        event = 'BufRead',
        config = function()
            require('illuminate').configure()
        end,
    },
    {
        'dnlhc/glance.nvim',
        config = function()
            local glance = require('glance')
            local actions = glance.actions

            require('glance').setup({
                mappings = {
                    list = {
                        ['j'] = actions.next,     -- Bring the cursor to the next item in the list
                        ['k'] = actions.previous, -- Bring the cursor to the previous item in the list
                        ['<Down>'] = actions.next,
                        ['<Up>'] = actions.previous,
                        ['<Tab>'] = actions.next_location,       -- Bring the cursor to the next location skipping groups in the list
                        ['<S-Tab>'] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
                        ['<C-u>'] = actions.preview_scroll_win(5),
                        ['<C-d>'] = actions.preview_scroll_win(-5),
                        ['<C-v>'] = actions.jump_vsplit,
                        ['<C-s>'] = actions.jump_split,
                        ['t'] = actions.jump_tab,
                        ['<CR>'] = actions.jump,
                        ['o'] = actions.jump,
                        ['l'] = actions.open_fold,
                        ['h'] = actions.close_fold,
                        ['<leader>l'] = actions.enter_win('preview'), -- Focus preview window
                        ['q'] = actions.close,
                        ['Q'] = actions.close,
                        ['<Esc>'] = actions.close,
                        ['<C-q>'] = actions.quickfix,
                        -- ['<Esc>'] = false -- disable a mapping
                    },
                    preview = {
                        ['Q'] = actions.close,
                        ['<Tab>'] = actions.next_location,
                        ['<S-Tab>'] = actions.previous_location,
                        ['<leader>l'] = actions.enter_win('list'), -- Focus list window
                    },
                },
                hooks = {
                    before_open = function(results, open, jump, method)
                        local uri = vim.uri_from_bufnr(0)
                        if #results == 1 then
                            local target_uri = results[1].uri or results[1].targetUri

                            if target_uri == uri then
                                jump(results[1])
                            else
                                open(results)
                            end
                        else
                            open(results)
                        end
                    end,
                },
            })
        end,
    },
}

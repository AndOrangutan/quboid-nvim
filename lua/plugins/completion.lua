return {
    {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        dependencies = {
            'rafamadriz/friendly-snippets',
            {
                'dsznajder/vscode-es7-javascript-react-snippets',
                build = 'yarn install --frozen-lockfile && yarn compile',
            },
        },
        build = 'make install_jsregexp',
        event = 'InsertEnter',
        config = function()
            local ls = require('luasnip')

            ls.config.set_config {
                history = true,
                delete_check_events = 'InsertEnter',
            }

            require('quboid.snippets').choice_node_popup()

            require('luasnip.loaders.from_vscode').lazy_load()
            require('luasnip.loaders.from_snipmate').lazy_load()
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippets
            'saadparwaiz1/cmp_luasnip',
            {
                'doxnit/cmp-luasnip-choice',
                opts = { auto_open = true },
            },

            -- General "on marker", only pop up when desired
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-cmdline',
            'kdheepak/cmp-latex-symbols',
            { 'roobert/tailwindcss-colorizer-cmp.nvim', config = true },
            { 'Gelio/cmp-natdat',                       config = true },

            -- LSP
            'hrsh7th/cmp-nvim-lsp',

            -- Genreral spammy
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-buffer',
            {
                'uga-rosa/cmp-dictionary',
                config = function()
                    local dict = require('cmp_dictionary')
                    dict.setup({
                        paths = { '/usr/share/dict/words' },
                        document = {
                            enable = true,
                            command = { 'wn', '${label}', '-over' },
                        },
                    })
                end,
            },

            -- -- Git
            'petertriho/cmp-git',
        },
        event = 'InsertEnter',
        config = function()
            local quboid = require('quboid')
            local icons = require('quboid.icons')
            local ft = require('quboid.ft')

            local cmp = require('cmp')
            local _, luasnip = pcall(require, 'luasnip')

            vim.opt.pumheight = 32

            local completion_names = {
                buffer                    = 'Buffer',
                calc                      = 'Math',
                luasnip                   = 'Snippet',
                luasnip_choice            = 'Choice',
                -- nvim_lsp                  = 'LSP', -- Overidden with lsp name
                nvim_lua                  = 'NvimApi',
                path                      = 'Path',
                latex_symbols             = 'LaTeX',
                dictionary                = 'Dict',
                copilot                   = 'Copilot',
                natdat                    = 'NatDate',
                ['vim-dadbod-completion'] = 'DadBod',
            }

            cmp.setup({
                snippet = {
                    expand = function(args) luasnip.lsp_expand(args.body) end,
                },
                window = {
                    documentation = {
                        winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
                        border = quboid.border_float,
                    },
                    completion = {
                        border = quboid.border,
                        -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                        col_offset = -3,
                        side_padding = 0,
                    },
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                    ['<TAB>'] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-TAB>'] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                formatting = {
                    fields = { 'kind', 'abbr', 'menu' },

                    --with_text = true,
                    format = function(entry, item)
                        local cmp_item = entry:get_completion_item() -- @type lsp.CompletionItem

                        if entry.source.name == 'nvim_lsp' then
                            local lspserver_name = nil
                            pcall(function()
                                lspserver_name = entry.source.source.client.name
                                item.menu = lspserver_name
                            end)
                        else
                            item.menu = completion_names[entry.source.name]
                        end
                        item.kind = icons.lsp_kind[item.kind] -- Use built in icons

                        return require('tailwindcss-colorizer-cmp').formatter(entry, item)
                    end,
                },
                sorting = {
                    --         --     priority_weight = 2,
                    comparators = {
                        -- https://github.com/tjdevries/config_manager/blob/83b6897e83525efdfdc24001453137c40373aa00/xdg_config/nvim/after/plugin/completion.lua#L129-L155
                        -- require('copilot_cmp.comparators').prioritize,
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        cmp.config.compare.recently_used,

                        -- copied from cmp-under, but I don't think I need the plugin for this.
                        -- I might add some more of my own.
                        function(entry1, entry2)
                            local _, entry1_under = entry1.completion_item.label:find '^_+'
                            local _, entry2_under = entry2.completion_item.label:find '^_+'
                            entry1_under = entry1_under or 0
                            entry2_under = entry2_under or 0
                            if entry1_under > entry2_under then
                                return false
                            elseif entry1_under < entry2_under then
                                return true
                            end
                        end,

                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
                sources = cmp.config.sources({
                    { name = 'luasnip_choice' },
                    { name = 'calc' },
                    { name = 'latex_symbols' },
                    { name = 'natdat' },

                    { name = 'nvim_lua' },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'path' },
                    {
                        name = 'buffer',
                        max_item_count = 3,
                        option = {
                            get_bufnrs = function() return vim.api.nvim_list_bufs() end }
                    },
                }),
            })

            -- require('cmp_git').setup({ filetypes = ft.git })

            -- Set configuration for specific filetype.
            cmp.setup.filetype(ft.git, {
                sources = cmp.config.sources({
                    { name = 'luasnip_choice' },
                    { name = 'calc' },
                    { name = 'natdat' },

                    { name = 'git' },
                    { name = 'luasnip' },
                    { name = 'dictionary',    keyword_length = 2 },
                }, {
                    { name = 'path' },
                    {
                        name = 'buffer',
                        max_item_count = 3,
                        option = {
                            get_bufnrs = function() return vim.api.nvim_list_bufs() end }
                    },
                })
            })

            cmp.setup.filetype(ft.markup, {
                sources = cmp.config.sources({
                    { name = 'luasnip_choice' },
                    { name = 'calc' },
                    { name = 'latex_symbols' },
                    { name = 'natdat' },

                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'dictionary',    keyword_length = 2 },
                }, {
                    { name = 'path' },
                    {
                        name = 'buffer',
                        max_item_count = 3,
                        option = {
                            get_bufnrs = function() return vim.api.nvim_list_bufs() end }
                    },
                })
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    -- { name = 'nvim_lsp_document_symbol' },
                    {
                        name = 'buffer',
                        max_item_count = 3,
                        option = {
                            get_bufnrs = function() return vim.api.nvim_list_bufs() end }
                    },
                })
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end,
    }
}

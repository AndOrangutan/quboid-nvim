local quboid = require('quboid')
return {

    { 'L3MON4D3/LuaSnip',
        dependencies = {
            'rafamadriz/friendly-snippets',
            { 'dsznajder/vscode-es7-javascript-react-snippets',
                build = 'yarn install --frozen-lockfile && yarn compile',
            },
        },
        build = 'make install_sregexp',
        config =  function ()
            local luasnip = require('luasnip')

            luasnip.config.set_config {
                history = true,
                delete_check_events = 'InsertEnter',

            }
            require('luasnip.loaders.from_vscode').lazy_load()
            require('luasnip.loaders.from_snipmate').lazy_load()
        end,
        event = 'InsertEnter'
    },
    { 'hrsh7th/nvim-cmp',
        dependencies = {
            'windwp/nvim-autopairs',

            { 'petertriho/cmp-git',
                opts = { fyletypes = quboid.ft_git },
            },
            'saadparwaiz1/cmp_luasnip',
            { 'doxnit/cmp-luasnip-choice',
                opts = { auto_open = true },
            },
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-buffer',
        },
        opts = {
        },
        config = function ()
            local cmp = require('cmp')
            local quboid = require('quboid')
            local luasnip_ok, luasnip = pcall(require, 'luasnip')
            if not luasnip_ok then vim.notify('Failed due to luasnip not being present!', 'Error') return end
            local cmp_autopairs_ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
            if cmp_autopairs_ok then cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done()) end


            local sources = {
                { name = 'luasnip', priority = 10, max_item_count = 8 },
                { name = 'luasnip_choice', priority = 10, max_item_count = 8 },
                { name = 'path', priority = 10 },
                { name = 'calc', priority = 10},

                { name = 'nvim_lsp', priority = 9 },
                { name = 'buffer', max_item_count = 3 },
            }
            local sorces_markup = {
                { name = 'luasnip', priority = 10, max_item_count = 8 },
                { name = 'luasnip_choice', priority = 10, max_item_count = 8 },
                { name = 'calc', priority = 10},
                { name = 'nvim_lsp', priority = 9 },
                { name = 'buffer', max_item_count = 3 },
            }

            local sources_git = {
                { name = 'luasnip', priority = 10, max_item_count = 8 },
                { name = 'luasnip_choice', priority = 10, max_item_count = 8 },
                { name = 'path', priority = 10 },

                { name = 'nvim_lsp', priority = 9 },
                { name = 'buffer', max_item_count = 3 },
            }

            local completion_names = {
                buffer                  = 'Buffer',
                calc                    = 'Math',
                luasnip                 = 'Snippet',
                luasnip_choice          = 'Choice',
                nvim_lsp                = 'LSP',
                path                    = 'Path',
            }

            cmp.setup({
                experimental = {
                    ghost_text = { hl_group = 'cmpghosttext' },
                },

                completion = {
                    completeopt = 'menu,menuone,noinsert',
                },
                snippet = {
                    expand = function (args) luasnip.lsp_expand(args.body) end,
                },
                window = {
                    documentation = { border = quboid.border_float },
                    completion = { border = quboid.border },
                },
                formatting = {
                    fields = { 'kind', 'abbr', 'menu'},

                    --with_text = true,

                    format = function (entry, vim_item)
                        local cmp_item = entry:get_completion_item() -- @type l
                        if entry.source.name == 'nvim_lsp' then
                            local lspserver_name = nil
                            pcall(function()
                                lspserver_name = entry.source.source.client.name
                                vim_item.name = lspserver_name
                            end)
                        end
                        vim_item.menu = completion_names[entry.source.name]
                        vim_item.kind = quboid.lsp_kind[vim_item.kind]   -- Use built in icons
                        return vim_item
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<TAB>'] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-TAB>'] = cmp.mapping(function (fallback)
                        if luasnip.expand_or_locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ['<S-CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sorting = {
                                --         --     priority_weight = 2,
                    comparators = {
                        -- https://github.com/tjdevries/config_manager/blob/83b6897e83525efdfdc24001453137c40373aa00/xdg_config/nvim/after/plugin/completion.lua#L129-L155
                        -- require("copilot_cmp.comparators").prioritize,
                        -- require("copilot_cmp.comparators").score,
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,

                        -- copied from cmp-under, but I don't think I need the plugin for this.
                        -- I might add some more of my own.
                        function(entry1, entry2)
                            local _, entry1_under = entry1.completion_item.label:find "^_+"
                            local _, entry2_under = entry2.completion_item.label:find "^_+"
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
                sources = cmp.config.sources(sources),
            })

            -- cmp.setup({
            --     snippet = {
            --     },
            --     window = {
            --
            --     },
            --     mapping = cmp.mapping.preset.insert({
            --         ['<TAB>'] = cmp.mapping(function(fallback)
            --             if luasnip.expand_or_locally_jumpable() then
            --                 luasnip.expand_or_jump()
            --             else
            --                 fallback()
            --             end
            --         end, { 'i', 's' }),
            --         ['<S-TAB>'] = cmp.mapping(function (fallback)
            --             if luasnip.expand_or_locally_jumpable(-1) then
            --                 luasnip.jump(-1)
            --             else
            --                 fallback()
            --             end
            --         end, { 'i', 's' }),
            --         ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            --         ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            --         ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            --         ['<C-f>'] = cmp.mapping.scroll_docs(4),
            --         ['<C-Space>'] = cmp.mapping.complete(),
            --         ['<C-e>'] = cmp.mapping.abort(),
            --         ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            --         ['<S-CR>'] = cmp.mapping.confirm({
            --             behavior = cmp.ConfirmBehavior.Replace,
            --             select = true,
            --         }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            --     }),
            --     formating = {
            --         fields = { 'kind', 'abbr', 'menu'},
            --
            --         format = function (entry, vim_item)
            --             local cmp_item = entry:get_completion_item() -- @type l
            --             if entry.source.name == 'nvim_lsp' then
            --                 local lspserver_name = nil
            --                 pcall(function()
            --                     lspserver_name = entry.source.source.client.name
            --                     vim_item.name = lspserver_name
            --                 end)
            --             end
            --             vim_item.menu = completion_names[entry.source.name]
            --             vim_item.kind = quboid.lsp_kind[vim_item.kind]   -- Use built in icons
            --             print(vim.inspect(vim_item))
            --             return vim_item
            --         end,
            --     },
            --     sorting = {
            --         --     priority_weight = 2,
            --         comparators = {
            --             -- https://github.com/tjdevries/config_manager/blob/83b6897e83525efdfdc24001453137c40373aa00/xdg_config/nvim/after/plugin/completion.lua#L129-L155
            --             -- require("copilot_cmp.comparators").prioritize,
            --             -- require("copilot_cmp.comparators").score,
            --             cmp.config.compare.offset,
            --             cmp.config.compare.exact,
            --             cmp.config.compare.score,
            --
            --             -- copied from cmp-under, but I don't think I need the plugin for this.
            --             -- I might add some more of my own.
            --             function(entry1, entry2)
            --                 local _, entry1_under = entry1.completion_item.label:find "^_+"
            --                 local _, entry2_under = entry2.completion_item.label:find "^_+"
            --                 entry1_under = entry1_under or 0
            --                 entry2_under = entry2_under or 0
            --                 if entry1_under > entry2_under then
            --                     return false
            --                 elseif entry1_under < entry2_under then
            --                     return true
            --                 end
            --             end,
            --
            --             cmp.config.compare.kind,
            --             cmp.config.compare.sort_text,
            --             cmp.config.compare.length,
            --             cmp.config.compare.order,
            --         },
            --     },
            --     sources = cmp.config.sources(sources),
            -- })

            cmp.setup.filetype(quboid.ft_git, {
                sources = cmp.config.sources({
                    { name = 'git' }, -- You can specify the `cmp_git` source if you were installed it.
                }, {
                        { name = 'buffer' },
                    })
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp_document_symbol' }
                }, {
                        { name = 'buffer' }
                    })
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' , option = { trailing_slash = true }}
                }, {
                        { name = 'cmdline' }
                    })
            })

            cmp.setup.filetype(quboid.ft_markup, {
                sources = cmp.config.sources({
                    { name = 'luasnip', priority = 10, max_item_count = 8 },
                    { name = 'path', priority = 10 },

                    { name = 'nvim_lsp', priority = 9 },
                    { name = 'buffer', max_item_count = 3 },
                }, {
                        { name = 'buffer' },
                    })
            })


            require("cmp_git").setup()

        end,
        event = 'InsertEnter',
    }
}

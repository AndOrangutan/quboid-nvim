---@diagnostic disable: missing-fields

return {

    { 'L3MON4D3/LuaSnip',
        version = 'v2.*',
        dependencies = {
            'rafamadriz/friendly-snippets',
            { 'dsznajder/vscode-es7-javascript-react-snippets',
                build = 'yarn install --frozen-lockfile && yarn compile',
            },
        },
        build = 'make install_jsregexp',
        config =  function ()
            local ls = require('luasnip')

            ls.config.set_config {
                history = true,
                delete_check_events = 'InsertEnter',

            }

            require('snippets').choice_node_popup()
            require('luasnip.loaders.from_vscode').lazy_load()
            require('luasnip.loaders.from_snipmate').lazy_load()
        end,
        event = 'InsertEnter'
    },
    { 'hrsh7th/nvim-cmp',
        dependencies = {
            'windwp/nvim-autopairs',

            'saadparwaiz1/cmp_luasnip',
            { 'doxnit/cmp-luasnip-choice',
                opts = { auto_open = true },
            },

            'hrsh7th/cmp-path',
            'hrsh7th/cmp-calc',

            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',

            { 'petertriho/cmp-git',
                opts = { fyletypes = require('quboid').ft_git },
            },
            'kdheepak/cmp-latex-symbols',
            'hrsh7th/cmp-omni',
            'kristijanhusak/vim-dadbod-completion',

            { 'uga-rosa/cmp-dictionary',
                config = function ()
                    local dict = require('cmp_dictionary')
                    dict.setup({ document = true, })
                    dict.switcher({
                        spelllang = {
                            en = "/usr/share/dict/words",
                        },
                    })
                end,
            },
            { 'zbirenbaum/copilot-cmp',
                dependencies = 'zbirenbaum/copilot.lua',
                config = function ()
                    require("copilot_cmp").setup()

                    vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})
                end
            },
            { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
            { "paopaol/cmp-doxygen",
                dependencies = { "nvim-treesitter/nvim-treesitter",
                    "nvim-treesitter/nvim-treesitter-textobjects"
                } 
            },
            { "Gelio/cmp-natdat", config = true },
        },
        opts = {
        },
        config = function ()
            local quboid = require('quboid')  -- lol
            local cmp = require('cmp')
            local _, luasnip = pcall(require, 'luasnip')
            -- local _, _ = pcall(require, 'nvim-autopairs.completion.cmp')

            vim.opt.pumheight = 32


            local sources = {
                { name = "copilot", group_index = 2, priority = 10 },
                { name = 'luasnip', priority = 10, max_item_count = 8 },
                { name = 'luasnip_choice', priority = 10, max_item_count = 8 },
                { name = 'path', priority = 10 },
                { name = 'calc', priority = 10},
                { name = 'doxygen', priority = 10},
                { name = 'natdat', priority = 10},

                { name = 'nvim_lsp', priority = 9 },
                { name = 'vim-dadbod-completion', priority = 9 },
                { name = 'buffer', max_item_count = 3, option = { get_bufnrs = function() return vim.api.nvim_list_bufs() end }  },
            }

            -- add dicitonary
            local sources_markup = {
                { name = 'luasnip', priority = 10, max_item_count = 8 },
                { name = 'luasnip_choice', priority = 10, max_item_count = 8 },
                { name = 'latex_symbols', priority = 10 },
                { name = 'calc', priority = 10},
                { name = 'nvim_lsp', priority = 9 },
                { name = 'buffer', max_item_count = 3, option = { get_bufnrs = function() return vim.api.nvim_list_bufs() end },},
                { name = "dictionary", keyword_length = 2, },
            }

            local sources_tex = {
                { name = 'luasnip', priority = 10, max_item_count = 8 },
                { name = 'omni', priority = 10 },
                { name = 'luasnip_choice', priority = 10, max_item_count = 8 },
                { name = 'calc', priority = 10},
                { name = 'nvim_lsp', priority = 9 },
                { name = 'latex_symbols', priority = 7 },
                { name = 'buffer', max_item_count = 3, option = { get_bufnrs = function() return vim.api.nvim_list_bufs() end } },

            }

            local sources_git = {
                { name = 'git', priority = 10 }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
                { name = 'luasnip', priority = 10, max_item_count = 8 },
                { name = 'luasnip_choice', priority = 10, max_item_count = 8 },
                { name = 'path', priority = 10 },

                { name = 'nvim_lsp', priority = 9 },
                { name = 'buffer', max_item_count = 3, option = { get_bufnrs = function() return vim.api.nvim_list_bufs() end }  },
            }

            local completion_names = {
                buffer                  = 'Buffer',
                calc                    = 'Math',
                luasnip                 = 'Snippet',
                luasnip_choice          = 'Choice',
                nvim_lsp                = 'LSP',
                path                    = 'Path',
                latex_symbols           = 'LaTeX',
                dictionary              = 'Dict',
                omni                    = 'Omni',
                copilot                 = 'Copilot',
                doxygen                 = 'Doxygen',
                natdat                  = 'NatDate',
                ['vim-dadbod-completion'] = 'DadBod',
            }

            cmp.setup({
                -- completion = {
                -- },
                --     completeopt = 'menu,menuone,noinsert',
                snippet = {
                    expand = function (args) luasnip.lsp_expand(args.body) end,
                },
                window = {
                    documentation = {
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
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
                    -- ['<CR>'] = cmp.mapping({
                    --     i = function(fallback)
                    --         if cmp.visible() and cmp.get_active_entry() then
                    --             cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                    --         else
                    --             fallback()
                    --         end
                    --     end,
                    --     s = cmp.mapping.confirm({ select = true }),
                    --     c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                    -- }),
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
                    -- ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { 'i', 'c' }),
                    -- ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { 'i', 'c' }),
                }),
                formatting = {
                    fields = { 'kind', 'abbr', 'menu'},

                    --with_text = true,

                    format = function (entry, item)
                        local cmp_item = entry:get_completion_item() -- @type l
                        if entry.source.name == 'nvim_lsp' then
                            local lspserver_name = nil
                            pcall(function()
                                lspserver_name = entry.source.source.client.name
                                item.name = lspserver_name
                            end)
                        end
                        item.menu = completion_names[entry.source.name]
                        item.kind = quboid.lsp_kind[item.kind]   -- Use built in icons
                        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
                    end,
                },
                sorting = {
                                --         --     priority_weight = 2,
                    comparators = {
                        -- https://github.com/tjdevries/config_manager/blob/83b6897e83525efdfdc24001453137c40373aa00/xdg_config/nvim/after/plugin/completion.lua#L129-L155
                        require("copilot_cmp.comparators").prioritize,
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        cmp.config.compare.recently_used,

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

            require("cmp_git").setup({ filetypes = require('quboid').ft_git })

            -- Set configuration for specific filetype.
            cmp.setup.filetype( quboid.ft_git, { name = 'buffer' })

            cmp.setup.filetype( quboid.ft_markup, {
                sources = cmp.config.sources(sources_markup)
            })

            cmp.setup.filetype( quboid.ft_tex, {
                sources = cmp.config.sources(sources_tex)
            })
            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp_document_symbol' },
                    { name = 'buffer' }
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
        event = 'VeryLazy',
    }
}

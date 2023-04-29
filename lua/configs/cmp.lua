local quboid = require('quboid')

local cmp = require('cmp')

local cmp_autopairs_ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')

local luasnip_ok, luasnip = pcall(require, 'luasnip')
if not luasnip_ok then
    return
end


-- If you want insert `(` after select function or method item
if cmp_autopairs_ok then
    cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done())
end

local menu_names = {
    path                    = "Path",
    latex_symbols           = "LaTeX",
    calc                    = "Math",

    luasnip                 = "Snippet",
    nvim_lsp                = "LSP",
    treesitter              = "Treesitter",
    tmux                    = "Tmux",
    npm                     = 'NPM',
    ['cmp-tw2css']          = 'TW->CSS',
    cmp_git                 = "Git",
    nvim_lsp_document_symbol= 'Symbols',

    buffer                  = "Buffer",
    dictionary              = 'Words',
    rg                      = 'Ripgrep',

    --pandoc_references       = "Pandoc",
    --npm                     = "NPM",
}


cmp.setup({

    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
        documentation = {
            -- border = quboid.quboid_border,
            border = quboid.border,
        },
       completion = {
            border = quboid.border,
        },

    },
    sorting = {
        priority_weight = 2,
        comparators = {
            -- Below is the default comparitor list and order for nvim-cmp
            -- cmp.config.compare.offset,
            -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
            -- cmp.config.compare.exact,
            cmp.config.compare.locality,
            cmp.config.compare.recently_used,
            cmp.config.compare.score,
            cmp.config.offset,
            cmp.config.compare.order,
            -- cmp.config.compare.kind,
            -- cmp.config.compare.sort_text,
            -- cmp.config.compare.length,
        },
    },
    formatting = {
        fields = { 'kind', 'abbr', 'menu'},

        --with_text = true,

        format = function (entry, vim_item)
            vim_item.menu = menu_names[entry.source.name]
            vim_item.kind = quboid.icons[vim_item.kind]   -- Use built in icons
            return vim_item
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<TAB>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-TAB>'] = cmp.mapping(function (fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<C-l>'] = cmp.mapping(function(fallback)
            if luasnip.choice_active() then
                luasnip.change_choice(1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        -- Default Sources
        --
        -- Syntax specific (rank independent)
        { name = 'path' },
        { name = 'latex_symbols' },
        { name = 'calc' },


        -- General ranking
        { name = 'nvim_lsp', priority = 9 },
        { name = 'luasnip', priority = 7 },
        -- { name = 'tmux' },  -- TODO: Remove cmp tmux integration
        { name = 'treesitter', priority = 5 },

        { name = 'git' },
        { name = 'npm', keyword_length = 4 },
        { name = 'cmp-tw2css', priority = 6 },


        { name = "rg", keyword_length = 2, priority = 6 },


    }, {
            { name = 'buffer', priority = 7 },
        })
})

cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
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

cmp.setup.filetype(quboid.ft_marktex, {
    sources = cmp.config.sources({
            { name = 'path' },
            { name = 'latex_symbols' },

            { name = 'nvim_lsp' },
            { name = 'luasnip' },


            { name = "dictionary", keyword_length = 1 },
            { name = "rg", keyword_length = 2 },
        }, {
            { name = 'buffer' },
        })
})


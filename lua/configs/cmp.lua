local quboid = require('quboid')
local cmp = require('cmp')

local luasnip_ok, luasnip = pcall(require, 'luasnip')
if not luasnip then
    return
end


local menu_names = {
    path                    = "Path",
    latex_symbols           = "LaTeX",
    calc                    = "Math",

    luasnip                 = "Snippets",
    nvim_lsp                = "LSP",
    tmux                    = "Tmux",

    buffer                  = "Buffer",
    cmp_git                 = "Git",

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
            border = quboid.quboid_border,
        },
       completion = {
            border = quboid.quboid_border,
        },

    },
    formatting = {
        fields = { 'kind', 'abbr', 'menu'},

        --with_text = true,

        format = function (entry, vim_item)
            vim_item.menu = menu_names[entry.source.name]
            vim_item.kind = quboid.quboid_icons[vim_item.kind]   -- Use built in icons
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
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'tmux' },

        { name = 'git' },
    }, {
            { name = 'buffer' },
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
    sources = {
        { name = 'buffer' }
    }
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



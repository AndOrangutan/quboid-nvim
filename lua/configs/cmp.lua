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

local cmp_config = {
 -- { 'name', 'Menu Name', { priority = 5 },
}

local def_sources = {
    -- Syntax specific (rank independent)
    { name = 'copilot', priority = 10 },
    { name = 'otter', priority = 10 },
    { name = 'path', priority = 10 },
    { name = 'latex_symbols', priority = 10 },
    { name = 'calc', priority = 10},
    { name = 'cmp_luasnip_choice', priority = 10, max_item_count = 5 },
    { name = 'luasnip', priority = 10, max_item_count = 5 },

    -- General ranking
    { name = 'nvim_lsp', priority = 9 },
    { name = "dictionary", keyword_length = 1 },
    { name = "rg", priority = 6, keyword_length = 2 },
    { name = 'treesitter', priority = 5 },
    { name = 'buffer', max_item_count = 3 },

    { name = 'git' },
    { name = 'npm', keyword_length = 4 },
    { name = 'cmp-tw2css', priority = 6 },
}

local menu_names = {
    copilot                 = "Copilot",
    otter                   = "LSP Pass",
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
    experimental = {
        ghost_text = true,
    },

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
    --     priority_weight = 2,
        comparators = {
            -- https://github.com/tjdevries/config_manager/blob/83b6897e83525efdfdc24001453137c40373aa00/xdg_config/nvim/after/plugin/completion.lua#L129-L155
            require("copilot_cmp.comparators").prioritize,
            require("copilot_cmp.comparators").score,
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
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
    }),
    sources = cmp.config.sources(def_sources),
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
        { name = 'otter', priority = 10 },
        { name = 'path', priority = 10 },
        { name = 'latex_symbols', priority = 10 },
        { name = 'calc', priority = 10},


        { name = 'nvim_lsp' },
        { name = 'luasnip' },


        { name = "dictionary", keyword_length = 1 },
        { name = "rg", keyword_length = 2 },
    }, {
            { name = 'buffer' },
        })
})



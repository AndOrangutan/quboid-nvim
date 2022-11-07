local wk = require('which-key')
local cmp = require('cmp')
local luasnip = require('luasnip')

local G = vim.g


vim.o.completeopt='menu,menuone,noselect'
--vim.cmd[[set completeopt=menu,menuone,noselect]]

local kind_icons = {
    Text = '  ',

    Method = '  ',
    Function = '  ',
    Constructor = '  ',
    Field = '  ',
    Variable = '  ',
    Class = '  ',
    Interface = '  ',
    Module = '  ',
    Property = '  ',
    Unit = '  ',
    Value = '  ',
    Enum = '  ',
    Keyword = '  ',
    Snippet = '  ',
    Color = '  ',
    File = '  ',
    Reference = '  ',
    Folder = '  ',
    EnumMember = '  ',
    Constant = '  ',
    Struct = '  ',
    Event = '  ',
    Operator = '  ',
    TypeParameter = '  ',
}


-- TODO: Add autopair to CMP
---- If you want insert `(` after select function or method item
--local cmp_autopairs = require('nvim-autopairs.completion.cmp')
--local cmp = require('cmp')
--cmp.event:on(
--  'confirm_done',
--  cmp_autopairs.on_confirm_done()
--)



local menu_names = {
    path                    = "Path",
    buffer                  = "Buffer",
    nvim_lsp                = "LSP",
    nvim_lua                = "Neovim API",
    luasnip                 = "Snippets",
    latex_symbols           = "Latex",

    --calc                    = "Calculate",
    --treesitter              = "Treesitter",
    --luasnip                 = "Snippets",
    --spell                   = "Spell",
    --cmp_git                 = "Git",
    --dictionary              = "Dicitonary",
    --tmux                    = "Tmux",
    --rg                      = "Ripgrep",
    --pandoc_references       = "Pandoc",
    --npm                     = "NPM",
}



cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function (args)
            luasnip.lsp_expand(args.body)
        end,
    },
    --view  = {
    --    entries = { name = 'custom', selection_order = 'nearest_cursor' },
    --},
    window = {
        documentation = {
            border = G.quboid_border,
        },
       completion = {
            border = G.quboid_border,
        },
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
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    --sorting = {
    --    coparators = {
    --        cmp.config.compare.offset,
    --        cmp.config.compare.exact,
    --        cmp.config.compare.sort_text,
    --        cmp.config.compare.score,
    --        cmp.config.compare.recently_used,
    --        cmp.config.compare.kind,
    --        cmp.config.compare.length,
    --        cmp.config.compare.order,
    --    },
    --},
    formatting = {
        fields = { 'kind', 'abbr', 'menu'},

        --with_text = true,
        format = function (entry, vim_item)
            vim_item.menu = menu_names[entry.source.name]
            vim_item.kind = G.quboid_icons[vim_item.kind]
            return vim_item
        end,
    },
    --experimental = {
    --    ghost_text = true,
    --},
    sources =cmp.config.sources({
        -- Default Sources
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'latex_symbols' },
    }, {
        { name = "buffer" },
    }),
    cmp.setup.cmdline({ '/','?'}, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
        }, {
            { name = 'buffer' },
        }),
    }),
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path', option = { trailing_slash = true } },
        }, {
            { name = 'cmdline', group_index = 0 },
        }),
    }),
})


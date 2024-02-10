return {
    {
        'echasnovski/mini.comment',
        version = false,
        config = function()
            require('mini.comment').setup({
                -- Module mappings. Use `''` (empty string) to disable one.
                mappings = {
                    -- Toggle comment (like `gcip` - comment inner paragraph) for both
                    -- Normal and Visual modes
                    comment = 'gc',

                    -- Toggle comment on current line
                    comment_line = 'gcc',

                    -- Toggle comment on visual selection
                    comment_visual = 'gc',

                    -- Define 'comment' textobject (like `dgc` - delete whole comment block)
                    -- Works also in Visual mode if mapping differs from `comment_visual`
                    textobject = 'gc',
                },
            })
        end,
    },
    { 'echasnovski/mini.ai',
        version = false,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        config = function ()
            local spec_treesitter = require('mini.ai').gen_spec.treesitter
            require('mini.ai').setup({
                custom_textobjects = {
                    f = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
                    gc = spec_treesitter({ a = '@comment.outer', i = '@comment.inner' }),
                    o = spec_treesitter({
                        a = { '@conditional.outer', '@loop.outer' },
                        i = { '@conditional.inner', '@loop.inner' },
                    }),
                    c = spec_treesitter({ a = '@class.outer', i = '@class.inner' }),
                    b = spec_treesitter({ a = '@block.outer', i = '@block.inner' }),
                }
            })
        end,
    },
    { 'echasnovski/mini.align',
        config = function () require('mini.align').setup() end,
        event = 'VeryLazy',
        version = false,
    },
}

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
    {
        'echasnovski/mini.ai',
        version = false,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        config = function()
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
    {
        'echasnovski/mini.align',
        config = function() require('mini.align').setup() end,
        event = 'VeryLazy',
        version = false,
    },
    {
        'windwp/nvim-autopairs',
        config = function()
            local quboid = require('quboid')
            local ft     = require('quboid.ft')
            local npairs = require('nvim-autopairs')
            local Rule   = require('nvim-autopairs.rule')

            npairs.setup({
                check_ts = true,
                -- ts_config = {
                --     lua = {'string'},-- it will not add a pair on that treesitter node
                --     javascript = {'template_string'},
                --     java = false,-- don't check treesitter on java
                -- },
                enable_check_bracket_line = false,
                disable_filetype = quboid.ft_exclude,
            })
            -- Add spaces between parentheses
            local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' }, { '<', '>' }, }
            npairs.add_rules {
                Rule(' ', ' ')
                    :with_pair(function(opts)
                        local pair = opts.line:sub(opts.col - 1, opts.col)
                        return vim.tbl_contains({
                            brackets[1][1] .. brackets[1][2],
                            brackets[2][1] .. brackets[2][2],
                            brackets[3][1] .. brackets[3][2],
                            brackets[4][1] .. brackets[4][2],
                        }, pair)
                    end)
            }
            for _, bracket in pairs(brackets) do
                npairs.add_rules {
                    Rule(bracket[1] .. ' ', ' ' .. bracket[2])
                        :with_pair(function() return false end)
                        :with_move(function(opts)
                            return opts.prev_char:match('.%' .. bracket[2]) ~= nil
                        end)
                        :use_key(bracket[2])
                }
            end


            -- Move past commas and semicolons
            for _, punct in pairs { ',', ';' } do
                require 'nvim-autopairs'.add_rules {
                    require 'nvim-autopairs.rule' ('', punct)
                        :with_move(function(opts) return opts.char == punct end)
                        :with_pair(function() return false end)
                        :with_del(function() return false end)
                        :with_cr(function() return false end)
                        :use_key(punct)
                }
            end


            -- Arrow function in javascript
            Rule('%(.*%)%s*%=>$', ' {  }', ft.js)
                :use_regex(true)
                :set_end_pair_length(2)
        end,
        event = 'InsertEnter',
    },
    {
        'folke/twilight.nvim',
        opts = {
            dimming = {
                alpha = 0.25, -- amount of dimming
                -- we try to get the foreground from the highlight groups or fallback color
                color = { 'Normal', '#ffffff' },
                term_bg = '#000000', -- if guibg=NONE, this will be used to calculate text color
                inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
            },
            context = 10, -- amount of lines we will try to show around the current line
            treesitter = true, -- use treesitter when available for the filetype
            -- treesitter is used to automatically expand the visible text,
            -- but you can further control the types of nodes that should always be fully expanded
            expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
                'function',
                'method',
                'table',
                'if_statement',
            },
            exclude = require('quboid.ft').ft_exclude, -- exclude these filetypes
        }
    },
}

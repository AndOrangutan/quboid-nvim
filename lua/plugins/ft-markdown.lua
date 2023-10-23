return {

    { 'postfen/clipboard-image.nvim',
        config = true,
        opts = {
            default = {
                img_dir = { '%:p:h' },
                img_dir_txt = '',
                img_name = function ()
                    return vim.fn.expand('%:t:r')..'-'..os.date('%Y-%m-%d-%H-%M-%S')
                end,
                img_handler = function (img)
                    -- Add in alt text
                    vim.cmd('normal! f[') -- go vo [
                    vim.cmd('normal! a' .. vim.fn.input('Alt-text: ')) -- append text with image name

                    -- Compress image
                    --local script = string.format('~/.scripts/tinypng.sh -s f %s &', img.path)
                    --return os.execute(script)
                end,
                affix = '![](%s)',
            },
        },
        keys = {
            { '<leader>p', '<cmd>PasteImg<cr>', desc = '[p]aste Image from Clipboard' },
            { '<c-P>', '<cmd>PasteImg<cr>', { desc = '[p]aste Image from Clipboard', mode = 'i'} }
        },
    },
    { 'NFrid/due.nvim',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        opts = {
            prescript = '  due in ',             -- prescript to due data
            use_clock_time = true,         -- display also hours and minutes
            use_clock_today = true,        -- do it instead of TODAY
            use_seconds = false,            -- if use_clock_time == true, display seconds
        },
        ft = require('quboid').ft_markup,
    },
    { 'AckslD/nvim-FeMaco.lua',
        opts = {
            border = require('quboid').border,
            prepare_buffer = function(opts)
                vim.cmd('split')
                local win = vim.api.nvim_get_current_win()
                local buf = vim.api.nvim_create_buf(false, false)
                return vim.api.nvim_win_set_buf(win, buf)
            end,
            post_open_float = function(winnr)
                -- vim.wo.signcolumn = 'no'
                vim.wo.winhighlight = "Nomral:NormalFloat"
            end
        },
        ft = require('quboid').ft_markup,
        keys = {
            { '<leader>o', '<cmd>FeMaco<cr>', desc = 'FeMaco [o]pen Codeblock' }
        },
    },
    { 'lukas-reineke/headlines.nvim',
        opts = {
            markdown = {
                headline_highlights = { "Headline" },
                codeblock_highlight = "CodeBlock",
                dash_highlight = "Dash",
                dash_string = "-",
                quote_highlight = "Quote",
                quote_string = "┃",
                fat_headlines = false,
                fat_headline_upper_string = "▃",
                fat_headline_lower_string = "🬂",
            },
        },
        ft = require('quboid').ft_markup,
    },
    { 'preservim/vim-markdown',
        dependencies = {
            'godlygeek/tabular',
        },
        init = function ()
            vim.g.vim_markdown_conceal = 0
            vim.g.vim_markdown_folding_disabled = 1
            vim.g.vim_markdown_conceal_code_blocks = 0
            vim.g.vim_markdown_math = 1
            vim.g.vim_markdown_frontmatter = 1
            vim.g.vim_markdown_strikethrough = 1
            vim.g.vim_markdown_new_list_item_indent = 1
            vim.g.vim_markdown_auto_insert_bullets = 1
            vim.g.vim_markdown_no_default_key_mappings = 1
        end,
        ft = require('quboid').ft_markup,
    },
    { 'iamcco/markdown-preview.nvim',
        init = function()
            -- https://github.com/iamcco/markdown-preview.nvim/issues/19#issuecomment-464344382
            vim.cmd[[
                function OpenMarkdownPreview (url)
                    exec "silent ! qutebrowser --target=window " . a:url . " &"
                endfunction
            ]]
            vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'
            vim.g.mkdp_auto_start = 0
            vim.g.mkdp_auto_close = 1
            vim.g.mkdp_browser = ''
            vim.g.mkdp_echo_preview_url = 1
            vim.g.mkdp_theme = 'light'
        end,
        build = "cd app && yarn install",
        ft = require('quboid').ft_markup,
        cmd = {
            'MarkdownPreview',
            'MarkdownPreviewToggle'
        },
        keys = {
            { '<f5>', '<cmd>MarkdownPreviewToggle<cr>', desc = 'Markdown Preview Toggle' },
        },
    },
    { 'mickael-menu/zk-nvim',
        ft = require('quboid').ft_markup,
        cmd = {
            'ZkCd',
        },
        event = 'VeryLazy',
        config = function ()
            local lsp_config = require('lsp').gen_config()
            lsp_config = vim.tbl_extend('keep', lsp_config or {}, { cmd = { 'zk', 'lsp' }, name = 'zk' })

            require('zk').setup({
                -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
                -- it's recommended to use "telescope" or "fzf"
                picker = 'telescope',

                lsp = {
                    -- `config` is passed to `vim.lsp.start_client(config)`
                    config = lsp_config,

                    -- automatically attach buffers in a zk notebook that match the given filetypes
                    auto_attach = {
                        enabled = true,
                        filetypes = require('quboid').ft_markup,
                    },
                },
            })
        end,
        keys = {
            { '<leader>zn', function ()
                
                local group_tbl = {
                    ['base'] = {
                        { 'title', 'Title: ' },
                    },
                    ['index'] = {
                        { 'dir', 'Subdirectory: ', nil, function (table)

                                local dirtocheck = vim.fn.expand('%:p:h')..'/'..table.dir
                                -- Create (sub)directory if needed
                                if vim.fn.isdirectory(dirtocheck) == 0 then vim.fn.mkdir(dirtocheck, 'p') end
                                table.dir = dirtocheck

                                table.extra = { ['type-tags'] = '#index' }
                                return table
                            end
                        },
                        { 'title', 'Title: ' },
                    },
                    ['dir-calendar'] = {},  -- TODO: add dir-calendar
                    ['dir-title'] = {
                        { 'title', 'Title: ' },
                    },
                    ['date-title'] = {
                        { 'title', 'Title: ' },
                    }
                }

                local group_names = {}
                for k,_ in pairs(group_tbl) do table.insert(group_names, k) end

                vim.ui.select(group_names, {
                    prompt = 'Select Group: ',
                }, function (group_choice) 
                        require('util').input_builder(group_tbl[group_choice], function (table)

                            vim.notify(vim.inspect(table))

                            local confirm_val = vim.fn.confirm("Use Custom Template?", "&No\n&Yes")
                            if confirm_val == 1 then
                                require('zk').new(table)
                            elseif confirm_val == 2 then

                                local templates = vim.split(vim.fn.system('ls -A '..vim.fn.expand('$XDG_CONFIG_HOME')..'/zk/templates'..'/'..group_choice), '\n')
                                -- Add group_choice/
                                for i, v in ipairs(templates) do if v == "" then table.remove(templates, i) end end
                                for k, v in pairs(templates) do templates[k] = group_choice..'/'..v end
                                -- Include base template
                                table.insert(templates, group_choice..'.md')

                                vim.ui.select(templates, {
                                    prompt = 'Select Template: '
                                }, function (template_choice)
                                        table['template'] = template_choice
                                        require('zk').new(table)
                                    end)
                                
                            end

                        end, { group = group_choice, dir = vim.fn.expand('%:p:h') })
                    end)

            end },
            { '<leader>zs', '<cmd>ZkNotes<cr>', '[z]k [s]earch' },
            { '<leader>zi', '<cmd>ZkInsertLink<cr>', '[z]k [s]earch' },
            { '<cr>', function () vim.lsp.buf.definition() end, 'Zk Follow note' }
        },
    }
}

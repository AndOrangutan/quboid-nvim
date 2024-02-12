return {
    {
        'mickael-menu/zk-nvim',
        ft = require('quboid.ft').markup,
        cmd = {
            'ZkCd',
        },
        config = function()
            local lsp_config = require('quboid.lsp').gen_config()
            lsp_config = vim.tbl_extend('keep', lsp_config or {}, { cmd = { 'zk', 'lsp' }, name = 'zk' })

            require('zk').setup({
                -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
                -- it's recommended to use "telescope" or "fzf"
                picker = 'fzf_lua',

                lsp = {
                    -- `config` is passed to `vim.lsp.start_client(config)`
                    config = lsp_config,

                    -- automatically attach buffers in a zk notebook that match the given filetypes
                    auto_attach = {
                        enabled = true,
                        filetypes = require('quboid.ft').markup,
                    },
                },
            })
        end,
        keys = {
            { '<leader>zn', function()
                local group_tbl = {
                    ['base'] = {
                        { 'title', 'Title: ' },
                    },
                    ['index'] = {
                        { 'dir', 'Subdirectory: ', nil, function(table)
                            local dirtocheck = vim.fn.expand('%:p:h') .. '/' .. table.dir
                            -- Create (sub)directory if needed
                            if vim.fn.isdirectory(dirtocheck) == 0 then vim.fn.mkdir(dirtocheck, 'p') end
                            table.dir = dirtocheck

                            table.extra = { ['type-tags'] = '#index' }
                            return table
                        end
                        },
                        { 'title', 'Title: ' },
                    },
                    ['dir-calendar'] = {}, -- TODO: add dir-calendar
                    ['dir-title'] = {
                        { 'title', 'Title: ' },
                    },
                    ['date-title'] = {
                        { 'title', 'Title: ' },
                    }
                }

                local group_names = {}
                for k, _ in pairs(group_tbl) do table.insert(group_names, k) end

                vim.ui.select(group_names, {
                    prompt = 'Select Group: ',
                }, function(group_choice)
                    require('quboid.util').input_builder(group_tbl[group_choice], function(table)
                        vim.notify(vim.inspect(table))

                        local confirm_val = vim.fn.confirm('Use Custom Template?', '&No\n&Yes')
                        if confirm_val == 1 then
                            require('zk').new(table)
                        elseif confirm_val == 2 then
                            local templates = vim.split(
                                vim.fn.system('ls -A ' ..
                                    vim.fn.expand('$XDG_CONFIG_HOME') .. '/zk/templates' .. '/' .. group_choice), '\n')
                            -- Add group_choice/
                            for i, v in ipairs(templates) do if v == '' then table.remove(templates, i) end end
                            for k, v in pairs(templates) do templates[k] = group_choice .. '/' .. v end
                            -- Include base template
                            table.insert(templates, group_choice .. '.md')

                            vim.ui.select(templates, {
                                prompt = 'Select Template: '
                            }, function(template_choice)
                                if template_choice ~= nil then
                                    table['template'] = template_choice
                                    require('zk').new(table)
                                end
                            end)
                        end
                    end, { group = group_choice, dir = vim.fn.expand('%:p:h') })
                end)
            end },
            { '<leader>zs', '<cmd>ZkNotes<cr>',                      desc = '[z]k [s]earch' },
            { '<leader>zl', '<cmd>ZkLinks<cr>',                      desc = '[z]k [l]inks' },
            { '<leader>zb', '<cmd>ZkBacklinks<cr>',                  desc = '[z]k [b]acklinks' },
            { '<leader>zi', '<cmd>ZkInsertLink<cr>',                 desc = '[z]k [i]sert Link' },
            { '<cr>',       function() vim.lsp.buf.definition() end, desc = 'Zk Follow note' }
        },
    },
    {
        'lukas-reineke/headlines.nvim',
        opts = {
            markdown = {
                headline_highlights = { 'Headline' },
                codeblock_highlight = 'CodeBlock',
                dash_highlight = 'Dash',
                dash_string = '-',
                quote_highlight = 'Quote',
                quote_string = '┃',
                fat_headlines = false,
                fat_headline_upper_string = '▃',
                fat_headline_lower_string = '🬂',
                bullets = { '◉', '○', '✸', '✿' },
            },
        },
        ft = require('quboid.ft').markup,
    },
    {
        'NFrid/due.nvim',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        ft = require('quboid.ft').markup,
        opts = {
            prescript = '  due in ', -- prescript to due data
            use_clock_time = true,   -- display also hours and minutes
            use_clock_today = true,  -- do it instead of TODAY
            use_seconds = false,     -- if use_clock_time == true, display seconds
        },
    },
    {
        'jbyuki/nabla.nvim',
        ft = require('quboid.ft').markup,
        keys = {
            { '<leader>ml', '<cmd>lua require("nabla").toggle_virt()<cr>', desc = '[m]arkdown [l]aTeX Toggle' },
        },
    },
    {
        'AckslD/nvim-FeMaco.lua',
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
                vim.wo.winhighlight = 'Nomral:NormalFloat'
            end
        },
        ft = require('quboid').markup,
        keys = {
            { '<leader>o', '<cmd>FeMaco<cr>', desc = 'FeMaco [o]pen Codeblock' }
        },
    },
    {
        'toppair/peek.nvim',
        event = { 'VeryLazy' },
        build = 'deno task --quiet build:fast',
        keys = {
            { '<f5>', '<cmd>PeekToggle<cr>', desc = 'Markdown Preview Toggle' },
        },
        config = function()
            require('peek').setup({
                close_on_bdelete = true, -- close preview window on buffer delete
                syntax = true,           -- enable syntax highlighting, affects performance
                theme = 'dark',          -- 'dark' or 'light'
                update_on_change = true,
                app = 'webview',         -- 'webview', 'browser', string or a table of strings
                -- explained below

                filetype = require('quboid.ft').markup, -- list of filetypes to recognize as markdown

                -- relevant if update_on_change is true
                throttle_at = 200000,   -- start throttling when file exceeds this
                -- amount of bytes in size
                throttle_time = 'auto', -- minimum amount of time in milliseconds
                -- that has to pass before starting new render
            })
            -- refer to `configuration to change defaults`
            vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
            vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
            vim.api.nvim_create_user_command('PeekToggle',
                function() require('quboid.util').toggle_cmd('PeekOpen', 'PeekClose') end, {})
        end,
    },
    {
        'postfen/clipboard-image.nvim',
        config = true,
        opts = {
            default = {
                img_dir = { '%:p:h' },
                img_dir_txt = '',
                img_name = function()
                    return vim.fn.expand('%:t:r') .. '-' .. os.date('%Y-%m-%d-%H-%M-%S')
                end,
                img_handler = function(img)
                    -- Add in alt text
                    vim.cmd('normal! f[')                              -- go vo [
                    vim.cmd('normal! a' .. vim.fn.input('Alt-text: ')) -- append text with image name

                    -- Compress image
                    --local script = string.format('~/.scripts/tinypng.sh -s f %s &', img.path)
                    --return os.execute(script)
                end,
                affix = '![](%s)',
            },
        },
        keys = {
            { '<c-P>', '<cmd>PasteImg<cr>', desc = '[p]aste Image from Clipboard' },
            { '<c-P>', '<cmd>PasteImg<cr>', { desc = '[p]aste Image from Clipboard', mode = 'i' } }
        },
    },
}

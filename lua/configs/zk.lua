
local wk = require('which-key')
local zk = require('zk')
local commands = require('zk.commands')
local lsputil = require('lsp-util')
--
--     - [Z]k[I]nsert[I]dex
--    - [Z]k[I]nsert[N]ote



zk.setup({
    -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
    -- it's recommended to use "telescope" or "fzf"
    picker = "fzf",

    lsp = {
        -- `config` is passed to `vim.lsp.start_client(config)`
        config = {
            cmd = { "zk", "lsp" },
            name = "zk",
            -- on_attach = ...
            -- etc, see `:h vim.lsp.start_client()`
        },

        on_attach = lsputil.create_on_attach(),

        -- automatically attach buffers in a zk notebook that match the given filetypes
        auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
        },
    },
})

local groups = {
    'base',
    'index',
    'dir-calendar',
    'dir-title',
    'date-title'
}

local function selectNote(options, picker_options)
    zk.pick_notes(options, picker_options, function (notes)
        local cursorPos = vim.api.nvim_win_get_cursor(0)[2]
        local line = vim.api.nvim_get_current_line()

        if picker_options.multi_select == false then
            notes = { notes }
        end

        for _, note in ipairs(notes) do
            local nline = line:sub(0,cursorPos)..'['.. note.title ..']('..note.path..')'..line:sub(cursorPos+1)
            vim.api.nvim_set_current_line(nline)

        end
    end)
end
commands.add('ZkSelectNote', function (options) selectNote(options, { title = 'Zk Select' }) end )

local function newNote(options, picker_options)
    local cursorPos = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()

    vim.ui.select( groups, {
        prompt = 'Select Group: '
    }, function (group_choice) 

            -- General
            
            -- note creation variables
            local dir, title, extra, group
            local subdir = ''

            -- 2 Group Specific Config
            if 'base' ==  group_choice then
                dir = vim.fn.expand('%:p:h')
                title = vim.fn.input('Title: ')
            elseif 'index' ==  group_choice then
                subdir = vim.fn.input('Subdir. for new Index: ')
                local dirtocheck = vim.fn.expand('%:p:h')..'/'..subdir

                -- Create (sub)directory if needed
                if vim.fn.isdirectory(dirtocheck) == 0 then
                    vim.fn.mkdir(dirtocheck, 'p')
                end

                dir = dirtocheck
                title = vim.fn.input('Title: ')
                extra = {
                    ['type-tags'] = '#index',
                }
            elseif 'dir-calendar' == group_choice then
            elseif 'dir-title' == group_choice then
                dir = vim.fn.expand('%:p:h')
                title = vim.fn.input('Title: ')
            elseif 'date-title' == group_choice then
                dir = vim.fn.expand('%:p:h')
                title = vim.fn.input('Title: ')
            end

            -- 3 Conrim Template Modificaiton
            local confirm_val = vim.fn.confirm("Use Custom Template?", "&No\n&Yes")
            -- No need since defualt to keeping the normal one
            if 1 == confirm_val then
                require('zk').new({
                    title = title,
                    dir = dir,
                    group = group_choice,
                    extra = extra,
                })

                -- Change template
            elseif 2 == confirm_val then
                -- Templates in group_choice/*
                local templates = vim.split(vim.fn.system('ls -A '..vim.fn.expand('$ZK_NOTEBOOK_DIR')..'/.zk/templates'..'/'..group_choice), '\n')
                -- Add group_choice/

                for i, v in ipairs(templates) do if v == "" then table.remove(templates, i) end end
                for k, v in pairs(templates) do templates[k] = group_choice..'/'..v end

                -- Include base template
                table.insert(templates, group_choice..'.md')



                vim.ui.select(templates, {
                    prompt = 'Select Template: '
                }, function (template_choice) 

                        require('zk').new({
                            title = title,
                            dir = dir,
                            group = group_choice,
                            template = template_choice,
                        })
                    end )

            end

        end )


    local nline = line:sub(0,cursorPos)..'['.. note.title ..']('..note.path..')'..line:sub(cursorPos+1)
    vim.api.nvim_set_current_line(nline)

end


wk.register({



    --
    -- [z][n]       New Note...
    -- [z][n][b]    Base
    -- [z][n][i]    Index
    -- [z][n][d]    Dir Heading
    -- [z][n][d][t] Dir Heading
    -- [z][n][c]    Calendar Heading

    

    ['<leader>zn'] = {
        function ()

            -- 1 Select Group
            vim.ui.select( groups, {
                prompt = 'Select Group: '
            }, function (group_choice) 

                local dir, title, extra, group
                    -- General

                    -- 2 Group Specific Config
                    if 'base' ==  group_choice then
                        dir = vim.fn.expand('%:p:h')
                        title = vim.fn.input('Title: ')
                    elseif 'index' ==  group_choice then
                        local dirtocheck = vim.fn.expand('%:p:h')..'/'..vim.fn.input('Subdir: ')
            

                        -- Create (sub)directory if needed
                        if vim.fn.isdirectory(dirtocheck) == 0 then
                            vim.fn.mkdir(dirtocheck, 'p')
                        end

                        dir = dirtocheck
                        title = vim.fn.input('Title: ')
                        extra = {
                            ['type-tags'] = '#index',
                        }
                    elseif 'dir-calendar' == group_choice then
                    elseif 'dir-title' == group_choice then
                        dir = vim.fn.expand('%:p:h')
                        title = vim.fn.input('Title: ')
                    elseif 'date-title' == group_choice then
                        dir = vim.fn.expand('%:p:h')
                        title = vim.fn.input('Title: ')
                    end

                    -- 3 Conrim Template Modificaiton
                    local confirm_val = vim.fn.confirm("Use Custom Template?", "&No\n&Yes")
                    -- No need since defualt to keeping the normal one
                    if 1 == confirm_val then
                        require('zk').new({
                            title = title,
                            dir = dir,
                            group = group_choice,
                            extra = extra,
                        })

                    -- Change template
                    elseif 2 == confirm_val then
                        -- Templates in group_choice/*
                        local templates = vim.split(vim.fn.system('ls -A '..vim.fn.expand('$ZK_NOTEBOOK_DIR')..'/.zk/templates'..'/'..group_choice), '\n')
                        -- Add group_choice/

                        for i, v in ipairs(templates) do if v == "" then table.remove(templates, i) end end
                        for k, v in pairs(templates) do templates[k] = group_choice..'/'..v end

                        -- Include base template
                        table.insert(templates, group_choice..'.md')



                        vim.ui.select(templates, {
                            prompt = 'Select Template: '
                        }, function (template_choice) 

                                require('zk').new({
                                    title = title,
                                    dir = dir,
                                    group = group_choice,
                                    template = template_choice,
                                })
                            end )

                    end

                end )

            -- require('fzf-lua').files({
            --     actions = {
            --         ['default'] = function(selected)
            --             vim.notify("selected item: ", selected[0])
            --         end
            --
            --     },
            --     prompt='LS> ', 
            --     cwd='$ZK_NOTEBOOK_DIR/.zk/templates'
            -- })
        end, '[z]k [n]ew [t]emplate'
    },
    ['<CR>'] = { '<cmd>lua vim.lsp.buf.definition()<cr>', 'ZK Open Link' },

    ['<leader>zs'] = { '<cmd>ZkNotes<cr>', '[z]k [s]earch'},
    ['<leader>znb'] = {
        function ()
            require('zk').new({
                dir = vim.fn.expand('%:p:h'),
                group = "base",
                title = vim.fn.input('Title: '),
                extra = {
                    ['user-tags'] = vim.fn.input('Additional Tags: '),
                },
            })
        end, '[z]k [n]ew [b]ase'

    },
    ["<leader>znd"] = { name = "[z]k [n]ew w/ [d]ir" },
    ['<leader>zndd'] = {
        function ()
            require('zk').new({
                dir = vim.fn.expand('%:p:h'),
                group = "dir-date",
                extra = {
                    ['user-tags'] = vim.fn.input('Additional Tags: '),
                },
            })
        end, '[z]k [n]ew w/ [d]ir & [d]ate'
    },
    ['<leader>zndt'] = {
        function ()
            require('zk').new({
                dir = vim.fn.expand('%:p:h'),
                group = "dir-title",
                title = vim.fn.input('Title: '),
                extra = {
                    ['user-tags'] = vim.fn.input('Additional Tags: '),
                },
            })
        end, '[z]k [n]ew w/ [d]ir & [t]itle'
    },
    ['<leader>zni'] = {
        function ()
            local dirtocheck = vim.fn.expand('%:p:h')..'/'..vim.fn.input('Subdir: ')

            if vim.fn.isdirectory(dirtocheck) == 0 then
                vim.fn.mkdir(dirtocheck, 'p')
            end

            require('zk').new({
                dir = dirtocheck,
                group = "base",
                title = vim.fn.input('Title: '),
                extra = {
                    ['type-tags'] = '#index',
                    ['user-tags'] = vim.fn.input('Additional Tags: '),
                },
            })
        end, '[z]k [n]ew [i]ndex'

    },
    --['<leader>zni'] = { [[<cmd>ZkNew { dir = vim.fn.expand('%:p:h')..vim.fn.input('Subdir: '), title = vim.fn.input('Title: '), extra = { user-tags = vim.fn.input('Additional Tags: ):)') }}<cr>]], '[z]k [n]ew [i]ndex'},
}, {})



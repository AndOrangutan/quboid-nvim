local wk = require('which-key')
--
--     - [Z]k[I]nsert[I]dex
--    - [Z]k[I]nsert[N]ote


require("zk").setup({
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

        -- automatically attach buffers in a zk notebook that match the given filetypes
        auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
        },
    },
})


wk.register({

    ['<leader>zs'] = { '<cmd>ZkNotes<cr>', '[z]k [s]earch'},
    ['<leader>znn'] = {
        function ()
            require('zk').new({
                dir = vim.fn.expand('%:p:h'),
                title = vim.fn.input('Title: '),
                extra = {
                    ['user-tags'] = vim.fn.input('Additional Tags: '),
                },
            })
        end, '[z]k [n]ew [n]ote'

    },
    ['<leader>zni'] = {
        function ()
            local dirtocheck = vim.fn.expand('%:p:h')..'/'..vim.fn.input('Subdir: ')
            vim.notify(dirtocheck)

            if vim.fn.isdirectory(dirtocheck) == 0 then
                vim.fn.mkdir(dirtocheck, 'p')
            end

            require('zk').new({
                dir = dirtocheck,
                group = 'index',
                title = vim.fn.input('Title: '),
                extra = {
                    ['user-tags'] = vim.fn.input('Additional Tags: '),
                },
            })
        end, '[z]k [n]ew [i]ndex'

    },
    ['<leader>zvnn'] = {
        function ()
            vim.cmd[[vsplit]]

            require('zk').new({
                dir = vim.fn.expand('%:p:h'),
                title = vim.fn.input('Title: '),
                extra = {
                    ['user-tags'] = vim.fn.input('Additional Tags: '),
                },
            })
        end, '[z]k [n]ew [n]ote'

    },

    ['<leader>zvni'] = {
        function ()
            vim.cmd[[vsplit]]

            local dirtocheck = vim.fn.expand('%:p:h')..'/'..vim.fn.input('Subdir: ')

            if vim.fn.isdirectory(dirtocheck) == 0 then
                vim.fn.mkdir(dirtocheck, 'p')
            end

            require('zk').new({
                dir = dirtocheck,
                group = 'index',
                title = vim.fn.input('Title: '),
                extra = {
                    ['user-tags'] = vim.fn.input('Additional Tags: '),
                },
            })
        end, '[z]k [n]ew [i]ndex'

    },
    --['<leader>zni'] = { [[<cmd>ZkNew { dir = vim.fn.expand('%:p:h')..vim.fn.input('Subdir: '), title = vim.fn.input('Title: '), extra = { user-tags = vim.fn.input('Additional Tags: ):)') }}<cr>]], '[z]k [n]ew [i]ndex'},
})



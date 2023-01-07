local wk = require('which-key')
local zk = require('zk')
local zkcommands = require('zk.commands')
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

        on_attach = vim.g.quboid_lsp_on_attach,

        -- automatically attach buffers in a zk notebook that match the given filetypes
        auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
        },
    },
})


wk.register({

    ['<leader>znt'] = {
        function ()
            require('fzf-lua').fzf_exec('ls *.md', {
                actions = {
                    ['default'] = function(selected, opts)
                        print("selected item:", selected[1])
                    end

                },
                prompt='LS> ', 
                cwd='~/$ZK_NOTEBOOK_DIR/.zk/templates'
            })
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
            vim.notify(dirtocheck)

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
})


local function yankName(options, picker_options)
  zk.pick_notes(options, picker_options, function(notes)
    local pos = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()

    if picker_options.multi_select == false then
      notes = { notes }
    end
    for _, note in ipairs(notes) do
      local nline = line:sub(0, pos) .. "[" .. note.title  .. "]" .. "(" .. note.path .. ")" .. line:sub(pos + 1)
      vim.api.nvim_set_current_line(nline)
    end
  end)
end
zkcommands.add("ZkYankName", function(options) yankName(options, { title = "Zk Yank" }) end)

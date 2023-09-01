return {
    { 'sindrets/diffview.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = {
            'DiffviewOpen',
            'DiffviewToggle',
        },
        event = 'VeryLazy',
        keys = {
            { '<leader>gd', function () require('util').toggle_cmd('DiffviewOpen', 'DiffviewClose') end, desc = '[d]iffview Toggle' },
        },
    },
    { 'tpope/vim-fugitive' },
    { 'lewis6991/gitsigns.nvim',
        config = true,
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            { '<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<cr>', '[g]it [b]lame toggle' },
        },
    },
    { 'ThePrimeagen/git-worktree.nvim',
        config = function ()
            local worktree = require('git-worktree')
            worktree.on_tree_change(function(op, metadata)
                if op == worktree.Operations.Switch then
                    vim.notify('Switched worktree from ' .. metadata.prev_path .. ' to ' .. metadata.path, vim.log.levels['INFO'])
                end
            end)
        end,
        keys = {
            { '<leader>fw', function () require('configs.fzf-git-worktree').git_worktrees() end, '[f]zf Git [w]orktrees' },
            -- TODO: Convert to current input_builder :')
            -- { '<leader>gwa', function ()
            --     local util = require('util')
            --     -- <branch>
            --     -- <path>
            --     -- <remote>/<branch>
            --     local table = {
            --         { { prompt = 'Path: ' }, 'path' },
            --         { function (prev_output) return { prompt = 'Name: ', default = prev_output.path  } end, 'name' },
            --         { function (prev_output) return { prompt = 'Upstream Location: ', default = 'remote'  } end, 'upstream' },
            --     }
            --     util.input_builder({}, table, function(output)
            --         require('git-worktree').create_worktree(output.path, output.name, output.remote)
            --     end, {})
            -- end, '[g]it [w]orktree [a]dd' },
            { '<leadergws', function () require('git-worktree').switch_worktree(vim.fn.input('Path: ')) end, '[g]it [w]orktree [s]witch' },
        },
    },
    { 'TimUntersberger/neogit',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = {
            integrations = { diffview = true },
        },
        keys = {
            { '<leader>gg', '<cmd>Neogit<cr>', 'Neo[g]it Toggle [g]oodness' }
        },
        event = 'VeryLazy',
    },
}

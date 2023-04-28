local util = require('util')

local worktree = require('git-worktree')

util.keymap('n', '<leader>fw', function () require('configs.fzf-git-worktree').git_worktrees() end, '[f]zf Git [w]orktrees')
util.keymap('n', '<leader>gwa', function()
    -- <branch>
    -- <path>
    -- <remote>/<branch>
    local table = {
        { { prompt = 'Path: ' }, 'path' },
        { function (prev_output) return { prompt = 'Name: ', default = prev_output.path  } end, 'name' },
        { function (prev_output) return { prompt = 'Upstream Location: ', default = 'remote'  } end, 'upstream' },
    }
    util.input_builder({}, table, function(output)
        require('git-worktree').create_worktree(output.path, output.name, output.remote)
    end, {})
end, '[g]it [w]orktree [a]dd')
util.keymap('n', '<leader>gws', function () require('git-worktree').switch_worktree(vim.fn.input('Paht: ')) end, '[g]it [w]orktree [s]witch')

worktree.on_tree_change(function(op, metadata)
  if op == worktree.Operations.Switch then
    vim.notify('Switched worktree from ' .. metadata.prev_path .. ' to ' .. metadata.path)
  end
end)

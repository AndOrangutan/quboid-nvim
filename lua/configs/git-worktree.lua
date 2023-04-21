local util = require('util')

local worktree = require('git-worktree')

util.keymap('n', '<leader>fw', function () require('configs.fzf-git-worktree').git_worktrees() end, '[f]zf Git [w]orktrees')
util.keymap('n', '<leader>gwa', function () require('git-worktree').create_worktree(vim.fn.input('Path: '), vim.fn.input('Branch Name: '), vim.fn.inpu('Upstream')) end, '[g]it [w]orktree [a]dd')
util.keymap('n', '<leader>gws', function () require('git-worktree').switch_worktree(vim.fn.input('Paht: ')) end, '[g]it [w]orktree [a]dd')
util.keymap('n', '<leader>gws', function () require('git-worktree').switch_worktree(vim.fn.input('Paht: ')) end, '[g]it [w]orktree [a]dd')

worktree.on_tree_change(function(op, metadata)
  if op == worktree.Operations.Switch then
    vim.notify('Switched worktree from ' .. metadata.prev_path .. ' to ' .. metadata.path)
  end
end)

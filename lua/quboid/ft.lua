local M = {}

M.ft_exclude = {
    'fzf',
    'gitcommit',
    'gitrebase',
    'lazy',
    'neo-tree',
    'nofile',
    'prompt',
    'starter',
    'quickfix',
}

M.bt_exclude = {
    'quickfix',
    'terminal',
}

-- For markdown and note taking like environments
M.markup = {
    'markdown',
}

M.git = {
    'gitcommit',
}

return M

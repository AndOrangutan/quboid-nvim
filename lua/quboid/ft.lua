local M = {}

M.ft_exclude = {
    'fzf',
    'gitcommit',
    'gitrebase',
    'lazy',
    'markdown',
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

M.supported_lang = {
    'c',
    'cpp',
    'go',
    'java',
    'javascript',
    'lua',
    'python',
}
-- For markdown and note taking like environments
M.markup = {
    'markdown',
}

M.js = {
    -- TODO: Add other jsx types
    'javascript',
}

M.git = {
    'gitcommit',
}

return M

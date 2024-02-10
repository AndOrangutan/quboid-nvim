local M = {}

M.ft_exclude = {
    'NeogitStatus',
    'Outline',
    'Trouble',
    'fzf',
    'gitcommit',
    'gitrebase',
    'lazy',
    'markdown',
    'neo-tree',
    'nofile',
    'prompt',
    'quickfix',
    'starter',
    'undotree',
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

M.js = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' }

M.git = {
    'gitcommit',
}

return M

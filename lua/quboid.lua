local M = {}

M.boarder = 'solid'
M.border_float = 'shadow'
M.ft_exclude = { 'fzf', 'vim', 'alpha', 'neo-tree', 'mason', 'NeogitStatus', 'Outline', 'NvimTree', 'undotree', 'gundo' }
M.ft_exclude_strict = { 'fzf', 'vim', 'alpha', 'neo-tree', 'mason', 'NeogitStatus', 'Outline', 'NvimTree', 'undotree', 'gundo', 'help', 'markdown' }
M.ft_marktex = { 'tex', 'latex', 'markdown'}
M.icon_end_padding = ' '
M.icons = {
    -- TODO: add lsp icons and such
}

return M

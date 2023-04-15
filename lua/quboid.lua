local M = {}

M.boarder = 'solid'
M.border_float = 'shadow'
-- M.ft_exclude = { 'fzf', 'vim', 'alpha', 'neo-tree', 'mason', 'NeogitStatus', 'Outline', 'NvimTree', 'undotree', 'gundo' }
-- M.ft_exclude_strict = { 'fzf', 'vim', 'alpha', 'neo-tree', 'mason', 'NeogitStatus', 'Outline', 'NvimTree', 'undotree', 'gundo', 'help', 'markdown' }
M.ft_exclude = {}
M.ft_exclude_srict = {}
M.ft_rigid = { 'neo-tree' }
M.ft_marktex = { 'tex', 'latex', 'markdown'}
M.icons = {
    -- TODO: add lsp icons and such
    indentscope = '╏',
}
M.icon_end_padding = ' '

return M

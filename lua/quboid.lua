local M = {}

M.boarder = 'solid'
M.border_float = 'shadow'
-- M.ft_exclude = { 'fzf', 'vim', 'alpha', 'neo-tree', 'mason', 'NeogitStatus', 'Outline', 'NvimTree', 'undotree', 'gundo' }
-- M.ft_exclude_strict = { 'fzf', 'vim', 'alpha', 'neo-tree', 'mason', 'NeogitStatus', 'Outline', 'NvimTree', 'undotree', 'gundo', 'help', 'markdown' }
M.ft_exclude = { 'fzf', 'minimap' }
M.ft_exclude_srict = { 'fzf', 'minimap' }
M.ft_rigid = { 'neo-tree', 'minimap' }
M.ft_marktex = { 'tex', 'latex', 'markdown'}
M.icons = {
    -- TODO: add lsp icons and such

    -- General single chars
    pad = ' ',
    triangle_cursor = '⏵',
    bar_thick = '┃',
    bar_thick_split = '╏',

}

return M

local M = {}

M.boarder = 'solid'
M.border_float = 'shadow'
-- M.ft_exclude = { 'fzf', 'vim', 'alpha', 'neo-tree', 'mason', 'NeogitStatus', 'Outline', 'NvimTree', 'undotree', 'gundo' }
-- M.ft_exclude_strict = { 'fzf', 'vim', 'alpha', 'neo-tree', 'mason', 'NeogitStatus', 'Outline', 'NvimTree', 'undotree', 'gundo', 'help', 'markdown' }
M.ft_exclude = { 'fzf', 'minimap', 'neo-tree', 'notify' }
M.ft_exclude_srict = { 'fzf', 'minimap', 'neo-tree', 'notify' }
M.ft_rigid = { 'neo-tree', 'minimap' }
M.ft_marktex = { 'tex', 'latex', 'markdown'}
M.icons = {
    -- TODO: add lsp icons and such

    -- General single chars
    pad = ' ',
    triangle_cursor     = '▮',
    bar_thick           = '┃',
    bar_thick_split     = '╏',

    -- LSP
    Error               = ' ',
    Warn                = ' ',
    Info                = ' ',
    Hint                = ' ',

    Debug               = ' ',
    Trace               = ' ',

    -- Completion kind
    --
        -- CMP completion kind
    Class               = ' ',
    Color               = ' ',
    Constant            = ' ',
    Constructor         = ' ',
    Enum                = ' ',
    EnumMember          = ' ',
    Event               = ' ',
    Field               = ' ',
    File                = ' ',
    Folder              = ' ',
    Function            = 'x',
    Interface           = ' ',
    Keyword             = ' ',
    Method              = ' ',
    Module              = ' ',
    Operator            = ' ',
    Property            = ' ',
    Reference           = ' ',
    Snippet             = ' ',
    Struct              = " ",
    Text                = ' ',
    TypeParameter       = ' ',
    Unit                = ' ',
    Value               = ' ',
    Variable            = ' ',
    Copilot             = ' ',

}

return M

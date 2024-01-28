local M = {}

-- General icons for use throughout the editor
M.gen = {
    editor       = ' ',
    pad          = '  ',

    -- LSP
    circle_error = ' ',
    circle_warn  = ' ',
    circle_info  = ' ',
    circle_hint  = ' ',
    circle_ok    = ' ',
    circle_stop  = ' ',

    arrow_left   = ' ',
    arrow_right  = ' ',
    bolt         = ' ',
    box_added    = ' ',
    box_deleted  = ' ',
    box_git      = ' ',
    box_modified = ' ',
    box_o        = ' ',
    box_o_check  = ' ',
    box_renamed  = ' ',
    check        = ' ',
    circle       = ' ',
    circle_half  = ' ',
    circle_o     = ' ',
    close        = ' ',
    cmd          = ' ',
    code         = ' ',
    cog          = '󰒓 ',
    config       = ' ',
    file         = ' ',
    file_export  = ' ',
    file_inport  = ' ',
    folder       = ' ',
    folder_o     = ' ',
    folder_open  = ' ',
    hidden       = ' ',
    key          = ' ',
    keybord      = ' ',
    pause        = ' ',
    pencil       = ' ',
    play         = ' ',
    plug         = ' ',
    question     = ' ',
    toggle_off   = ' ',
    toggle_on    = ' ',
    zzz          = '󰒲 ',

}

M.lsp_kind = {
    Namespace     = '󰦮 ',
    Package       = ' ',
    String        = '69',
    Number        = ' ',
    Boolean       = ' ',
    Array         = ' ',
    Object        = ' ',
    Key           = ' ',
    Null          = '󰟢 ',

    Class         = ' ',
    Color         = ' ',
    Constant      = ' ',
    Constructor   = ' ',
    Enum          = ' ',
    EnumMember    = ' ',
    Event         = ' ',
    Field         = ' ',
    File          = ' ',
    Folder        = ' ',
    Function      = '󰊕x',
    Interface     = ' ',
    Keyword       = ' ',
    Method        = ' ',
    Module        = ' ',
    Operator      = ' ',
    Property      = ' ',
    Reference     = ' ',
    Snippet       = ' ',
    Struct        = ' ',
    Text          = ' ',
    TypeParameter = ' ',
    Unit          = ' ',
    Value         = ' ',
    Variable      = ' ',
    Copilot       = ' ',
}

M.lang = {
    lua = ' ',
}

M.ui = {
    bar_cursor      = '▮',
    bar_thick       = '┃',
    bar_thick_tree  = '┣',
    bar_thick_elbow = '┗',
    bar_thick_split = '╏',
    collapse        = '',
    expand          = '',
}

return M

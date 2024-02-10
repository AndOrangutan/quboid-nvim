local M = {}

-- General icons for use throughout the editor
M.gen = {
    editor         = ' ',
    pad            = '  ',

    -- LSP
    circle_error   = ' ',
    circle_warn    = ' ',
    circle_info    = ' ',
    circle_hint    = ' ',
    circle_ok      = ' ',
    circle_stop    = ' ',

    arrow_left     = ' ',
    arrow_right    = ' ',
    beaker         = ' ',
    bolt           = ' ',
    box_added      = ' ',
    box_deleted    = ' ',
    box_git        = ' ',
    box_modified   = ' ',
    box_o          = ' ',
    box_o_check    = ' ',
    box_renamed    = ' ',
    bug            = ' ',
    calendar       = ' ',
    check          = ' ',
    circle         = ' ',
    circle_dot     = ' ',
    circle_half    = ' ',
    circle_o       = ' ',
    circle_triple  = ' ',
    close          = ' ',
    cmd            = ' ',
    code           = ' ',
    cog            = '󰒓 ',
    config         = ' ',
    exclamation    = ' ',
    extinguisher   = ' ',
    file           = ' ',
    file_export    = ' ',
    file_inport    = ' ',
    file_write     = ' ',
    flag_checkered = ' ',
    folder         = ' ',
    folder_o       = ' ',
    folder_open    = ' ',
    hidden         = ' ',
    key            = ' ',
    keybord        = ' ',
    map            = ' ',
    pause          = ' ',
    pencil         = ' ',
    pin            = ' ',
    play           = ' ',
    plug           = ' ',
    pound          = ' ',
    question       = ' ',
    server         = ' ',
    startup        = ' ',
    toggle_off     = ' ',
    toggle_on      = ' ',
    zzz            = '󰒲 ',

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

M.spinner = {
    ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '
}

M.lang = {
    lua = ' ',
}

M.ui = {
    bar_cursor      = '▮',
    bar_thick       = '┃',
    bar_thick_elbow = '┗',
    bar_thick_split = '╏',
    bar_thick_tree  = '┣',
    bar_thin        = '｜',
    collapse        = '',
    expand          = '',
}

return M

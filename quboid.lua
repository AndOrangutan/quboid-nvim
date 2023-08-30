local M = {}

M.colorscheme = 'onedark'
M.border = 'solid'
M.border_float = 'shadow'
M.ft_exclude = { 'lazy', 'NeogitStatus',  }
M.ft_git = { 'gitcommit', 'octo', 'NeogitCommitMessage' }
M.ft_javascript_package_manager = 'yarn'
M.ft_markup = { 'latex', 'markdown', 'tex',  }
M.ft_rigid = {  }
M.icons = {
    -- Shapes
    pad = ' ',
    bar_thin        = '｜',
    bar_cursor      = '▮',
    bar_thick       = '┃',
    bar_thick_tree  = '┣',
    bar_thick_elbow = '┗',
    bar_thick_split = '╏',

    pound           = ' ',
    close           = ' ',
    question        = '',
    arrow_left      = ' ',
    arrow_right     = ' ',

    -- General
    bolt            = ' ',
    cog             = '󰒓 ',
    check           = ' ',
    container       = ' ',
    cube            = ' ',
    file            = ' ',
    file_export     = ' ',
    file_import     = ' ',
    file_write      = ' ',
    folder          = ' ',
    folder_open     = ' ',
    folder_outline  = ' ',
    keyboard        = ' ',
    server          = ' ',
    vim             = ' ',
    hourglass_0     = ' ',
    hourglass_1     = ' ',
    hourglass_2     = ' ',
    hourglass_3     = ' ',
    hourglass_100   = ' ',
    code            = ' ',
    cmd             = ' ',
    circle_play     = ' ',
    pencil          = ' ',

    -- LSP
    circle_error    = ' ',
    circle_warn     = ' ',
    circle_info     = ' ',
    circle_hint     = ' ',
    circle_ok       = ' ',

    git_branch      = ' ',
    git_added       = ' ',
    git_modified    = ' ',
    git_deleted     = ' ',
    git_renamed     = ' ',
    git_untracked   = ' ',
    git_ignored     = ' ',
    git_staged      = ' ',
    git_unstaged    = ' ',
    git_conflict    = ' ',
}

M.lsp_kind = {
    Class           = ' ',
    Color           = ' ',
    Constant        = ' ',
    Constructor     = ' ',
    Enum            = ' ',
    EnumMember      = ' ',
    Event           = ' ',
    Field           = ' ',
    File            = ' ',
    Folder          = ' ',
    Function        = '󰊕x',
    Interface       = ' ',
    Keyword         = ' ',
    Method          = ' ',
    Module          = ' ',
    Operator        = ' ',
    Property        = ' ',
    Reference       = ' ',
    Snippet         = ' ',
    Struct          = " ",
    Text            = ' ',
    TypeParameter   = ' ',
    Unit            = ' ',
    Value           = ' ',
    Variable        = ' ',
    Copilot         = ' ',
}

return M

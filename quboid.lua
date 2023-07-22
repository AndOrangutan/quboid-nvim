local M = {}

M.colorscheme = 'onedark'
M.border = 'solid'
M.border_float = 'shadow'
M.ft_exclude = { 'lazy',  }
M.ft_javascript_package_manager = 'yarn'
M.ft_markup = { 'latex', 'markdown', 'tex',  }
M.ft_rigid = {  }
M.icons = {
    -- Shapes
    pad = ' ',
    bar_thin        = '｜',
    bar_cursor      = '▮',
    bar_thick       = '┃',
    bar_thick_split = '╏',

    close           = ' ',
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
}

return M

local M = {}

M.quboid_border = 'solid'
M.quboid_eol_padding = '  '
M.quboid_ft_javascript_package_manager = 'yarn'
M.quboid_border_float = 'shadow'
M.quboid_ft_exclude = { 'fzf', 'vim', 'alpha', 'neo-tree', 'mason', 'NeogitStatus', 'Outline', 'NvimTree', 'undotree', 'gundo' }
M.quboid_ft_exclude_strict = { 'fzf', 'vim', 'alpha', 'neo-tree', 'mason', 'NeogitStatus', 'Outline', 'NvimTree', 'undotree', 'gundo', 'help', 'markdown' }
M.quboid_ft_html = {'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'rescript', 'xml', 'php', 'markdown', 'glimmer','handlebars','hbs'}
M.quboid_ft_js = { 'typescript', 'typescriptreact', 'javashript' }
M.quboid_ft_marktex = { 'tex', 'latex', 'markdown'}
M.quboid_icons = {
    -- LSP
    Error           = ' ',
    Warn            = ' ',
    Info            = ' ',
    Hint            = ' ',

    -- Notify
    Debug           = ' ',
    Trace           = ' ',

    -- Luasnip
    ChoiceNode      = ' ',
    InsertNode      = ' ',

    -- Bufferline
    Close           = ' ',
    Modified        = ' ',
    ArrowLeft       = ' ',
    ArrowRight      = ' ',

    -- CMP completion kind
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
    Function        = 'x',
    Interface       = ' ',
    Keyword         = ' ',
    Method          = ' ',
    Module          = ' ',
    Operator        = ' ',
    Property        = ' ',
    Reference       = ' ',
    Snippet         = ' ',
    Struct          = " ",
    Text            = ' ',
    TypeParameter   = ' ',
    Unit            = ' ',
    Value           = ' ',
    Variable        = ' ',
    Copilot         = ' ',

    --         
    --         
    --   
    --   
    --  
    --  
    --  
    --  
    --  
    --  
    --  
    --  
}

return M

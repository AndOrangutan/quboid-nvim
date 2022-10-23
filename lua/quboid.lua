local G = vim.g

G.quboid_border = 'solid'
G.quboid_ft_exclude = { 'fzf', 'vim', 'alpha', 'neo-tree'}
G.quboid_ft_html = {'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'rescript', 'xml', 'php', 'markdown', 'glimmer','handlebars','hbs'}
G.quboid_ft_js = { 'typescript', 'typescriptreact', 'javashript' }
G.quboid_ft_marktex = { 'tex', 'latex', 'markdown'}
G.quboid_icons = {
    -- LSP
    Error           = ' ',
    Warn            = ' ',
    Hint            = ' ',
    Info            = ' ',

    -- Notify
    Debug           = ' ',
    Trace           = ' ',

    -- Luasnip
    ChoiceNode      = ' ',
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
    File            = ' ',
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

}

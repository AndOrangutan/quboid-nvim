local M                = {}

M.background           = 'dark'
M.colorscheme          = 'onedark'

M.border               = 'solid'
M.border_float         = 'shadow'
M.indentsize           = 4
M.notebook_dir         = '~/Dropbox/Notebooks'

M.session_exclude_dirs = {
    M.notebook_dir,
}


M.lsp_ensure_installed = { -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
    -- 'awk_ls',
    'angularls',
    'als',
    'arduino_language_server',
    'asm_lsp',
    'azure_pipelines_ls',
    'bashls',
    -- 'pkgbuild_language_server',
    'clangd',
    'omnisharp',
    'neocmake',
    'cssls',
    'clojure_lsp',
    -- 'denols',
    'dockerls',
    'docker_compose_language_service',
    'eslint',
    'elixirls',
    'fennel_language_server',
    'fortls',
    'gopls',
    'golangci_lint_ls',
    'templ',
    'gradle_ls',
    'graphql',
    'html',
    'emmet_language_server',
    'jsonls',
    'jdtls',
    'tsserver',
    'kotlin_language_server',
    'ltex',
    'texlab',
    'lua_ls',
    'zk',
    'ltex',
    'matlab_ls',
    'mutt_ls',
    'intelephense',
    'powershell_es',
    'pyright',
    'pyre',
    'ruff_lsp',
    'ruby_ls',
    'rust_analyzer',
    'sqlls',
    'svelte',
    'verible',
    'taplo',
    'tailwindcss',
    'terraformls',
    'tflint',
    'unocss',
    'vimls',
    'vtsls',
    'lemminx',
    'yamlls',
    'zls'
}

M.none_ls_ensure_installed = {
    'eslint',
    'shellcheck',
    'actionlint',
    'checkstyle',
    'cmakelang',
    'cppcheck',
    'gdtoolkit',
    'ruff',
}

M.dashboard_header = {
    ' ▄▄▄▄▄▄▄▄         ▄▄                ▄▄▄        ▄▄ ',
    ' ██    ██         ██                ▀▀▀        ██ ',
    ' ██    ██ ██   ██ ██████▄ ▄██████▄ ████   ▄██████ ',
    ' ██    ██ ██   ██ ██   ██ ██    ██   ██   ██   ██ ',
    ' ██    ██ ██   ██ ██   ██ ██    ██   ██   ██   ██ ',
    ' ██▄▄▄██▀ ██▄▄▄██ ██▄▄▄██ ██▄▄▄▄██ ▄▄██▄▄ ██▄▄▄██ ',
    ' ▀▀▀▀▀▀▀█▄ ▀▀▀ ▀▀ ▀▀▀▀▀▀   ▀▀▀▀▀▀  ▀▀▀▀▀▀  ▀▀▀▀▀▀ ',
    '        ▄▄▄   ▄▄            ▄▄▄                   ',
    '        ███   ██            ▀▀▀                   ',
    '        ████  ██ ██     ██ ████   ████▄███        ',
    '        ██ ██ ██ ▀██   ██▀   ██   ██ ██ ██        ',
    '        ██  ████  ██▄ ▄██    ██   ██ ██ ██        ',
    '        ██   ███   ██▄██   ▄▄██▄▄ ██ ██ ██        ',
    '        ▀▀   ▀▀▀    ▀▀▀    ▀▀▀▀▀▀ ▀▀ ▀▀ ▀▀        ',
}

M.dashboard_footer = {
    ' ▄  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    ' ███▄▄ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
    '  ███⠀▀▀▄ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
    ' ⠀ ██⠀⠀⠀ ▀▀▄ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀▄▄ ',
    ' ⠀⠀ █⠀⠀⠀⠀⠀⠀ ▀▀▄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ▄▄▄▄███▀ ',
    ' ⠀⠀⠀▀█⠀⠀⠀⠀⠀⠀⠀⠀▀▄▄ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ▄▄▄▀▀▀ ⠀⠀███ ⠀ ',
    ' ⠀⠀⠀⠀▀▄⠀⠀⠀⠀⠀⠀⠀⠀⠀ ▀▄ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ▄▄▄▀▀ ⠀⠀⠀⠀⠀⠀⠀▄██ ⠀⠀ ',
    ' ⠀⠀⠀⠀⠀▀▄ ⠀⠀⠀⠀⠀⠀⠀⠀⠀ ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▄▄▀▀▀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ █▀ ⠀⠀⠀ ',
    ' ⠀⠀⠀⠀⠀⠀ █ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ █ ⠀⠀⠀⠀⠀ ',
    ' ⠀⠀⠀⠀⠀⠀⠀⠀▀▄ ▄▀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀▄▀▀⠀⠀⠀⠀⠀⠀⠀ ',
    ' ⠀⠀⠀⠀⠀⠀⠀⠀⠀ ██ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀▄ ⠀⠀▄█▀ ⠀⠀⠀⠀⠀⠀⠀⠀ ',
    ' ⠀⠀⠀⠀⠀⠀⠀⠀ █ ⠀⠀⠀⠀▄▄▄ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀▀▄▄▀▀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
    ' ⠀⠀⠀⠀⠀⠀⠀ █ ⠀⠀⠀⠀█▀ ██⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀▄█▀█▄⠀⠀⠀⠀⠀⠀▀▄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
    ' ⠀⠀⠀⠀⠀⠀⠀█ ⠀⠀⠀⠀⠀▀███▀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀█▄▄██⠀⠀⠀⠀⠀⠀⠀▀▄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
    ' ⠀⠀⠀⠀⠀⠀█ ⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⠀▄▄▄⠀⠀⠀⠀⠀⠀ ▀▀▀ ⠀⠀⠀⠀⠀⠀⠀ █⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
    ' ⠀⠀⠀⠀⠀█  ▄██▄▄⠀⠀⠀⠀⠀⠀⠀⠀⠀▀▀▀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⠀⠀⠀▀▄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
    ' ⠀⠀⠀⠀⠀█ ██████ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀▄████▄ ⠀⠀ █⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
    ' ⠀⠀⠀⠀⠀▀▄ ▀██▀ ⠀⠀⠀⠀⠀⠀⠀ ▄█▀▀▀▀▄⠀⠀⠀⠀⠀⠀ ███████⠀⠀⠀█⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
    ' ⠀⠀⠀⠀⠀⠀█ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ █⠀⠀⠀⠀⠀█⠀⠀⠀⠀⠀⠀⠀▀████▀⠀⠀⠀⠀█ ⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
    ' ⠀⠀⠀⠀⠀⠀ █ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ▀▄▄▄▄▀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ █⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
    '                                                          ',
}

M.dashboard_quotes = {
    'I Can Fix Her...',
}
return M

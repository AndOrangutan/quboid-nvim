return {
    { 'nvim-treesitter/nvim-treesitter',
        dependencies = {
        },
        opts = {
            ensure_installed = 'all',
            auto_install = true,
            highlight = {
                enable = true,
                -- additional_vim_regex_highlighting = { "markdown" },
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },

            -- Extensions
        },
        build = ':TSUpdate',
    }
}

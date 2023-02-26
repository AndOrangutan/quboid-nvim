require("mason-null-ls").setup({
    ensure_installed = {
        "black",
        "eslint",
        "prettierd",
        "flake8",
        "stylua",
        'pmd',
    },
    automatic_installation = true,
})

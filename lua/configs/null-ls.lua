local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,

        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.completion.spell,

        null_ls.builtins.formatting.google_java_format,
        null_ls.builtins.diagnostics.pmd.with({
            extra_args = {
                "--rulesets",
                "category/java/bestpractices.xml,category/jsp/bestpractices.xml" -- or path to self-written ruleset
            },
        }),

        null_ls.builtins.hover.dictionary,

        null_ls.builtins.hover.printenv,

        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.formatting.black,

        null_ls.builtins.code_actions.eslint,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.formatting.eslint,
    },
})


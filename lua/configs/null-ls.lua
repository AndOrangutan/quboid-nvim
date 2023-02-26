local null_ls = require("null-ls")

local typescript_ok, typescript = pcall(require, "typescript")



null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,

        --TODO: setup similar funcitonality with <leader>g_
        -- null_ls.builtins.code_actions.gitsigns.with({
        --     config = {
        --         -- filter_actions = function(title)
        --         --     local gitsign_block_list = {
        --         --         'preview husk',
        --         --     }
        --         --
        --         --     for i, title_to_block in pairs(gitsign_block_list) do
        --         --         title = title:lower():match("preview husk")
        --         --     end
        --         --
        --         --     return title
        --         -- end
        --     }
        -- }),
        --

        null_ls.builtins.formatting.prettierd.with({
            condition = function (utils)
                return utils.has_file({ ".prettierrc.js" })
            end
        }),
        null_ls.builtins.completion.spell,

        null_ls.builtins.formatting.google_java_format,
        null_ls.builtins.diagnostics.pmd.with({
            extra_args = {
                "--rulesets",
                "category/java/bestpractices.xml,category/jsp/bestpractices.xml" -- or path to self-written ruleset
            },
        }),

        require("typescript.extensions.null-ls.code-actions"),

        null_ls.builtins.hover.dictionary,

        null_ls.builtins.hover.printenv,

        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.formatting.black,

    },
})


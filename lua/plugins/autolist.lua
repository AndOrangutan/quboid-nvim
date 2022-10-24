require('autolist').setup({
    create_enter_mapping = false,
    new_entry_on_o = true,
    list_cap = 50,
    colon = {
        indent_raw = true,
        indent = true,
        --preferred = "-"
    },
    invert = {
        mapping = "<c-r>",
        normal_mapping = "",
        toggles_checkbox = true,
        ul_marker = "-",
        ol_incrementable = "1",
        ol_delim = ".",
    },
    lists = {
        preloaded = {
            generic = {
                "unordered",
                "digit",
                "ascii",
            },
            latex = {
                "latex_item",
            },
        },
        filetypes = {
            generic = {
                "markdown",
                "text",
                "gitcommit",
                "scratch"
            },
            latex = {
                "tex",
                "plaintex",
            },
        },
    },
    recal_hooks = {
        "invert",
        "new",
    },
    checkbox = {
        left = "%[",
        right = "%]",
        fill = "x",
    },
})

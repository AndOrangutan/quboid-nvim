return {
    { 'zbirenbaum/copilot.lua',
        -- cmd = "Copilot",
        -- build = ":Copilot auth",
        config = function ()
            vim.defer_fn(function()

                require('copilot').setup({
                    suggestion = { enabled = false },
                    panel = { enabled = false },
                })

            end, 100)
        end,
    }
}

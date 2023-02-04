return {
    { 'zbirenbaum/copilot.lua',                        -- Fully featured & enhanced replacement for copilot.vim complete with API for interacting with Github Copilot
        cmd = "Copilot",
        event = "InsertEnter",
        config = function () require('configs.copilot') end,
    }
}

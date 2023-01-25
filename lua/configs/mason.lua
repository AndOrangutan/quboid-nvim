require("mason").setup({
    ui = {
        icons = {
            -- TODO: Extract icons to quboid.lua
            package_installed   = "✓",
            package_pending     = "➜",
            package_uninstalled = "✗"
        }
    }
})


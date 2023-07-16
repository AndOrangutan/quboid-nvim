
local luasnip = require('luasnip')

luasnip.config.set_config {
    history = true,
    delete_check_events = "TextChanged",

}
require('luasnip.loaders.from_vscode').lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()

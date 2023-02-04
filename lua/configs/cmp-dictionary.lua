
require('cmp_dictionary').setup ({
    document = true,
    -- WARN: uses `wordnet-cli`
    document_command = 'wn %s -over',
    -- debug = true,
    async = true,
})



local dict = require("cmp_dictionary")
dict.switcher({
    -- ["*"] = "/usr/share/dict/words",
    filetype = {
        markdown = "/usr/share/dict/words",
        -- javascript = { "/path/to/js.dict", "/path/to/js2.dict" },
    },
    -- filepath = {
    --     [".*xmake.lua"] = { "/path/to/xmake.dict", "/path/to/lua.dict" }
    --     ["%.tmux.*%.conf"] = { "/path/to/js.dict", "/path/to/js2.dict" },
    -- },
    spelllang = {
        en = '/usr/share/dict/words',
    },
})
-- require("cmp_dictionary").update()

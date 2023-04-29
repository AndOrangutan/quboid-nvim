return {
    { 'luukvbaal/statuscol.nvim',               -- Status column plugin that provides a configurable 'statuscolumn' and click handlers. 
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                foldfunc = "builtin",
                setopt = true,
                thousands = false,
                relculright = true,
                segments = {
                    { text = { "%s" }, click = "v:lua.ScSa" },
                    { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
                    {
                        text = { builtin.foldfunc, " " },
                        condition = { builtin.not_empty, true, builtin.not_empty },
                        click = "v:lua.ScFa"
                    },
                }
            })
        end
    }

}

return {
    { 'luukvbaal/statuscol.nvim',               -- Status column plugin that provides a configurable 'statuscolumn' and click handlers. 
        config = function()
            require("statuscol").setup({
                foldfunc = "builtin",
                setopt = true,
                thousands = false,
                relculright = true,
            })
        end
    }

}

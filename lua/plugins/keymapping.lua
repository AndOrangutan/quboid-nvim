return {
    { 'folke/which-key.nvim',                           -- Neovim plugin that shows a popup with possible keybindings of the command you started typing.
        dependencies = {
            'mrjones2014/legendary.nvim',                   -- Define your keymaps, commands, and autocommands as simple Lua tables, and create a legend for them at the same time, integrates with which-key.nvim.
            config = true,
        },
    },
}

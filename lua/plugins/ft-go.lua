return {
    { 'ray-x/go.nvim',
        dependencies = {  -- optional packages
            'ray-x/guihua.lua',
            'neovim/nvim-lspconfig',
            'nvim-treesitter/nvim-treesitter',
        },
        config = function()

            require('go').setup({
                notify = false,
                lsp_cfg = false,
            })
        end,
        event = {'CmdlineEnter'},
        ft = require('quboid').ft_go,
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    }
}

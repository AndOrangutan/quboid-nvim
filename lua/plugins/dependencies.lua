return {
    { 'DaikyXendo/nvim-material-icon',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function ()

            local web_devicons_ok, web_devicons = pcall(require, 'nvim-web-devicons')
            if not web_devicons_ok then return end

            local material_icon_ok, material_icon = pcall(require, 'nvim-material-icon')
            if not material_icon_ok then return end

            web_devicons.setup({
                override = material_icon.get_icons(),
            })

            material_icon.setup()

        end,
    },
}

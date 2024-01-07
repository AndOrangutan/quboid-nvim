return {
    { '3rd/image.nvim',
        config = function ()
            -- Example for configuring Neovim to load user-installed installed Lua rocks:
            package.path = package.path .. ';' .. vim.fn.expand('$HOME') .. '/.luarocks/share/lua/5.1/?/init.lua;'
            package.path = package.path .. ";" .. vim.fn.expand('$HOME') .. '/.luarocks/share/lua/5.1/?.lua;'

            require("image").setup({
                backend = 'kitty',
                integrations = {
                    markdown = {
                        clear_in_insert_mode = false,
                        only_render_image_at_cursor = true,
                        filetypes = { 'markdown', 'vimwiki' }
                    }
                },
                max_width = 80
            })
        end,
    }
}

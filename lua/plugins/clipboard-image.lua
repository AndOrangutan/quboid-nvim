require('clipboard-image').setup({
    markdown = {
        img_dir = { '%:p:h' },
        img_dir_txt = '',
        img_name = function ()
            return vim.fn.expand('%:t:r')..'-'..os.date('%Y-%m-%d-%H-%M-%S')
        end,
        img_handler = function (img)
            -- Add in alt text
            vim.cmd('normal! f[') -- go vo [
            vim.cmd('normal! a' .. vim.fn.input('Alt-text: ')) -- append text with image name

            -- Compress image
            --local script = string.format('~/.scripts/tinypng.sh -s f %s &', img.path)
            --return os.execute(script)
        end,
        affix = '![](%s)',
    }
})


    vim.keymap.set('n', '<F12>f', '<cmd>exe ":silent !firefox % &"<cr>', { desc = 'Open current file in Firefox' })
    vim.keymap.set('n', '<F12>c', '<cmd>exe ":silent !chromium % &"<cr>', { desc = 'Open current file in Chromium' })

    vim.keymap.set('n', 'Q', function ()
        local write_ok, write = pcall(vim.api.nvim_command, 'write')
        if not write_ok then
            local confirm_val = vim.fn.confirm("Buffer couldn't write, CLOSE ANYWAY?", "&No\n&Yes")
            if 1 == confirm_val then
                return
            elseif 2 == confirm_val then
                vim.api.nvim_command('bdelete')
            end
        else
            vim.api.nvim_command('bdelete')
        end
        --vim.api.nvim_command('write')

    end, { desc = 'Save and Close Buffer' })

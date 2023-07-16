local quboid = require('quboid')
local util = require('util')

return {
    -- { 'gaoDean/autolist.nvim',
    --     config = function () 
    --         local autolist = require("autolist")
    --         autolist.setup()
    --         autolist.create_mapping_hook("i", "<CR>", autolist.new)
    --         autolist.create_mapping_hook("i", "<Tab>", autolist.indent)
    --         autolist.create_mapping_hook("i", "<S-Tab>", autolist.indent, "<C-D>")
    --         -- autolist.create_mapping_hook("n", "o", autolist.new)
    --         -- autolist.create_mapping_hook("n", "O", autolist.new_before)
    --         autolist.create_mapping_hook("n", ">>", autolist.indent)
    --         autolist.create_mapping_hook("n", "<<", autolist.indent)
    --         autolist.create_mapping_hook("n", "<C-r>", autolist.force_recalculate)
    --         autolist.create_mapping_hook("n", "<leader>x", autolist.invert_entry, "")
    --     end,
    --     ft = quboid.ft_marktex,
    -- },
    { 'postfen/clipboard-image.nvim',
    -- { 'ekickx/clipboard-image.nvim',
        config = function () require('configs.clipboard-image') end,
        -- ft = quboid.ft_marktex,
        branch = 'patch-1',
    },
    { 'NFrid/due.nvim',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        config = function()
            require('due_nvim').setup({
                prescript = '  due in ',             -- prescript to due data
                use_clock_time = true,         -- display also hours and minutes
                use_clock_today = true,        -- do it instead of TODAY
                use_seconds = true,            -- if use_clock_time == true, display seconds
            })
        end,
        ft = quboid.ft_marktex,
    },
    { 'AckslD/nvim-FeMaco.lua',
        config = function () require('configs.femaco') end,
        ft = quboid.ft_marktex,
    },
    { 'lukas-reineke/headlines.nvim',
        config = function () require('configs.headlines') end,
        ft = quboid.ft_marktex
    },
    { 'preservim/vim-markdown',
        init = function()
            vim.g.vim_markdown_folding_disabled = 1
            vim.g.vim_markdown_conceal_code_blocks = 0
            vim.g.vim_markdown_math = 1
            vim.g.vim_markdown_frontmatter = 1
            vim.g.vim_markdown_strikethrough = 1
            vim.g.vim_markdown_new_list_item_indent = 0
            vim.g.vim_markdown_auto_insert_bullets = 0
        end,
        ft = quboid.ft_marktex,
    },
    { 'iamcco/markdown-preview.nvim',
        init = function()
            vim.g.mkdp_auto_start = 0
            vim.g.mkdp_auto_close = 1
            vim.g.mkdp_browser = 'electron'
            vim.g.mkdp_echo_preview_url = 1
            vim.g.mkdp_theme = 'light'
        end,
        build = "cd app && yarn install",
        ft = quboid.ft_marktex,
    },
    { 'jmbuhr/otter.nvim',
        config = function () require('otter').dev_setup({}) 
            otter = require'otter'

            vim.api.nvim_create_autocmd({ "BufEnter" }, {
                pattern = { "*.md" },
                callback = function()
                    otter.activate({ 'r', 'python', 'lua' }, true)
                    vim.api.nvim_buf_set_keymap(0, 'n', 'gd', ":lua require'otter'.ask_definition()<cr>", { silent = true })
                    vim.api.nvim_buf_set_keymap(0, 'n', 'K', ":lua require'otter'.ask_hover()<cr>", { silent = true })
                end,
})
        end,
        dependencies = {
            'hrsh7th/nvim-cmp',
            'neovim/nvim-lspconfig',
            'nvim-treesitter/nvim-treesitter'
        },
    },
    { 'dhruvasagar/vim-table-mode',
        init = function()
            vim.g.table_mode_corner_corner = '|'
            vim.g.table_mode_enable = false
            util.keymap('<leader><bar><bar>', function ()
                if vim.g.vim_table_mode_enabled == false then
                    vim.g.vim_table_mode_enabled = true
                    vim.cmd[[TableModeEnable]]
                    vim.notify('Table Mode Enabled')
                elseif vim.g.vim_table_mode_enabled == true then
                    vim.g.vim_table_mode_enabled = false
                    vim.cmd[[TableModeDisable]]
                    vim.notify('Table Mode Disabled')
                end
            end, 'Table Mode Toggle')
        end,
        ft = quboid.ft_marktex,
    },
    { 'mickael-menu/zk-nvim',
        dependencies = {
            'junegunn/fzf',
        },
        config = function () require('configs.zk') end,
    }
 }

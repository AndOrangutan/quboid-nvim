return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            {
                'ofirgall/goto-breakpoints.nvim',
                keys = {
                    { ']b', function() require('goto-breakpoints').next() end,    desc = 'DAP Next [b]reakpoint' },
                    { '[b', function() require('goto-breakpoints').prev() end,    desc = 'DAP Previous [b]reakpoint' },
                    { ']S', function() require('goto-breakpoints').stopped() end, desc = 'DAP Goto Stopped' },
                },
            },
            {
                'theHamsta/nvim-dap-virtual-text',
                dependencies = {
                    'nvim-treesitter/nvim-treesitter',
                },
                config = true,
            },
            {
                'LiadOz/nvim-dap-repl-highlights',
                dependencies = 'nvim-treesitter/nvim-treesitter',
                config = function()
                    require('nvim-dap-repl-highlights').setup()
                end,
            }
        },
        config = function()
            local dap = require('dap')
            dap.set_log_level('INFO')

            vim.fn.sign_define('DapBreakpoint',
                { text = require('quboid').icons.circle, texthl = 'DiagnosticError', linehl = '', numhl = '' })
            vim.fn.sign_define('DapStopped',
                { text = require('quboid').icons.circle, texthl = 'DiagnosticError', linehl = '', numhl = '' })

            require('dap_cfg')
        end,
        keys = {
            { '<F5>',        function() require('dap').continue() end,          desc = '[d]AP [c]ontinue' },
            { '<F10>',       function() require('dap').step_over() end,         desc = '[d]AP [s]tep [o]ver' },
            { '<F11>',       function() require('dap').step_in() end,           desc = '[d]AP [s]tep [i]n' },
            { '<F12>',       function() require('dap').step_out() end,          desc = '[d]AP [s]tep O[u]t' },
            { '<leader>db',  function() require('dap').toggle_breakpoint() end, desc = '[d]AP [b]reakpoint Toggle' },
            { '<leader>dc',  function() require('dap').continue() end,          desc = '[d]AP [c]ontinue' },
            { '<leader>dso', function() require('dap').step_over() end,         desc = '[d]AP [s]tep [o]ver' },
            { '<leader>dsi', function() require('dap').step_in() end,           desc = '[d]AP [s]tep [i]n' },
            { '<leader>dsu', function() require('dap').step_out() end,          desc = '[d]AP [s]tep O[u]t' },
            {
                '<leader>dC',
                function()
                    require('dap').clear_breakpoints()
                    vim.notify('Cleared all breakpoints', vim.log.levels.INFO, { title = 'DAP' })
                end,
                desc = '[d]AP [b]reakpoint Toggle'
            },
            {
                '<leader>dt',
                function()
                    require('dap').terminate()
                end,
                desc = '[d]AP [t]erminate'
            },
        }
    },
    {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = {
            'williamboman/mason.nvim',
            'mfussenegger/nvim-dap',
        },
        config = function()
            require('mason-nvim-dap').setup({
                automatic_installation = true,
            })
        end,
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap',
        },
        config = function()
            local dapui = require('dapui')
            local dap = require('dap')

            dapui.setup({
                icons = { expanded = '▾', collapsed = '▸' },
                mappings = {
                    open = 'o',
                    remove = 'd',
                    edit = 'e',
                    repl = 'r',
                    toggle = 't',
                },
                floating = {
                    border = require('quboid').border,
                    mappings = {
                        close = { 'q', '<Esc>' },
                    },
                },
            })


            -- Auto open and close ui
            dap.listeners.after.event_initialized['dapui_config'] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated['dapui_config'] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited['dapui_config'] = function()
                dapui.close()
            end
        end,
        keys = {
            { '<leader>du', function() require('dapui').toggle({}) end, desc = '[d]ap [u]i Toggle' },
            { '<leader>de', function() require('dapui').eval() end,     desc = '[d]ap [E]val',     mode = { 'n', 'v' } },
            {
                '<leader>dx',
                function()
                    require('dapui').close()
                    require('dapui').close()
                    require('dap').clear_breakpoints()
                    require('dap').terminate()
                end,
                desc = '[d]ap [E]val',
                mode = { 'n', 'v' }
            },
        },
    },
}

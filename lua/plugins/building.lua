return {
    'stevearc/overseer.nvim',
    dependencies = {
        'mfussenegger/nvim-dap',
    },
    keys = {
        { '<c-s-b>',    '<cmd>OverseerRun<cr>',    desc = 'Overseer [b]uild run' },
        { '<leader>bb', '<cmd>OverseerToggle<cr>', desc = 'Overseer [b]uffer [b]uild Toggle' },
    },
    config = function()
        require('dap.ext.vscode').json_decode = require('overseer.json').decode

        -- :Make similar to dispatch
        vim.api.nvim_create_user_command('Make', function(params)
            -- Insert args at the '$*' in the makeprg
            local cmd, num_subs = vim.o.makeprg:gsub('%$%*', params.args)
            if num_subs == 0 then
                cmd = cmd .. ' ' .. params.args
            end
            local task = require('overseer').new_task({
                cmd = vim.fn.expandcmd(cmd),
                components = {
                    { 'on_output_quickfix', open = not params.bang, open_height = 8 },
                    'default',
                },
            })
            task:start()
        end, {
            desc = 'Run your makeprg as an Overseer task',
            nargs = '*',
            bang = true,
        })

        require('overseer').setup({
            component_aliases = {
                default = {
                    { 'display_duration', detail_level = 2 },
                    'on_output_summarize',
                    'on_exit_set_status',
                    'on_complete_notify',
                    'on_complete_dispose',
                },
                default_neotest = {
                    'on_output_summarize',
                    'on_exit_set_status',
                    'on_complete_notify',
                    'on_complete_dispose',
                },
            }
        })
    end,
}

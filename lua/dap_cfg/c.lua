local dap = require('dap')

dap.adapters.lldb = {
    type = 'executable',
    -- absolute path is important here, otherwise the argument in the `runInTerminal` request will default to $CWD/lldb-vscode
    command = '/usr/bin/lldb-vscode',
    name = 'lldb',
    host = '127.0.0.1',
    port = 13000,
}
dap.configurations.c = {
    {
        showDisassembly = 'never',
        cwd = function()
            return vim.fn.input('Directory to execute in: ', vim.fn.getcwd() .. '/', 'file')
        end,
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        port = '${port}',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
    },
}

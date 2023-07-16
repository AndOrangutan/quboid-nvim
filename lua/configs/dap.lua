local util = require('util')

local dap = require('dap')
local dapui = require('dapui')

local dap_breakpoint = {
    error = {
        text = ' ',
        texthl = "LspDiagnosticsSignError",
        linehl = "",
        numhl = "",
    },
    rejected = {
        text = " ",
        texthl = "LspDiagnosticsSignHint",
        linehl = "",
        numhl = "",
    },
    stopped = {
        text = "⭐️",
        texthl = "LspDiagnosticsSignInformation",
        linehl = "DiagnosticUnderlineInfo",
        numhl = "LspDiagnosticsSignInformation",
    },
}

vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)


-- Setup extensions

require("nvim-dap-virtual-text").setup ({
    commented = true,
})

dapui.setup({})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

-- Local Debuggers
require('configs.dap.java')
require('configs.dap.python')
require('configs.dap.lua')

-- Keybindings
util.keymap('n', '<leader>d<space>', function () require('dap').continue() end, '[d]AP Continue/Start')
util.keymap('n', '<leader>dd', function () require('dap').toggle_breakpoint() end, '[d]AP Toggle Breakpoint')

util.keymap('n', '<leader>de', function () require('dapui').eval() end, '[d]AP [e]valuate Under Cursor')
util.keymap('n', '<leader>de', function()
    vim.ui.input({ prompt = 'Expression to Eval: ' }, function(input)
        require('dapui').eval(input) 
    end)
end, '[d]AP [E]valuate w/ input')

util.keymap('n', '<leader>dh', function () require('dap').step_out() end, '[d]AP Step Out  ')
util.keymap('n', '<F1>', function () require('dap').step_out() end, '[d]AP Step Out  ')
util.keymap('n', '<leader>dj', function () require('dap').step_over() end, '[d]AP Step Over  ')
util.keymap('n', '<F2>', function () require('dap').step_over() end, '[d]AP Step Over  ')
util.keymap('n', '<leader>dl', function () require('dap').step_into() end, '[d]AP Step Into  ')
util.keymap('n', '<F3>', function () require('dap').step_into() end, '[d]AP Step Into  ')

util.keymap('n', '<leader>dz', '<cmd>ZoomWinTabToggle<cr>', '[d]AP Zoom Tab Toggle')

util.keymap('n', '<leader>dr', function () require('dap').repl_open() end, '[d]AP [r]EPL Toggle')
util.keymap('n', '<leader>dR', function () require('dap').run_to_cursor() end, '[d]AP [R]un to Cursor')

util.keymap('n', '<leader>du', function () require('dapui').toggle() end, '[d]AP Toggle [u]i')

util.keymap('n', '<leader>dk', function () require('dap.ui.widgets').hover() end, '[d]AP Hover Variable')
util.keymap('n', '<leader>ds', function () require('dap.ui.widgets').scopes() end, '[d]AP [s]copes')

util.keymap('n', '<leader>dgs', function () require('dap').session() end, '[d]AP [g]et [s]ession')


util.keymap( "n", "<leader>dp", function() require("dap").pause_toggle() end, '[d]AP Restart')
util.keymap( "n", "<leader>d-", function() require("dap").restart() end, '[d]AP Restart')
util.keymap( "n", "<leader>d_", function() require("dap").terminate() require("dapui").close() end, '[d]AP Close')
vim.keymap.set(
    "n",
    "<leader>dgt",  -- dg as in debu[g] [t]race
    ":lua require('dap').set_log_level('TRACE')<CR>"
)
vim.keymap.set(
    "n",
    "<leader>dge",  -- dg as in debu[g] [e]dit
    function()
        vim.cmd(":edit " .. vim.fn.stdpath('cache') .. "/dap.log")
    end
)
vim.keymap.set("n", "<F1>", ":DapStepOut<CR>")
vim.keymap.set("n", "<F2>", ":DapStepOver<CR>")
vim.keymap.set("n", "<F3>", ":DapStepInto<CR>")

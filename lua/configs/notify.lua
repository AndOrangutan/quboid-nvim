
notify = require('notify')

local quboid = require('quboid')

-- Overide default notification handler
vim.notify = notify

notify.setup({
    background_colour = "NormalFloat",
    fps = 30,
    icons = {
        DEBUG  = quboid.quboid_icons['Debug'],
        ERROR   = quboid.quboid_icons['Error'],
        INFO    = quboid.quboid_icons['Info'],
        TRACE   = quboid.quboid_icons['Trace'],
        WARN    = quboid.quboid_icons['Warn'],
    },
    level = "info",
    render = "default",
    stages = "fade_in_slide_out",
    timeout = 4000, -- from 5000
    on_open = function(win)
        vim.api.nvim_win_set_config(win, { border = quboid.quboid_border_float })
    end,
})


--local spinner_frames = {"⢀⠀","⡀⠀","⠄⠀","⢂⠀","⡂⠀","⠅⠀","⢃⠀","⡃⠀","⠍⠀","⢋⠀","⡋⠀","⠍⠁","⢋⠁","⡋⠁","⠍⠉","⠋⠉","⠋⠉","⠉⠙","⠉⠙","⠉⠩","⠈⢙","⠈⡙","⢈⠩","⡀⢙","⠄⡙","⢂⠩","⡂⢘","⠅⡘","⢃⠨","⡃⢐","⠍⡐","⢋⠠","⡋⢀","⠍⡁","⢋⠁","⡋⠁","⠍⠉","⠋⠉","⠋⠉","⠉⠙","⠉⠙","⠉⠩","⠈⢙","⠈⡙","⠈⠩","⠀⢙","⠀⡙","⠀⠩","⠀⢘","⠀⡘","⠀⠨","⠀⢐","⠀⡐","⠀⠠","⠀⢀", "⠀⡀"}
-- TODO: Add in other funcitonality
--

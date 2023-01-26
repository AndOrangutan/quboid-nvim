
notify = require('notify')

local G = vim.g

-- Overide default notification handler
vim.notify = notify

notify.setup({
    background_colour = "NormalFloat",
    fps = 30,
    icons = {
        DEBUG   = G.quboid_icons['Debug'],
        ERROR   = G.quboid_icons['Error'],
        INFO    = G.quboid_icons['Info'],
        TRACE   = G.quboid_icons['Trace'],
        WARN    = G.quboid_icons['Warn'],
    },
    level = "info",
    render = "default",
    stages = "fade_in_slide_out",
    timeout = 4000, -- from 5000
    on_open = function(win)
        vim.api.nvim_win_set_config(win, { border = G.quboid_border_float })
    end,
})


--local spinner_frames = {"⢀⠀","⡀⠀","⠄⠀","⢂⠀","⡂⠀","⠅⠀","⢃⠀","⡃⠀","⠍⠀","⢋⠀","⡋⠀","⠍⠁","⢋⠁","⡋⠁","⠍⠉","⠋⠉","⠋⠉","⠉⠙","⠉⠙","⠉⠩","⠈⢙","⠈⡙","⢈⠩","⡀⢙","⠄⡙","⢂⠩","⡂⢘","⠅⡘","⢃⠨","⡃⢐","⠍⡐","⢋⠠","⡋⢀","⠍⡁","⢋⠁","⡋⠁","⠍⠉","⠋⠉","⠋⠉","⠉⠙","⠉⠙","⠉⠩","⠈⢙","⠈⡙","⠈⠩","⠀⢙","⠀⡙","⠀⠩","⠀⢘","⠀⡘","⠀⠨","⠀⢐","⠀⡐","⠀⠠","⠀⢀", "⠀⡀"}
-- TODO: Add in other funcitonality 

local quboid = require('quboid')

local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')

math.randomseed(os.time())

local function pick_color()
    local colors = {"String", "Identifier", "Keyword", "Constant", "Statement", "Type"}
    return colors[math.random(#colors)]
end

local function pad_to_width(str, wid_to_match)
    local add_pad = (wid_to_match - #str) / 2
    return string.rep(" ", add_pad) .. str .. string.rep(" ", add_pad)
end

local function header()
    return quboid.dashboard_header
end

local function footer()
    local version = vim.version()
    local stats = require('lazy').stats()

    local footer = quboid.dashboard_footer
    local w = quboid.dashboard_width

    local date = os.date('%A, %b %d, %Y')
    local version = string.format("v%d.%d.%d", version.major, version.minor, version.patch)
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

    local details1 = quboid.icons.Calendar .. ' ' .. date .. '  ' .. quboid.icons.Beaker .. ' ' .. version
    details1 = pad_to_width(details1, w)
    table.insert(footer, details1)

    local details2 = quboid.icons.Startup .. ' Loaded ' .. stats.count .. ' Plugins in ' .. ms .. 'ms'
    details2 = pad_to_width(details2, w)
    table.insert(footer, details2)


    -- return footer
    return footer
end



dashboard.section.buttons.val = {
    dashboard.button( "n", "  > Notebooks", [[:cd $HOME/Dropbox/Notebooks/ | :lua require'fzf-lua'.files({ cwd = "~/Dropbox/Notebooks", cmd = "fd -e md -g 'index.md'", actions = { ['default'] = _G.my_notebook_open }})<cr>]]),
    dashboard.button( "q", "  > Quit NVIM", "<cmd>qa<cr>"),
}


-- Subheader
dashboard.section.header.val = header()
-- dashboard.section.footer.val = footer()
dashboard.section.header.opts.hl = pick_color()
dashboard.section.footer.opts.hl = pick_color()

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)

vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
    dashboard.section.footer.val = footer()
        pcall(vim.cmd.AlphaRedraw)
    end,
})

local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')

local fzflua_ok, fzflua = pcall(require, 'fzf-lua')

-- TODO: Reqrite extracting apropriate variables to quboid.lua

math.randomseed(os.time())

local function pick_color()
    local colors = {"String", "Identifier", "Keyword", "Constant", "Statement", "Type"}
    return colors[math.random(#colors)]
end

local function header ()
    local banner = {

        '     ▄▄▄▄▄▄▄▄         ▄▄                ▄▄▄        ▄▄     ',
        '     ██    ██         ██                ▀▀▀        ██     ',
        '     ██    ██ ██   ██ ██████▄ ▄██████▄ ████   ▄██████     ',
        '     ██    ██ ██   ██ ██   ██ ██    ██   ██   ██   ██     ',
        '     ██    ██ ██   ██ ██   ██ ██    ██   ██   ██   ██     ',
        '     ██▄▄▄██▀ ██▄▄▄██ ██▄▄▄██ ██▄▄▄▄██ ▄▄██▄▄ ██▄▄▄██     ',
        '     ▀▀▀▀▀▀▀█▄ ▀▀▀ ▀▀ ▀▀▀▀▀▀   ▀▀▀▀▀▀  ▀▀▀▀▀▀  ▀▀▀▀▀▀     ',
        '            ▄▄▄   ▄▄            ▄▄▄                       ',
        '            ███   ██            ▀▀▀                       ',
        '            ████  ██ ██     ██ ████   ████▄███            ',
        '            ██ ██ ██ ▀██   ██▀   ██   ██ ██ ██            ',
        '            ██  ████  ██▄ ▄██    ██   ██ ██ ██            ',
        '            ██   ███   ██▄██   ▄▄██▄▄ ██ ██ ██            ',
        '            ▀▀   ▀▀▀    ▀▀▀    ▀▀▀▀▀▀ ▀▀ ▀▀ ▀▀            ',
    }

    return banner
end

local function footer ()
    local version = vim.version()

    -- local pluginsSub = string.format("  %d", #vim.tbl_keys(packer_plugins))
    -- local dateSub = os.date("  %A %d %b %Y")
    -- local versionSub = string.format("  v%d.%d.%d", version.major, version.minor, version.patch)
    --
    -- local length = 58
    --
    -- local infoSize = math.ceil((length - (#pluginsSub + #dateSub + #versionSub +2)) / 2)
    --
    -- local padding = ""
    --
    -- for i=1,infoSize do padding = padding.." " end
    --
    -- local subbanner = string.format('%s%s %s %s%s', padding, pluginsSub, dateSub, versionSub, padding)

    -- local pluginsSub = string.format("  %d", #vim.tbl_keys(packer_plugins))
    local dateSub = os.date("  %A %d %b %Y")
    local versionSub = string.format("  v%d.%d.%d", version.major, version.minor, version.patch)

    local length = 58

    local infoSize = math.ceil((length - (#dateSub + #versionSub +2)) / 2)

    local padding = ""

    for i=1,infoSize do padding = padding.." " end

    local subbanner = string.format('%s%s %s%s', padding, dateSub, versionSub, padding)

    local banner = {
        ' ▄  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
        ' ███▄▄ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
        '  ███⠀▀▀▄ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
        ' ⠀ ██⠀⠀⠀ ▀▀▄ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀▄▄ ',
        ' ⠀⠀ █⠀⠀⠀⠀⠀⠀ ▀▀▄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ▄▄▄▄███▀ ',
        ' ⠀⠀⠀▀█⠀⠀⠀⠀⠀⠀⠀⠀▀▄▄ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ▄▄▄▀▀▀ ⠀⠀███ ⠀ ',
        ' ⠀⠀⠀⠀▀▄⠀⠀⠀⠀⠀⠀⠀⠀⠀ ▀▄ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ▄▄▄▀▀ ⠀⠀⠀⠀⠀⠀⠀▄██ ⠀⠀ ',
        ' ⠀⠀⠀⠀⠀▀▄ ⠀⠀⠀⠀⠀⠀⠀⠀⠀ ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▄▄▀▀▀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ █▀ ⠀⠀⠀ ',
        ' ⠀⠀⠀⠀⠀⠀ █ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ █ ⠀⠀⠀⠀⠀ ',
        ' ⠀⠀⠀⠀⠀⠀⠀⠀▀▄ ▄▀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀▄▀▀⠀⠀⠀⠀⠀⠀⠀ ',
        ' ⠀⠀⠀⠀⠀⠀⠀⠀⠀ ██ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀▄ ⠀⠀▄█▀ ⠀⠀⠀⠀⠀⠀⠀⠀ ',
        ' ⠀⠀⠀⠀⠀⠀⠀⠀ █ ⠀⠀⠀⠀▄▄▄ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀▀▄▄▀▀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
        ' ⠀⠀⠀⠀⠀⠀⠀ █ ⠀⠀⠀⠀█▀ ██⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀▄█▀█▄⠀⠀⠀⠀⠀⠀▀▄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
        ' ⠀⠀⠀⠀⠀⠀⠀█ ⠀⠀⠀⠀⠀▀███▀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀█▄▄██⠀⠀⠀⠀⠀⠀⠀▀▄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
        ' ⠀⠀⠀⠀⠀⠀█ ⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⠀▄▄▄⠀⠀⠀⠀⠀⠀ ▀▀▀ ⠀⠀⠀⠀⠀⠀⠀ █⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
        ' ⠀⠀⠀⠀⠀█  ▄██▄▄⠀⠀⠀⠀⠀⠀⠀⠀⠀▀▀▀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⠀⠀⠀▀▄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
        ' ⠀⠀⠀⠀⠀█ ██████ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀▄████▄ ⠀⠀ █⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
        ' ⠀⠀⠀⠀⠀▀▄ ▀██▀ ⠀⠀⠀⠀⠀⠀⠀ ▄█▀▀▀▀▄⠀⠀⠀⠀⠀⠀ ███████⠀⠀⠀█⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
        ' ⠀⠀⠀⠀⠀⠀█ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ █⠀⠀⠀⠀⠀█⠀⠀⠀⠀⠀⠀⠀▀████▀⠀⠀⠀⠀█ ⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
        ' ⠀⠀⠀⠀⠀⠀ █ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ▀▄▄▄▄▀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ █⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
        '                                                          ',
        subbanner,
    }


    return banner
end

vim.g.my_notebook_open = function(selected, opts)
    -- 'selected[]' array contains the selected items

    local slctd = selected

    require'fzf-lua'.actions.file_edit(slctd, opts)

    --vim.cmd('!cd $(dirname '.. selected .. ')')
    --vim.notify('!echo $(dirname '.. selected .. ')', "error")
    vim.cmd("TZMinimalist")
    -- Let zk lsp load
    vim.wait(200)
    vim.cmd[[ZkCd]]

end


dashboard.section.buttons.val = {
    --dashboard.button( "e", "   > New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "r", "  > Recent"   , ":FzfLua oldfiles<CR>"),
    dashboard.button( "s", "  > Sessions" , ":SessionManager load_session<cr>"),
    --dashboard.button( "n", "   > Notebooks", ":cd $HOME/Dropbox/Notebook | :e index.md <CR> | :TZMinimalist <CR>"),
    --dashboard.button( "n", "   > Notebooks", [[:lua require("fzf-lua").files({ cwd = "~/Dropbox/Notebooks"})<cr> | :ZkCd<cr> | :TZMinimalist <CR>]]),
    --dashboard.button( "n", "   > Notebooks", [[:lua require'fzf-lua'.files({ cwd = "~/Dropbox/Notebooks", cmd = "fd -e md -g 'index.md'"})<cr>]]),
    --dashboard.button( "n", "  > Notebooks", [[:cd $HOME/Dropbox/Notebooks/ | :lua require'fzf-lua'.files({ cwd = "~/Dropbox/Notebooks", cmd = "fd -e md -g 'index.md'", actions = { ['default'] = _G.my_notebook_open }})<cr>]]),
    dashboard.button( "n", "  > Notebook", [[:cd $HOME/Dropbox/Notebooks/Compendium | :e index.md | :ZkCd <cr>]]),
    dashboard.button( "o", "  > Notebook Old", [[:cd $HOME/Dropbox/Notebooks/Compendium_Old | :e index.md | :ZkCd <cr>]]),
    --dashboard.button( "n", "   > Notebooks", [[:cd $HOME/Dropbox/Notebooks/Compendium | :e index.md <CR> | :ZkCd | :TZMinimalist <CR>]]),
    -- TODO: make the require here safe
    dashboard.button( "S", "  > Settings" , ":cd $HOME/.config/nvim | lua require'fzf-lua'.files()<cr>"),
    dashboard.button( "q", "  > Quit NVIM", ":qa<CR>"),
}


-- Subheader
dashboard.section.header.val = header()
dashboard.section.footer.val = footer()
dashboard.section.header.opts.hl = pick_color()
dashboard.section.footer.opts.hl = pick_color()

alpha.setup(dashboard.opts)

return {
    {
        'stevearc/dressing.nvim',
        opts = {
            input = {
                enabled = true,
                title_pos = 'center',
                border = require('quboid').border_float,
            },
            select = {
                enabled = true,
                -- Priority list of preferred vim.select implementations
                -- backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
                fzf_lua = {
                    prompt   = '❯ ',
                    winopts = {
                        height     = 0.30,
                        width      = 1.00,
                        row        = 1,
                        col        = 0.50,
                    },
                }

            },
        },
    },
    {
        'ibhagwan/fzf-lua',
        -- optional for icon support
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = { 'BufReadPre', 'BufNewFile', 'BufEnter' },
        config = function()
            local actions = require('fzf-lua.actions')
            local quboid = require('quboid')
            local icons = require('quboid.icons')

            -- calling `setup` is optional for customization
            require('fzf-lua').setup({
                hls = {
                    normal = 'NormalFloat',
                    border = 'NormalFloat',
                    title = 'NormalFloat',
                    previewBorder = 'NormalFloat',
                    previewNormal = 'Normal',
                    cursor = 'Normal',
                    cursorLine = 'Normal',
                },
                -- fzf_bin         = 'sk',            -- use skim instead of fzf?
                -- https://github.com/lotabout/skim
                -- can also be set to 'fzf-tmux'
                winopts           = {
                    height     = 0.85,
                    width      = 0.90,
                    row        = 0.50,
                    col        = 0.50,
                    border     = quboid.border,
                    hl         = {
                        normal     = 'Normal', -- window normal color (fg+bg)
                        border     = 'Normal', -- border color (try 'FloatBorder')
                        -- Only valid with the builtin previewer:
                        cursor     = 'Normal', -- cursor highlight (grep/LSP matches)
                        cursorline = 'Normal', -- cursor line
                        cursorlinenr = 'Normal', -- cursor line
                        search     = 'Search', -- search matches (ctags)
                        title      = 'NormalBorder', -- preview border title (file/buffer)
                    },
                    fullscreen = false,      -- start fullscreen?
                    preview    = {
                        -- applies only when scrollbar = 'float'
                        scrollchars = { '█', '' }, -- scrollbar chars ({ <full>, <empty> }
                        -- applies only when scrollbar = 'border'
                        delay       = 100, -- delay(ms) displaying the preview
                        -- prevents lag on fast scrolling
                        winopts     = { -- builtin previewer window options
                            number         = false,
                            relativenumber = false,
                            cursorline     = false,
                            cursorlineopt  = 'both',
                            cursorcolumn   = false,
                            signcolumn     = 'no',
                            list           = false,
                            foldenable     = false,
                            foldmethod     = 'manual',
                        },
                    },
                    on_create  = function()
                        -- called once upon creation of the fzf main window
                        -- can be used to add custom fzf-lua mappings, e.g:
                        --   vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = true })
                    end,
                    -- called once *after* the fzf interface is closed
                    -- on_close = function() ... end
                },
                keymap            = {
                    builtin = {
                        -- neovim `:tmap` mappings for the fzf win
                        ['<F1>']     = 'toggle-help',
                        ['<F2>']     = 'toggle-fullscreen',
                        -- Only valid with the 'builtin' previewer
                        ['<F3>']     = 'toggle-preview-wrap',
                        ['<F4>']     = 'toggle-preview',
                        -- Rotate preview clockwise/counter-clockwise
                        ['<F5>']     = 'toggle-preview-ccw',
                        ['<F6>']     = 'toggle-preview-cw',
                        ['<S-down>'] = 'preview-page-down',
                        ['<S-up>']   = 'preview-page-up',
                        ['<S-left>'] = 'preview-page-reset',
                    },
                    fzf = {
                        -- fzf '--bind=' options
                        ['ctrl-z']     = 'abort',
                        ['ctrl-u']     = 'unix-line-discard',
                        ['ctrl-f']     = 'half-page-down',
                        ['ctrl-b']     = 'half-page-up',
                        ['ctrl-a']     = 'beginning-of-line',
                        ['ctrl-e']     = 'end-of-line',
                        ['alt-a']      = 'toggle-all',
                        -- Only valid with fzf previewers (bat/cat/git/etc)
                        ['f3']         = 'toggle-preview-wrap',
                        ['f4']         = 'toggle-preview',
                        ['shift-down'] = 'preview-page-down',
                        ['shift-up']   = 'preview-page-up',
                    },
                },
                actions           = {
                    files = {
                        ['default'] = actions.file_edit_or_qf,
                        ['ctrl-s']  = actions.file_split,
                        ['ctrl-v']  = actions.file_vsplit,
                        ['ctrl-t']  = actions.file_tabedit,
                        ['alt-q']   = actions.file_sel_to_qf,
                        ['alt-l']   = actions.file_sel_to_ll,
                    },
                    buffers = {
                        ['default'] = actions.buf_edit,
                        ['ctrl-s']  = actions.buf_split,
                        ['ctrl-v']  = actions.buf_vsplit,
                        ['ctrl-t']  = actions.buf_tabedit,
                    }
                },
                fzf_opts          = {
                    ['--ansi']   = '',
                    ['--info']   = 'inline',
                    ['--height'] = '100%',
                    ['--layout'] = 'reverse',
                    ['--border'] = 'none',
                },
                previewers        = {
                    bat = {
                        cmd  = 'bat',
                        args = '--color=always --style=numbers,changes',
                        -- uncomment to set a bat theme, `bat --list-themes`
                        -- theme           = 'Coldark-Dark',
                    },
                    builtin = {
                        syntax          = true,             -- preview syntax highlight?
                        syntax_limit_l  = 0,                -- syntax limit (lines), 0=nolimit
                        syntax_limit_b  = 1024 * 1024,      -- syntax limit (bytes), 0=nolimit
                        limit_b         = 1024 * 1024 * 10, -- preview limit (bytes), 0=nolimit
                        treesitter      = { enable = true, disable = {} },
                        -- Title transform function, by default only displays the tail
                        -- title_fnamemodify = function(s) vim.fn.fnamemodify(s, ":t") end,
                        -- preview extensions using a custom shell command:
                        -- for example, use `viu` for image previews
                        -- will do nothing if `viu` isn't executable
                        extensions      = {
                            -- neovim terminal only supports `viu` block output
                            ['png'] = { 'ueberzug' },
                            -- by default the filename is added as last argument
                            -- if required, use `{file}` for argument positioning
                            ['svg'] = { 'ueberzug' },
                            ['jpg'] = { 'ueberzug' },
                        },
                        -- if using `ueberzug` in the above extensions map
                        -- set the default image scaler, possible scalers:
                        --   false (none), "crop", "distort", "fit_contain",
                        --   "contain", "forced_cover", "cover"
                        -- https://github.com/seebye/ueberzug
                        ueberzug_scaler = 'fit_contain',
                    },
                    -- Code Action previewers, default is "codeaction" (set via `lsp.code_actions.previewer`)
                    -- "codeaction_native" uses fzf's native previewer, recommended when combined with git-delta
                    codeaction = {
                        -- options for vim.diff(): https://neovim.io/doc/user/lua.html#vim.diff()
                        diff_opts = { ctxlen = 3 },
                    },
                    codeaction_native = {
                        diff_opts = { ctxlen = 3 },
                        -- git-delta is automatically detected as pager, set `pager=false`
                        -- to disable, can also be set under 'lsp.code_actions.preview_pager'
                        -- recommended styling for delta
                        --pager = [[delta --width=$COLUMNS --hunk-header-style="omit" --file-style="omit"]],
                    },
                },
                files             = {
                    prompt       = 'Files❯ ',
                    multiprocess = true,           -- run command in a separate process
                    git_icons    = true,           -- show git icons?
                    file_icons   = true,           -- show file icons?
                    color_icons  = true,           -- colorize file|git icons

                    find_opts    = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
                    rg_opts      = "--color=never --files --hidden --follow -g '!.git'",
                    fd_opts      = '--color=never --type f --hidden --follow --exclude .git',
                },
                git               = {
                    files = {
                        prompt = 'GitFiles❯ ',
                    },
                    status = {
                        prompt  = 'GitStatus❯ ',
                        actions = {
                            ['right']  = false,
                            ['left']   = false,
                            ['ctrl-x'] = { fn = actions.git_reset, reload = true },
                            ['ctrl-s'] = { fn = actions.git_stage_unstage, reload = true },
                        },
                    },
                    commits = {
                        prompt  = 'Commits❯ ',
                        actions = {
                            ['default'] = actions.git_checkout,
                            -- remove `exec_silent` or set to `false` to exit after yank
                            ['ctrl-y']  = { fn = actions.git_yank_commit, exec_silent = true },
                        },
                    },
                    bcommits = {
                        prompt  = 'BCommits❯ ',
                        actions = {
                            ['default'] = actions.git_buf_edit,
                            ['ctrl-s']  = actions.git_buf_split,
                            ['ctrl-v']  = actions.git_buf_vsplit,
                            ['ctrl-t']  = actions.git_buf_tabedit,
                            ['ctrl-y']  = { fn = actions.git_yank_commit, exec_silent = true },
                        },
                    },
                    branches = {
                        prompt  = 'Branches❯ ',
                        actions = {
                            ['default'] = actions.git_switch,
                        },
                    },
                    tags = {
                        prompt  = 'Tags> ',
                        actions = { ['default'] = actions.git_checkout },
                    },
                    stash = {
                        prompt   = 'Stash> ',
                        actions  = {
                            ['default'] = actions.git_stash_apply,
                            ['ctrl-x']  = { fn = actions.git_stash_drop, reload = true },
                        },
                        fzf_opts = {
                            ['--no-multi']  = '',
                            ['--delimiter'] = "'[:]'",
                        },
                    },
                    icons = {
                        -- ['M'] = { icon = icons.gen.box_modified, color = 'yellow' },
                        -- ['D'] = { icon = icons.gen.box_deleted, color = 'red' },
                        -- ['A'] = { icon = icons.gen.box_added, color = 'green' },
                        -- ['R'] = { icon = icons.gen.box_renamed, color = 'yellow' },
                        -- ['C'] = { icon = icons.gen.config, color = 'yellow' },
                        -- ['T'] = { icon = 'T', color = 'magenta' },
                        -- ['?'] = { icon = icons.gen.question, color = 'magenta' },
                    },
                },
                grep              = {
                    prompt       = 'Rg❯ ',
                    input_prompt = 'Grep For❯ ',
                    actions      = {
                        -- actions inherit from 'actions.files' and merge
                        -- this action toggles between 'grep' and 'live_grep'
                        ['ctrl-g'] = { actions.grep_lgrep }
                    },
                    no_header    = false,   -- hide grep|cwd header?
                    no_header_i  = false,   -- hide interactive header?
                },
                args              = {
                    prompt  = 'Args❯ ',
                    actions = { ['ctrl-x'] = { fn = actions.arg_del, reload = true } },
                },
                oldfiles          = {
                    prompt                  = 'History❯ ',
                    cwd_only                = false,
                    stat_file               = true,  -- verify files exist on disk
                    include_current_session = false, -- include bufs from current session
                },
                buffers           = {
                    prompt  = 'Buffers❯ ',
                    actions = {
                        ['ctrl-x'] = { fn = actions.buf_del, reload = true },
                    }
                },
                tabs              = {
                    prompt     = 'Tabs❯ ',
                    tab_title  = 'Tab',
                    tab_marker = '<<',
                    actions    = {
                        -- actions inherit from 'actions.buffers' and merge
                        ['default'] = actions.buf_switch,
                        ['ctrl-x']  = { fn = actions.buf_del, reload = true },
                    },
                    fzf_opts   = {
                        -- hide tabnr
                        ['--delimiter'] = "'[\\):]'",
                        ['--with-nth']  = '2..',
                    },
                },
                lines             = {
                    previewer       = 'builtin', -- set to 'false' to disable
                    prompt          = 'Lines❯ ',
                    show_unloaded   = true,      -- show unloaded buffers
                    show_unlisted   = false,     -- exclude 'help' buffers
                    no_term_buffers = true,      -- exclude 'term' buffers
                    actions         = {
                        ['default'] = actions.buf_edit_or_qf,
                        ['alt-q']   = actions.buf_sel_to_qf,
                        ['alt-l']   = actions.buf_sel_to_ll
                    },
                },
                blines            = {
                    previewer = 'builtin',       -- set to 'false' to disable
                    prompt    = 'BLines❯ ',
                    -- actions inherit from 'actions.buffers' and merge
                    actions   = {
                        ['default'] = actions.buf_edit_or_qf,
                        ['alt-q']   = actions.buf_sel_to_qf,
                        ['alt-l']   = actions.buf_sel_to_ll
                    },
                },
                tags              = {
                    prompt     = 'Tags❯ ',
                    ctags_file = nil,   -- auto-detect from tags-option
                    actions    = {
                        -- actions inherit from 'actions.files' and merge
                        -- this action toggles between 'grep' and 'live_grep'
                        ['ctrl-g'] = { actions.grep_lgrep }
                    },
                },
                btags             = {
                    prompt = 'BTags❯ ',
                    -- actions inherit from 'actions.files'
                },
                colorschemes      = {
                    prompt       = 'Colorschemes❯ ',
                    live_preview = true, -- apply the colorscheme on preview?
                    actions      = { ['default'] = actions.colorscheme, },
                    winopts      = { height = 0.55, width = 0.30, },
                },
                keymaps           = {
                    prompt          = 'Keymaps> ',
                    winopts         = { preview = { layout = 'vertical' } },
                    fzf_opts        = { ['--tiebreak'] = 'index', },
                    -- by default, we ignore <Plug> and <SNR> mappings
                    -- set `ignore_patterns = false` to disable filtering
                    ignore_patterns = { '^<SNR>', '^<Plug>' },
                    actions         = {
                        ['default'] = actions.keymap_apply,
                        ['ctrl-s']  = actions.keymap_split,
                        ['ctrl-v']  = actions.keymap_vsplit,
                        ['ctrl-t']  = actions.keymap_tabedit,
                    },
                },
                quickfix          = {
                    file_icons = true,
                    git_icons  = true,
                },
                quickfix_stack    = {
                    prompt = 'Quickfix Stack> ',
                    marker = '>', -- current list marker
                },
                lsp               = {
                    prompt_postfix     = '❯ ', -- will be appended to the LSP label
                    -- to override use 'prompt' instead
                    cwd_only           = false, -- LSP/diagnostics for cwd only?
                    async_or_timeout   = 5000, -- timeout(ms) or 'true' for async calls
                    file_icons         = true,
                    git_icons          = false,
                    -- The equivalent of using `includeDeclaration` in lsp buf calls, e.g:
                    -- :lua vim.lsp.buf.references({includeDeclaration = false})
                    includeDeclaration = true, -- include current declaration in LSP context
                    -- settings for 'lsp_{document|workspace|lsp_live_workspace}_symbols'
                    symbols            = {
                        async_or_timeout = true, -- symbols are async by default
                        symbol_style     = 1,    -- style for document/workspace symbols
                        -- false: disable,    1: icon+kind
                        --     2: icon only,  3: kind only
                        -- NOTE: icons are extracted from
                        -- vim.lsp.protocol.CompletionItemKind
                        -- icons for symbol kind
                        -- see https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#symbolKind
                        -- see https://github.com/neovim/neovim/blob/829d92eca3d72a701adc6e6aa17ccd9fe2082479/runtime/lua/vim/lsp/protocol.lua#L117
                        symbol_icons     = icons.lsp_kind,
                        -- colorize using Treesitter '@' highlight groups ("@function", etc).
                        -- or 'false' to disable highlighting
                        symbol_hl        = function(s) return '@' .. s:lower() end,
                        -- additional symbol formatting, works with or without style
                        symbol_fmt       = function(s, opts) return '[' .. s .. ']' end,
                        -- prefix child symbols. set to any string or `false` to disable
                        child_prefix     = true,
                        fzf_opts         = {
                            ['--tiebreak'] = 'begin',
                            ['--info']     = 'default',
                        },
                    },
                    code_actions       = {
                        prompt           = 'Code Actions> ',
                        async_or_timeout = 5000,
                        -- when git-delta is installed use "codeaction_native" for beautiful diffs
                        -- try it out with `:FzfLua lsp_code_actions previewer=codeaction_native`
                        -- scroll up to `previewers.codeaction{_native}` for more previewer options
                        previewer        = 'codeaction',
                    },
                    finder             = {
                        prompt             = 'LSP Finder> ',
                        fzf_opts           = { ['--info'] = 'default' },
                        file_icons         = true,
                        color_icons        = true,
                        git_icons          = false,
                        async              = true, -- async by default
                        silent             = true, -- suppress "not found"
                        separator          = '| ', -- separator after provider prefix, `false` to disable
                        includeDeclaration = true, -- include current declaration in LSP context
                        -- by default display all LSP locations
                        -- to customize, duplicate table and delete unwanted providers
                        providers          = {
                            { 'references',      prefix = require('fzf-lua').utils.ansi_codes.blue('ref ') },
                            { 'definitions',     prefix = require('fzf-lua').utils.ansi_codes.green('def ') },
                            { 'declarations',    prefix = require('fzf-lua').utils.ansi_codes.magenta('decl') },
                            { 'typedefs',        prefix = require('fzf-lua').utils.ansi_codes.red('tdef') },
                            { 'implementations', prefix = require('fzf-lua').utils.ansi_codes.green('impl') },
                            { 'incoming_calls',  prefix = require('fzf-lua').utils.ansi_codes.cyan('in  ') },
                            { 'outgoing_calls',  prefix = require('fzf-lua').utils.ansi_codes.yellow('out ') },
                        },
                    }
                },
                diagnostics       = {
                    prompt       = 'Diagnostics❯ ',
                    icon_padding = '',   -- add padding for wide diagnostics signs
                    multiline    = true, -- concatenate multi-line diags into a single line
                    signs        = {
                        ['Error'] = { text = icons.gen.circle_error, texthl = 'DiagnosticError' },
                        ['Warn']  = { text = icons.gen.circle_warn, texthl = 'DiagnosticWarn' },
                        ['Info']  = { text = icons.gen.circle_info, texthl = 'DiagnosticInfo' },
                        ['Hint']  = { text = icons.gen.circle_hint, texthl = 'DiagnosticHint' },
                    },
                },
                complete_path     = {
                    cmd      = nil, -- default: auto detect fd|rg|find
                    complete = { ['default'] = actions.complete },
                },
                complete_file     = {
                    cmd         = nil, -- default: auto detect rg|fd|find
                    file_icons  = true,
                    color_icons = true,
                    git_icons   = false,
                    -- actions inherit from 'actions.files' and merge
                    actions     = { ['default'] = actions.complete },
                    -- previewer hidden by default
                    winopts     = { preview = { hidden = 'hidden' } },
                },
                file_icon_padding = ' ',
                -- uncomment if your terminal/font does not support unicode character
                -- 'EN SPACE' (U+2002), the below sets it to 'NBSP' (U+00A0) instead
                -- nbsp = '\xc2\xa0',
            })
        end,
        keys = {
            { '<C-x><C-f>', '<cmd>lua require("fzf-lua").complete_path()<cr>',
                { desc = 'Bufferline Cycle Next', mode = { 'n', 'v', 'i' } } },

            { '<leader>pp', '<cmd>FzfLua<cr>', desc = 'FzfLua [p]ick [p]ickers' },
            { '<leader>pf', '<cmd>FzfLua files<cr>', desc = 'FzfLua [p]ick [f]iles' },
            { '<leader>pg', '<cmd>FzfLua live_grep<cr>', desc = 'FzfLua [p]ick live [g]rep' },
            { '<leader>pc', '<cmd>FzfLua colorschemes<cr>', desc = 'FzfLua [p]ick [c]olorschemes' },
            { '<leader>pm', '<cmd>FzfLua marks<cr>', desc = 'FzfLua [p]ick [m]arks' },
            { '<leader>pk', '<cmd>FzfLua keymaps<cr>', desc = 'FzfLua [p]ick [k]eymaps' },
            { '<leader>pb', '<cmd>FzfLua buffers<cr>', desc = 'FzfLua [p]ick [b]buffers' },
            { '<leader>ph', '<cmd>FzfLua help_tags<cr>', desc = 'FzfLua [p]ick [h]elp_tags' },
        },
    }
}

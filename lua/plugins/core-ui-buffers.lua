return {
    { 'echasnovski/mini.starter',
        dependencies = {
            'akinsho/bufferline.nvim',
            'nvim-telescope/telescope.nvim',
        },
        version = false,
        config = function () 
            local quboid = require('quboid')
            local util = require('util')
            local starter = require('mini.starter')

            local version = vim.version()
            local date = os.date("%A, %b %d, %Y")
            local ver = string.format("v%d.%d.%d", version.major, version.minor, version.patch)
            local ms = 0

            local details1 = quboid.icons.calendar .. " " .. date .. "  " .. quboid.icons.beaker .. " " .. ver
            local details2 = quboid.icons.startup .. " Loaded " .. require("lazy").stats().count .. " Plugins in 000.00 ms".."  "
            local quote = quboid.dashboard_quotes[math.random(#quboid.dashboard_quotes)]
            local w = util.max_width(quboid.dashboard_header, details1, details2, quboid.dashboard_footer, quote)

            vim.api.nvim_create_autocmd("User", {
                pattern = "LazyVimStarted",
                callback = function()
					vim.opt_local.statuscolumn = ""
                    require('mini.starter').refresh()
                end,
            })

            local header = (function()
                return function ()
                    ms = (math.floor(require("lazy").stats().startuptime * 100 + 0.5) / 100)
                    details2 = quboid.icons.startup .. " Loaded " .. require("lazy").stats().count .. " Plugins in "..ms.." ms"..' '

                    for i, str in ipairs(quboid.dashboard_header) do
                        str = util.pad_to_width(str, w)
                    end
                    details1 = util.pad_to_width(details1, w)
                    details2 = util.pad_to_width(details2, w)

                    local head = table.concat(quboid.dashboard_header, "\n")
                    head = head..'\n'..details1..'\n'..details2
                    return head
                end
            end)()

            local function footer()
                for i, str in ipairs(quboid.dashboard_footer) do
                    str = util.pad_to_width(str, w)
                end
                quote = util.pad_to_width(quote, w)

                local feet = table.concat(quboid.dashboard_footer, "\n")
                feet = feet..'\n'..quote
                return feet
            end

            local function dashboard_notebook_mapping (prompt_bufnr, map)
                map({ "n", "i" }, "<CR>", function ()
                    local selected_entry = require("telescope.actions.state").get_selected_entry()
                    require("telescope.actions").select_default(prompt_bufnr)
                    vim.cmd([[cd ]]..quboid.notebook_dir)
                    vim.wait(200)
                    vim.cmd([[ZkCd]])
                end)
                return true
            end

            local function dashboard_config_mapping (prompt_bufnr, map)
                map({ "n", "i" }, "<CR>", function()
                    local actions = require("telescope.actions")
                    actions.select_default(prompt_bufnr)
                    vim.cmd([[cd ]]..'~/.config/nvim')
                end)
                return true
            end

            require('mini.starter').setup({
                autoopen = true,
                evaluate_single = false,
                items = {
                    -- starter.sections.telescope(),
                    -- starter.sections.builtin_actions(),
                    { name = [[Empty Buffer]], section = [[General Actions]], action = 'enew'},
                    { name = [[Quit]], section = [[General Actions]], action = 'qa'},

                    { name = [[Recent Files]], section = [[Navigation]], action = "Telescope oldfiles"},
                    { name = [[Sessions]], section = [[Navigation]], action = "SessionManager load_session"},
                    { name = [[Notebooks]], section = [[Navigation]], action = function ()
                        require('telescope.builtin').find_files({ cwd = quboid.notebook_dir, find_command = {"fd", "-e", "md", "-g", "index.md"}, attach_mappings = dashboard_notebook_mapping, })
                    end},
                    { name = [[Config]], section = [[Navigation]], action = function ()
                        require('telescope.builtin').find_files({ cwd = "~/.config/nvim", attach_mappings = dashboard_config_mapping })
                    end},

                    starter.sections.recent_files(5, true),
                },
                content_hooks = {
                    starter.gen_hook.adding_bullet('  '.."░ ",false),
                    starter.gen_hook.aligning('center', 'center'),
                    starter.gen_hook.indexing('all', { 'General Actions', 'Navigation' }),
                },
                header = header,
                footer = footer(),
            })

            local MiniStarterKeys = vim.api.nvim_create_augroup("MiniStarterKeys", {clear = true})

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniStarterOpened",
                group = MiniStarterKeys,
                callback = function(opts)
                    vim.schedule(function ()
                        local bufnr = opts.buf
                        vim.keymap.set('n', 'j', '<cmd>lua require("mini.starter").update_current_item("next")<cr>', { desc = 'Mini Starter Down', buffer = bufnr })
                        vim.keymap.set('n', 'k', '<cmd>lua require("mini.starter").update_current_item("prev")<cr>', { desc = 'Mini Starter Up', buffer = bufnr })
                    end)
                end,
            })

            vim.api.nvim_create_user_command("MiniStarterOpen", "lua require('mini.starter').open()", {})
            vim.api.nvim_create_user_command("MiniStarterClose", "lua require('mini.starter').close()", {})
        end,
    },
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			local quboid = require("quboid")

			vim.fn.sign_define(
				"DiagnosticSignError",
				{ text = quboid.icons.circle_error, texthl = "DiagnosticSignError" }
			)
			vim.fn.sign_define("DiagnosticSignWarn", { text = quboid.icons.circle_warn, texthl = "DiagnosticSignWarn" })
			vim.fn.sign_define("DiagnosticSignInfo", { text = quboid.icons.circle_info, texthl = "DiagnosticSignInfo" })
			vim.fn.sign_define("DiagnosticSignHint", { text = quboid.icons.circle_hint, texthl = "DiagnosticSignHint" })

			require("neo-tree").setup({
				close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
				popup_border_style = quboid.border,
				enable_git_status = true,
				enable_diagnostics = true,

				default_component_configs = {
					container = {
						enable_character_fade = true,
					},
					indent = {
						indent_size = 2,
						padding = 1, -- extra padding on left hand side
						-- indent guides
						with_markers = true,
						indent_marker = quboid.icons.bar_thick_tree,
						last_indent_marker = quboid.icons.bar_thick_elbow,
						highlight = "NeoTreeIndentMarker",
						-- expander config, needed for nesting files
						with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
						expander_collapsed = "",
						expander_expanded = "",
						expander_highlight = "NeoTreeExpander",
					},
					icon = {
						folder_closed = quboid.icons.folder,
						folder_open = quboid.icons.folder_open,
						folder_empty = quboid.icons.folder_outline,
						-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
						-- then these will never be used.
						default = "*",
						highlight = "NeoTreeFileIcon",
					},
					modified = {
						symbol = "[+]",
						highlight = "NeoTreeModified",
					},
					git_status = {
						symbols = {
							-- Change type
							added = quboid.icons.git_added, -- or '✚', but this is redundant info if you use git_status_colors on the name
							modified = quboid.icons.git_modified, -- or '', but this is redundant info if you use git_status_colors on the name
							deleted = quboid.icons.git_deleted, -- this can only be used in the git_status source
							renamed = quboid.icons.git_renamed, -- this can only be used in the git_status source
							-- Status type
							untracked = quboid.icons.git_untracked,
							ignored = quboid.icons.git_ignored,
							unstaged = quboid.icons.git_unstaged,
							staged = quboid.icons.git_staged,
							conflict = quboid.icons.git_conflict,
						},
					},
				},
				window = {
					position = "left",
					width = 40,
					mapping_options = {
						noremap = true,
						nowait = true,
					},
					mappings = {
						-- ['<space>'] = {
						--     'toggle_node',
						--     nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
						-- },
						["<2-LeftMouse>"] = "open",
						["<cr>"] = "open",
						["<tab>"] = "open",
						["<esc>"] = "cancel", -- close preview or floating neo-tree window
						["P"] = { "toggle_preview", config = { use_float = true } },
						["l"] = "focus_preview",
						["S"] = "open_split",
						["s"] = "open_vsplit",
						-- ['S'] = 'split_with_window_picker',
						-- ['s'] = 'vsplit_with_window_picker',
						["t"] = "open_tabnew",
						-- ['<cr>'] = 'open_drop',
						-- ['t'] = 'open_tab_drop',
						["w"] = "open_with_window_picker",
						--['P'] = 'toggle_preview', -- enter preview mode, which shows the current node without focusing
						["C"] = "close_node",
						-- ['C'] = 'close_all_subnodes',
						["z"] = "close_all_nodes",
						--['Z'] = 'expand_all_nodes',
						["a"] = {
							"add",
							-- this command supports BASH style brace expansion ('x{a,b,c}' -> xa,xb,xc). see `:h neo-tree-file-actions` for details
							-- some commands may take optional config options, see `:h neo-tree-mappings` for details
							config = {
								show_path = "none", -- 'none', 'relative', 'absolute'
							},
						},
				["A"] = "add_directory", -- also accepts the optional config.show_path option like 'add'. this also supports BASH style brace expansion.
						["d"] = "delete",
						["r"] = "rename",
						["y"] = "copy_to_clipboard",
						["x"] = "cut_to_clipboard",
						["p"] = "paste_from_clipboard",
						["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like 'add':
						-- ['c'] = {
						--  'copy',
						--  config = {
						--    show_path = 'none' -- 'none', 'relative', 'absolute'
						--  }
						--}
						["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like 'add'.
						["q"] = "close_window",
						["R"] = "refresh",
						["?"] = "show_help",
						["<"] = "prev_source",
						[">"] = "next_source",
						["i"] = "show_file_details",
					},
				},

				filesystem = {
					hijack_netrw_behavior = "open_default",
				},
				-- https://github.com/echasnovski/mini.nvim/issues/177#issuecomment-1406203745
				event_handlers = {
					{
						event = "neo_tree_window_after_open",
						handler = function(data)
							local winid = data.winid
							vim.api.nvim_win_set_option(winid, "winfixwidth", true)
							vim.api.nvim_win_set_width(winid, 40)
						end,
					},
				},
			})
		end,
		-- event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "<leader>nn", "<cmd>Neotree toggle<cr>", desc = "Neo-tree Toggle" },
		},
	},
	{
		"simrat39/symbols-outline.nvim",
		opts = {

			auto_close = true,
			relative_width = false,
			width = 40,
			show_guides = true,
		},
		event = "VeryLazy",
		keys = {
			{ "<leader>bs", "<cmd>SymbolsOutline<cr>", desc = "[b]uffer [s]symbol Outline Toggle" },
		},
	},
	{
		"folke/trouble.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			{
				"folke/todo-comments.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
				opts = {
					keywords = {
						FIX = {
							icon = require("quboid").icons.bug,
							color = "error",
							alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
						},
						TODO = { icon = require("quboid").icons.check, color = "info" },
						HACK = { icon = require("quboid").icons.estinguisher, color = "warning" },
						WARN = {
							icon = require("quboid").icons.exclamation,
							color = "warning",
							alt = { "WARNING", "XXX" },
						},
						PERF = {
							icon = require("quboid").icons.flag_checkered,
							alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
						},
						NOTE = { icon = require("quboid").icons.pin, color = "hint", alt = { "INFO" } },
						TEST = {
							icon = require("quboid").icons.beaker,
							color = "test",
							alt = { "TESTING", "PASSED", "FAILED" },
						},
					},
				},
				event = "VeryLazy",
				keys = {

					{
						"]t",
						function()
							require("todo-comments").jump_next()
						end,
						desc = "Next [t]odo",
					},
					{
						"[t",
						function()
							require("todo-comments").jump_prev()
						end,
						desc = "Prev [t]odo",
					},
				},
			},
		},
		event = "VimEnter",
		opts = {
			-- fold_open   = '',
			-- fold_closed = '',
			padding = false,
			cycle_results = false,
			auto_preview = false,
			indent_lines = false,
			use_diagnostic_signs = true,
		},
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle<cr>",          desc = "Trouble E[x]plore E[x]tensive (workspace)" },
			{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble E[x]plore [w]orkspace Diagnostics",  },
			{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Trouble E[x]plore [d]ocument Diagnostics",  },
			{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Trouble E[x]plore [q]uickfix Diagnostics" },
			{ "<leader>xl", "<cmd>TroubleToggle loclist<cr>",  desc = "Trouble E[x]plore [l]oclist Diagnostics" },
			{ "<leader>xt", "<cmd>TodoTrouble<cr>",            desc = "Trouble E[x]plore [t]odoComments" },
			{ "[D", "<cmd>lua require('trouble').open('workspace_diagnostics')<cr> <bar> <cmd>lua require('trouble').previous({skip_groups = true, jump = true})<cr>", desc = "Trouble Next [d]iagnsotic" },
			{ "]D", "<cmd>lua require('trouble').open('workspace_diagnostics')<cr> <bar> <cmd>lua require('trouble').next({skip_groups = true, jump = true})<cr>", desc = "Trouble Next [d]iagnsotic" },
		},
	},
	{
		"mbbill/undotree",
		config = function()
			vim.g.undotree_SplitWidth = 40
		end,
		keys = {
			{ "<leader>bu", "<cmd>UndotreeToggle<cr>", desc = "[b]uffer [u]ndotree toggle" },
		},
	},
}

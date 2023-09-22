local quboid = require("quboid")

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
			{
				url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
				config = function()
					require("lsp_lines").setup()
				end,
			},
			{
				"ray-x/lsp_signature.nvim",
				opts = {
					hint_prefix = "",
					hi_parameter = "String",
					floating_window_above_cur_line = true,
					handler_opts = {
						border = quboid.border,
					},
				},
				config = function(_, opts)
					require("lsp_signature").setup(opts)
				end,
			},
		},
		config = function()
			local quboid = require("quboid")
			local lspconfig = require("lspconfig")
			local masonlsp = require("mason-lspconfig")
			local lsp_util = require("lsp.util")

			-- Set icons
			local kinds = vim.lsp.protocol.CompletionItemKind
			for i, kind in ipairs(kinds) do
				kinds[i] = quboid.lsp_kind[i] or kind
			end

			-- Customize diagnostics also influences lsp_lines
			vim.diagnostic.config({
				virtual_text = false,
				update_in_insert = false,
				virtual_lines = { only_current_line = true },
				-- signs = true,
				underline = false,
				-- update_in_insert = false,
				severity_sort = true,
				float = {
					source = "always",
				},
			})

			-- Overide border globally
			local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
			function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
				opts = opts or {}
				opts.border = opts.border or quboid.border
				return orig_util_open_floating_preview(contents, syntax, opts, ...)
			end

			-- Customize the sign columns
			local signs = {
				Error = quboid.icons.circle_error,
				Warn = quboid.icons.circle_warn,
				Hint = quboid.icons.circle_hint,
				Info = quboid.icons.circle_info,
			}
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			masonlsp.setup_handlers({
				-- The first entry (without a key) will be the default handler
				-- and will be called for each installed server that doesn't have
				-- a dedicated handler.
				-- default handler (optional)

				function(server_name)
					require("lspconfig")[server_name].setup(lsp_util.gen_config())
				end,
				-- Next, you canprovide targeted overrides for specific servers.
				["gopls"] = function()
					local install_root_dir = vim.fn.stdpath("data") .. "/lsp_servers"
					local config = require("lsp.util").gen_config()
					local ext_config = {
						gopls_cmd = { install_root_dir .. "/go/gopls" },
						fillstruct = "gopls",
						dap_debug = true,
						dap_debug_gui = true,
					}
					config = vim.tbl_extend("keep", config or {}, ext_config)
					require("lspconfig").gopls.setup(config)
				end,
				["jdtls"] = function() end,
				["tsserver"] = function() end,
				["eslint"] = function()
					local config = lsp_util.gen_config()

					config.settings =
						{
							packageManager = quboid.ft_javascript_package_manager,
						}, lspconfig.eslint.setup(config)
				end,
				['tailwindcss'] = function ()
					local config = lsp_util.gen_config()
					config.root_dir = function (fname)
						local root_pattern = require("lspconfig").util.root_pattern(
							"tailwind.config.cjs",
							"tailwind.config.js",
							"postcss.config.js"
						)
						return root_pattern(fname)
					end
					lspconfig.lua_ls.setup({

					})
				end,
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						on_attach = function(client, bufnr)
							lsp_util.call_on_attach(client, bufnr)
						end,
						capabilities = lsp_util.gen_capabilities(),
						settings = {
							Lua = {
								runtime = {
									-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
									version = "LuaJIT",
								},
								completion = {
									callSnippet = "Replace",
								},
								diagnostics = {
									globals = { "awesome", "vim" },
								},
								workspace = {
									checkThirdParty = false,
									library = {
										[vim.fn.expand("$VIMRUNTIME/lua")] = true,
										[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
										["/usr/share/awesome/lib"] = true,
										-- require("neodev.config").types(),
									},
								},
								telemetry = {
									enable = false,
								},
							},
						},
					})
				end,
			})
		end,
		keys = {
			{
				"<leader>e",
				"<cmd>lua vim.diagnostic.open_float({}, {focus=false})<CR>",
				desc = "[e]xamine Diagnostics (2x to enter)",
			},
			{ "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Prev [d]iagnostic" },
			{ "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next [d]iagnostic" },
		},
		event = "VeryLazy",
	},

	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			automatic_installation = true,
			ensure_installed = {
				-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
				"awk_ls",
				"angularls",
				-- 'arduino_language_server',
				"bashls",
				"clangd",
				"omnisharp",
				"cmake",
				"cssls",
				-- 'clojure_lsp',
				"dockerls",
				"emmet_language_server",
				"eslint",
				"fortls",
				"gopls",
				"gradle_ls",
				"graphql",
				"html",
				"jsonls",
				"jdtls",
				"tsserver",
				"kotlin_language_server",
				"lua_ls",
				"ltex",
				"texlab",
				"rnix",
				"intelephense",
				"pyright",
				"sqlls",
				"svelte",
				"taplo",
				"tailwindcss",
				"vimls",
				"vuels",
				"lemminx",
				"yamlls",
				"zls",
			},
		},
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			{
				"jay-babu/mason-null-ls.nvim",
				config = function()
					require("mason-null-ls").setup({
						ensure_installed = {
							"prettierd",
							"black",
							"flake8",
							"golangci_lint",
							"stylua",
							"google-java-format",
						},
						automatic_installation = true,
					})
				end,
			},
			"ckolkey/ts-node-action",
		},
		config = function()
			local null_ls = require("null-ls")

			local sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettierd.with({
					condition = function(utils)
						return utils.has_file({ ".prettierrc.js" })
					end,
				}),
				null_ls.builtins.completion.spell,

				null_ls.builtins.formatting.google_java_format,
				-- null_ls.builtins.diagnostics.pmd.with({
				--     extra_args = {
				--         "--rulesets",
				--         "category/java/bestpractices.xml,category/jsp/bestpractices.xml" -- or path to self-written ruleset
				--     },
				-- }),

				null_ls.builtins.hover.dictionary,

				null_ls.builtins.hover.printenv,
				null_ls.builtins.diagnostics.flake8,
				null_ls.builtins.formatting.black,
			}

			local typescript_null_ls_ok, typescript_null_ls =
				pcall(require, "typescript.extensions.null-ls.code-actions")
			if typescript_null_ls_ok then
				table.insert(sources, typescript_null_ls)
			end

			local go_null_ls_ok, go_null_ls = pcall(require, "go.null_ls")
			if go_null_ls_ok then
				table.insert(sources, go_null_ls.gotest())
				table.insert(sources, go_null_ls.gotest_action())
				table.insert(sources, go_null_ls.golangci_lint())
			end

			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			null_ls.setup({
				sources = sources,
				debounce = 1000,
				default_timeout = 5000,
				filter = function(client)
					return client.name == "null-ls"
				end,
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						local format_on_save = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
						-- vim.api.nvim_create_autocmd("BufWritePre", {
						-- 	group = augroup,
						-- 	buffer = bufnr,
						-- 	callback = function()
						-- 		vim.notify("Formatting Document", vim.log.levels.INFO)
						-- 		vim.lsp.buf.format({
						-- 			group = format_on_save,
						-- 			bufnr = bufnr,
						-- 			filter = function(c)
						-- 				return c.name == "null-ls"
						-- 			end,
						-- 		})
						-- 	end,
						-- })
					end
				end,
			})
		end,
	},
	{
		"dnlhc/glance.nvim",
		config = function()
			require("glance").setup({
				hooks = {
					before_open = function(results, open, jump, method)
						local uri = vim.uri_from_bufnr(0)
						if #results == 1 then
							local target_uri = results[1].uri or results[1].targetUri

							if target_uri == uri then
								jump(results[1])
							else
								open(results)
							end
						else
							open(results)
						end
					end,
				},
			})
		end,
	},
    { 'RRethy/vim-illuminate',
        event = 'BufRead',
        config = function()
			require('illuminate').configure()
		end,
    },
	{
		"zbirenbaum/neodim",
		event = "LspAttach",
		config = function()
			require("neodim").setup({
				alpha = 0.5,
				blend_color = "#000000",
				hide = {
					underline = true,
					virtual_text = true,
					signs = true,
				},
				regex = {
					"[uU]nused",
					"[nN]ever [rR]ead",
					"[nN]ot [rR]ead",
				},
				disable = {},
			})
		end,
	},
	{ 'Wansmer/symbol-usage.nvim',
		event = 'LspAttach',
		config = function()
			require('symbol-usage').setup({
				---@type 'above'|'end_of_line'|'textwidth' above by default
				vt_position = 'end_of_line',
				references = { enabled = true, include_declaration = false },
				definition = { enabled = true },
				implementation = { enabled = true },
				text_format = function(symbol)
					local fragments = {}

					if symbol.references then
						local usage = symbol.references <= 1 and 'usage' or 'usages'
						local num = symbol.references == 0 and 'no' or symbol.references
						table.insert(fragments, ('%s %s'):format(num, usage))
					end

					if symbol.definition then
						table.insert(fragments, symbol.definition .. ' defs')
					end

					if symbol.implementation then
						table.insert(fragments, symbol.implementation .. ' impls')
					end

					return '  ('..table.concat(fragments, ', ')..')'
				end,
			})
		end
	}
}

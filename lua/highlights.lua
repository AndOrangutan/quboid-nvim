local util = require("util")
local quboid = require("quboid")

local lualine_ok, lualine = pcall(require, "lualine")

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- Blanks out cursorline but keeps lnnr hl
		vim.api.nvim_set_hl(0, "CursorLineNr", { link = "Normal" })
		vim.api.nvim_set_hl(0, "CursorLine", { link = "NONE" })

		vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { link = "CmpItemKindString" })

		vim.api.nvim_set_hl(0, "FoldColumn", { link = "Normal" })

		vim.api.nvim_set_hl(0, "NormalFloat", { link = "Pmenu" })

		-- HACK: to change borders to solid by default
		vim.api.nvim_set_hl(
			0,
			"FloatBorder",
			{ fg = util.get_hl_val("NormalFloat", "background"), bg = util.get_hl_val("NormalFloat", "background") }
		)

		vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
		vim.api.nvim_set_hl(0, "CodiVirtualText", { link = "Comment" })
		vim.api.nvim_set_hl(0, "MiniMapNormal", { link = "Comment" })
		vim.api.nvim_set_hl(0, "MiniIndentscopePrefix", { link = "Comment" })
		vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "Comment" })
		vim.api.nvim_set_hl(
			0,
			"ReverseSearch",
			{ fg = util.get_hl_val("Search", "background"), bg = util.get_hl_val("Normal", "background") }
		)

		vim.api.nvim_set_hl(0, "StatusLineNCSearch", { fg = util.get_hl_val("Search", "background") })
		vim.api.nvim_set_hl(0, "StatusLineNCString", { fg = util.get_hl_val("String", "foreground") })
		vim.api.nvim_set_hl(0, "StatusLineNCVisual", { fg = util.get_hl_val("Constant", "foreground") })
		vim.api.nvim_set_hl(0, "StatusLineNCComment", { fg = util.get_hl_val("Comment", "foreground") })

		vim.api.nvim_set_hl(0, "EyelinerPrimary", { bold = true, underline = true })
		vim.api.nvim_set_hl(0, "EyelinerSecondary", { underline = true })

		local mantle = util.get_hl_val("NormalFloat", "background")
		local surface0 = util.get_hl_val("NormalFloat", "background")
		local green = util.get_hl_val("String", "foreground")
		local pink = util.get_hl_val("Keyword", "foreground")
		local flamingo = util.get_hl_val("Identifier", "foreground")
		local normal = util.get_hl_val("Normal", "background")

		vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = mantle })

		vim.api.nvim_set_hl(0, "TelescopeWatching", { bg = flamingo })
		vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = surface0, bold = true })

		vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { bg = surface0 })
		vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = surface0 })
		vim.api.nvim_set_hl(0, "TelescopeResultsNomral", { bg = mantle })
		vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = normal })
		vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = surface0, bg = surface0 })
		vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = mantle, bg = mantle })
		vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = mantle, bg = mantle })
		vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = pink, bg = mantle })
		vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = mantle })
		vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = green, bg = mantle })

		vim.api.nvim_set_hl(
			0,
			"IlluminatedWordText",
			{ underline = true, sp = util.get_hl_val("Normal", "foreground") }
		)

		vim.api.nvim_set_hl(0, "TreesitterContext", { link = "Normal" })
		vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { link = "Normal" })

		if lualine_ok then
			lualine.refresh()
		end
	end,
})

vim.o.background = "dark"
-- vim.cmd('colorscheme ayu')
vim.cmd("colorscheme " .. quboid.colorscheme)

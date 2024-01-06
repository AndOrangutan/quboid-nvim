return {
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = {
			"DiffviewOpen",
			"DiffviewToggle",
		},
		event = "VeryLazy",
		keys = {
			{
				"<leader>gd",
				function()
					require("util").toggle_cmd("DiffviewOpen", "DiffviewClose")
				end,
				desc = "[d]iffview Toggle",
			},
		},
	},
	{ "tpope/vim-fugitive" },
	{
		"lewis6991/gitsigns.nvim",
		config = true,
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "[g]it [b]lame toggle" },
		},
	},
	{ "ThePrimeagen/git-worktree.nvim",
		dependencies = {
			'nvim-telescope/telescope.nvim',
		},
		config = function()
			local worktree = require("git-worktree")
			worktree.on_tree_change(function(op, metadata)
				if op == worktree.Operations.Switch then
					vim.notify(
						"Switched worktree from " .. metadata.prev_path .. " to " .. metadata.path,
						vim.log.levels["INFO"]
					)
				end
			end)
			-- worktree.on_tree_change(function(op, metadata)
			-- 	if op == worktree.Operations.Switch then
			-- 		vim.cmd('cd '..metadata.path)
			-- 		vim.notify(
			-- 			"Switched worktree from " .. metadata.prev_path .. " to " .. metadata.path,
			-- 			vim.log.levels["INFO"]
			-- 		)
			-- 	end
			-- end)
		end,
		keys = {
			{ "<leader>fws", '<cmd>Telescope git_worktree git_worktrees<cr>', desc = "Telescope [f]ZF [w]orktree [s]witch",  },
			{ "<leader>fwc", '<cmd>Telescope git_worktree create_git_worktree<cr>', desc = "Telescope [f]ZF [w]orktree [c]reate",  },
		},
	},
	{
		"TimUntersberger/neogit",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = {
			integrations = { diffview = true },
		},
		keys = {
			{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Neo[g]it Toggle [g]oodness" },
		},
		event = "VeryLazy",
	},
}

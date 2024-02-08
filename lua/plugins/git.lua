return {
    {
        'sindrets/diffview.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = {
            'DiffviewOpen',
            'DiffviewToggle',
        },
        event = { 'BufReadPre', 'BufNewFile' },
        keys = {
            {
                '<leader>gd',
                function() require('quboid.util').toggle_cmd('DiffviewOpen', 'DiffviewClose') end,
                desc = '[d]iffview Toggle',
            },
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        keys = {
            { '<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<cr>', desc = '[g]it [b]lame toggle' },
        },
        config = true,
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

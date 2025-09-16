return {
	{
		"pwntester/octo.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "ibhagwan/fzf-lua" },
			{ "nvim-tree/nvim-web-devicons" },
		},
		config = function()
			require("octo").setup({
				picker = "fzf-lua",
				mappings = {
					issue = {
						list_issues = { lhs = "<leader>gl", desc = "list issue" },
					},
				},
			})
		end,
	},
	{
		"linrongbin16/gitlinker.nvim",
		cmd = "GitLink",
		opts = {},
		keys = {
			{ "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
			{ "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
		},
	},
}

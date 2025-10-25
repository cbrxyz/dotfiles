return {
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
		config = function()
			require("oil").setup({
				view_options = {
					show_hidden = true,
				},
				columns = {
					"icon",
					"permissions",
				},
				skip_confirm_for_simple_edits = true,
				watch_for_changes = true,
				float = {
					padding = 1,
					max_width = 60,
					max_height = 30,
					border = "rounded",
					win_options = {
						winblend = 0,
					},
					override = function(conf)
						return conf
					end,
				},
				keymaps = {
					["gv"] = {
						"actions.select",
						opts = { vertical = true },
						desc = "Open the entry in a vertical split",
					},
					["gs"] = {
						"actions.select",
						opts = { horizontal = true },
						desc = "Open the entry in a horizontal split",
					},
				},
			})
			vim.keymap.set("n", "<leader>os", function()
				vim.cmd("vsplit | wincmd l")
				require("oil").open()
			end)
			vim.keymap.set("n", "<leader>oo", function()
				require("oil").open_float()
			end)
		end,
	},
	{ "LunarVim/bigfile.nvim" },
}

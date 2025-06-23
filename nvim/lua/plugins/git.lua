return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gitsigns = require("gitsigns").setup({
				keymaps = {
					noremap = true,

					["n gn"] = { expr = true, "&diff ? 'gn' : '<cmd>Gitsigns next_hunk<CR>'" },
					["n gp"] = { expr = true, "&diff ? 'gp' : '<cmd>Gitsigns prev_hunk<CR>'" },
				},
			})
		end,
	},
	{
		"tpope/vim-rhubarb",
	},
	{
		"tpope/vim-fugitive",
	},
}

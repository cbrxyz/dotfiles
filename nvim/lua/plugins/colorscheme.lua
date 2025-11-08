return {
	{
		"rebelot/kanagawa.nvim",
		config = function()
			-- Colorscheme
			vim.cmd("colorscheme kanagawa")
		end,
		lazy = true,
	},
	{
		"rose-pine/neovim",
		config = function()
			require("rose-pine").setup({
				variant = "moon",
				styles = {
					italic = false,
				},
				palette = {
					moon = {
						pine = "#e68ad7", -- "#91d1eb",
						foam = "#6da6ad",
					},
				},
			})
			vim.cmd("colorscheme rose-pine")
		end,
	},
}

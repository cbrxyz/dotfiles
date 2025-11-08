return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gitsigns = require("gitsigns").setup({
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")
					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					map("n", "gn", function()
						gitsigns.nav_hunk("next")
					end)

					map("n", "gp", function()
						gitsigns.nav_hunk("prev")
					end)
				end,
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

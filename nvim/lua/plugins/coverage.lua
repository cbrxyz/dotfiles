return {
	{
		"andythigpen/nvim-coverage",
		version = "*",
		config = function()
			require("coverage").setup({
				auto_reload = true,
			})
			vim.keymap.set("n", "<leader>gc", function()
				require("coverage").load(true)
			end, { desc = "Toggle Coverage", noremap = true, silent = true })
		end,
	},
}

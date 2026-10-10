return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter")
		local ignored = { "phpdoc" }

		local function start(buf, lang)
			if pcall(vim.treesitter.start, buf, lang) then
				vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(event)
				local lang = vim.treesitter.language.get_lang(event.match)
				if not lang or vim.list_contains(ignored, lang) then
					return
				end

				local needs_install = not vim.list_contains(treesitter.get_installed(), lang)
					and vim.list_contains(treesitter.get_available(), lang)
				if needs_install then
					treesitter.install(lang):await(vim.schedule_wrap(function()
						if vim.api.nvim_buf_is_valid(event.buf) then
							start(event.buf, lang)
						end
					end))
				else
					start(event.buf, lang)
				end
			end,
		})
	end,
}

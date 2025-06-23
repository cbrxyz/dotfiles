return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	dependencies = { "rafamadriz/friendly-snippets" },
	build = "make install_jsregexp",
	config = function()
		local ls = require("luasnip")
		local s = ls.snippet
		local t = ls.text_node

		-- Insert the current date snippet (cud)
		ls.add_snippets("all", {
			s({ trig = "cud" }, {
				t({ os.date("%Y-%m-%d %H:%M:%S") }),
			}),
		})
	end,
}

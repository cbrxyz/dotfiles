return {
	{
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
		config = function()
			local function md_wordcount()
				return tostring(vim.fn.wordcount().words) .. " words"
			end

			local function is_markdown()
				return vim.bo.filetype == "markdown" or vim.bo.filetype == "asciidoc"
			end

			local function latex_wordcount()
				-- Call "texcount -1 <filename> | awk ${print 1}" to get the word count
				return "? words"
				-- local filename = vim.fn.expand("%:p")
				-- local cmd = "texcount -1 " .. filename .. " | awk '{print $1}'"
				-- local handle = io.popen(cmd)
				-- local result = handle:read("*a")
				-- handle:close()
				-- return result:match("%d+") .. " words"
			end

			local function is_latex()
				return vim.bo.filetype == "tex" or vim.bo.filetype == "latex"
			end

			local function is_visual()
				return vim.fn.mode():find("[Vv]") ~= nil
			end

			function selection_count()
				local starts = vim.fn.line("v")
				local ends = vim.fn.line(".")
				local count = starts <= ends and ends - starts + 1 or starts - ends + 1
				local wc = vim.fn.wordcount()
				return count .. "L/" .. tostring(wc.visual_words) .. "W"
			end

			local colorscheme = require("rose-pine.palette")
			local colors = {
				red = colorscheme.love,
				yellow = colorscheme.gold,
				blue = colorscheme.foam,
				white = colorscheme.text,
				black = colorscheme.base,
			}

			-- Refresh lualine on LSP progress
			vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
			vim.api.nvim_create_autocmd("User", {
				group = "lualine_augroup",
				pattern = "LspProgressStatusUpdated",
				callback = require("lualine").refresh,
			})

			require("lualine").setup({
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff" },
					lualine_c = { "filename" },
					lualine_x = {
						{
							"diagnostics",
							sections = { "error", "warn", "info" },
							diagnostics_color = {
								error = { bg = colors.red, fg = colors.white },
								warn = { bg = colors.yellow, fg = colors.black },
								info = { bg = colors.info, fg = colors.black },
							},
						},
						{ md_wordcount, cond = is_markdown },
						{ latex_wordcount, cond = is_latex },
						function()
							return require("lsp-progress").progress()
						end,
						"encoding",
						"fileformat",
						"filetype",
					},
					lualine_y = { "progress" },
					lualine_z = { "location", { selection_count, cond = is_visual } },
				},
			})
		end,
	},
	{
		"linrongbin16/lsp-progress.nvim",
		config = function()
			require("lsp-progress").setup({
				client_format = function(client_name, spinner, series_messages)
					if #series_messages == 0 then
						return nil
					end
					return {
						name = client_name,
						body = spinner .. " " .. table.concat(series_messages, ", "),
					}
				end,
				format = function(client_messages)
					--- @param name string
					--- @param msg string?
					--- @return string
					local function stringify(name, msg)
						return msg and string.format("%s %s", name, msg) or name
					end

					local sign = "" -- nf-fa-gear \uf013
					local lsp_clients = vim.lsp.get_active_clients()
					local messages_map = {}
					for _, climsg in ipairs(client_messages) do
						messages_map[climsg.name] = climsg.body
					end

					if #lsp_clients > 0 then
						table.sort(lsp_clients, function(a, b)
							return a.name < b.name
						end)
						local builder = {}
						for _, cli in ipairs(lsp_clients) do
							if type(cli) == "table" and type(cli.name) == "string" and string.len(cli.name) > 0 then
								if messages_map[cli.name] then
									table.insert(builder, stringify(cli.name, messages_map[cli.name]))
								else
									table.insert(builder, stringify(cli.name))
								end
							end
						end
						if #builder > 0 then
							return sign .. " " .. table.concat(builder, ", ")
						end
					end
					return ""
				end,
			})
		end,
	},
}

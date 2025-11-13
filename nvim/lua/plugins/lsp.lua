return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"j-hui/fidget.nvim",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local bufnr = event.buf
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if not client then
						return
					end

					---@diagnostic disable-next-line need-check-nil
					if client.server_capabilities.completionProvider then
						vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
						-- vim.bo[bufnr].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
					end
					---@diagnostic disable-next-line need-check-nil
					if client.server_capabilities.definitionProvider then
						vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
					end

					-- Keymaps
					local opts = { noremap = true, silent = true }
					vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
					vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
					vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
					vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
					vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
					vim.keymap.set("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
					vim.keymap.set("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
					vim.keymap.set(
						"n",
						"<space>wl",
						"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
						opts
					)
					vim.keymap.set("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
					vim.keymap.set("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
					vim.keymap.set("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
					vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
					vim.keymap.set("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
					vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.jump({count = -1, float = true})<CR>", opts)
					vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.jump({count = 1, float = true})<CR>", opts)
					vim.keymap.set("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
					-- also print "formatted!"
					vim.keymap.set(
						"n",
						"<space>ff",
						"<cmd>lua vim.lsp.buf.format( { async = true } ); print('formatted!')<CR>",
						opts
					)

					-- Enable inlay hints if supported
					if client.server_capabilities.inlayHintProvider then
						vim.lsp.inlay_hint.enable(false)
						vim.keymap.set(
							"n",
							"<leader>lh",
							"<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>",
							{ noremap = true, silent = true }
						)
					end

					-- Enable virtual text
					vim.diagnostic.config({
						virtual_text = true,
					})
				end,
			})

			vim.lsp.enable("clangd")
			vim.lsp.enable("yamlls")
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("pyright")
			vim.lsp.enable("ruff")
			vim.lsp.enable("starpls")
			vim.lsp.enable("beancount")
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("jsonls")
			vim.lsp.enable("ltex")
			vim.lsp.enable("bashls")
		end,
	},
	{
		"m-pilia/vim-ccls",
	},
	{
		"folke/lsp-colors.nvim",
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvimtools/none-ls-extras.nvim",
		},
		config = function()
			none_ls = require("null-ls")
			none_ls.setup({
				sources = {
					none_ls.builtins.code_actions.proselint,
					none_ls.builtins.diagnostics.actionlint,
					none_ls.builtins.diagnostics.bean_check,
					none_ls.builtins.diagnostics.codespell.with({
						extra_args = { "-L", "selectin,Bilt" },
					}),
					none_ls.builtins.diagnostics.cmake_lint,
					-- none_ls.builtins.diagnostics.proselint,
					none_ls.builtins.diagnostics.yamllint,
					require("none-ls.diagnostics.ruff").with({
						extra_args = { "--config", vim.fn.expand("~/.config/ruff.toml") },
					}),
					none_ls.builtins.formatting.bean_format,
					none_ls.builtins.formatting.black,
					none_ls.builtins.formatting.prettier,
					none_ls.builtins.formatting.clang_format,
					none_ls.builtins.formatting.stylua,
					none_ls.builtins.formatting.shfmt,
					require("none-ls.formatting.ruff").with({
						extra_args = { "--config", vim.fn.expand("~/.config/ruff.toml") },
					}),
					-- none_ls.builtins.diagnostics.pylint,
				},
				on_attach = function(client, bufnr)
					vim.api.nvim_buf_set_option(bufnr, "formatexpr", "")
				end,
			})
			vim.keymap.set("n", "<space>p", "<cmd>lua none_ls.toggle({})<CR>")
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
	{
		"p00f/clangd_extensions.nvim",
		ft = "cpp",
		config = function()
			-- Set <space>ch to switch header
			vim.keymap.set("n", "<space>ch", "<cmd>ClangdSwitchSourceHeader<CR>")
		end,
	},
}

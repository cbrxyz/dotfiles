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
			local configs = require("lspconfig/configs")
			local util = require("lspconfig/util")

			-- Enable LSP Status!
			local lsp_status = require("lsp-status")
			lsp_status.register_progress()

			lsp_status.config({
				indicator_errors = "",
				indicator_warnings = "",
				indicator_info = "",
				indicator_hint = "",
				indicator_ok = "Ok",
			})

			vim.diagnostic.config({
				virtual_text = true,
			})

			-- Use an on_attach function to only map the following keys
			-- after the language server attaches to the current buffer
			local on_attach = function(client, bufnr)
				local function buf_set_keymap(...)
					vim.api.nvim_buf_set_keymap(bufnr, ...)
				end
				local function buf_set_option(...)
					vim.api.nvim_buf_set_option(bufnr, ...)
				end

				-- Enable completion triggered by <c-x><c-o>
				buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

				-- Enable inlay hints if supported
				if client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(false)
					buf_set_keymap(
						"n",
						"<leader>lh",
						"<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>",
						{ noremap = true, silent = true }
					)
				end

				-- Mappings.
				local opts = { noremap = true, silent = true }

				-- See `:help vim.lsp.*` for documentation on any of the below functions
				buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
				buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
				buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
				buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
				buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
				buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
				buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
				buf_set_keymap(
					"n",
					"<space>wl",
					"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
					opts
				)
				buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
				buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
				buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
				buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
				buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
				buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.jump({count = -1, float = true})<CR>", opts)
				buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.jump({count = 1, float = true})<CR>", opts)
				buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
				-- also print "formatted!"
				buf_set_keymap(
					"n",
					"<space>ff",
					"<cmd>lua vim.lsp.buf.format( { async = true } ); print('formatted!')<CR>",
					opts
				)

				-- Add support for LSP Status
				lsp_status.on_attach(client)
			end
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config.clangd = {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"-j=16",
					"--malloc-trim",
					"--pch-storage=memory",
				},
				init_options = {
					InlayHints = {
						Designators = true,
						Enabled = true,
						ParameterNames = true,
						DeducedTypes = true,
					},
					fallbackFlags = { "-std=c++20" },
				},
				on_attach = on_attach,
				flags = {
					debounce_text_changes = 300,
				},
				capabilities = capabilities,
			}
			vim.lsp.enable("clangd")

			-- YAML lanaguage server
			vim.lsp.config.yamlls = {
				settings = {
					yaml = {
						schemaStore = {
							url = "https://www.schemastore.org/api/json/catalog.json",
							enable = true,
						},
					},
				},
				on_attach = on_attach,
				flags = {
					debounce_text_changes = 300,
				},
				capabilities = capabilities,
			}
			vim.lsp.enable("yamlls")

			-- Lua language server
			vim.lsp.config.lua_ls = {
				on_attach = on_attach,
				flags = {
					debounce_text_changes = 300,
				},
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim", "hs" },
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
								["/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/"] = true,
							},
						},
						telemetry = { enable = false },
					},
				},
			}
			vim.lsp.enable("lua_ls")

			-- Python language server
			vim.lsp.config.pyright = {
				single_file_support = false,
				root_dir = function(fname)
					return util.root_pattern("requirements.txt", "setup.py", ".git")(fname) or util.path.dirname(fname)
				end,
				on_attach = on_attach,
				flags = {
					debounce_text_changes = 300,
				},
				capabilities = capabilities,
			}
			vim.lsp.enable("pyright")

			vim.lsp.config.ruff = {
				cmd = { "ruff", "server" },
				filetypes = { "python" },
				on_attach = on_attach,
				flags = {
					debounce_text_changes = 300,
				},
				capabilities = capabilities,
			}
			vim.lsp.enable("ruff")

			-- Bazel language server
			vim.lsp.config.starpls = {
				cmd = { "starpls", "server", "--experimental_enable_label_completions" },
				on_attach = on_attach,
				flags = {
					debounce_text_changes = 300,
				},
				capabilities = capabilities,
			}
			vim.lsp.enable("starpls")

			-- Beancount language server
			-- vim.lsp.config.beancount = {
			--     on_attach = on_attach,
			--     flags = {
			--         debounce_text_changes = 300,
			--     },
			--     capabilities = capabilities,
			--     -- init_options = {
			--     --     -- current path of buffer
			--     --     journal_file = "~/cameron.beancount",
			--     -- }
			-- }
			vim.lsp.enable("beancount")

			-- Use a loop to conveniently call 'setup' on multiple servers and
			-- map buffer local keybindings when the language server attaches
			-- local standard_servers = { "ts_ls", "jsonls", "ltex", "bashls" }

			-- for _, lsp in ipairs(standard_servers) do
			-- 	nvim_lsp[lsp].setup({
			-- 		on_attach = on_attach,
			-- 		flags = {
			-- 			debounce_text_changes = 300,
			-- 		},
			-- 		capabilities = capabilities,
			-- 	})
			-- end
		end,
	},
	{
		"nvim-lua/lsp-status.nvim",
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

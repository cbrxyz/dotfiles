return {
	{
		"github/copilot.vim",
		config = function()
			vim.api.nvim_set_keymap("i", "jh", 'copilot#Accept("<CR>")', { expr = true, silent = true })
			-- Set g:copilot_proxy
			if vim.fn.has("macunix") == 1 then
				vim.g.copilot_proxy = "http://localhost:8999"
			end
		end,
		-- Conditionally load copilot based on security factors
		cond = function()
			local cwd = vim.fn.getcwd() -- vim.api.nvim_buf_get_name(0)

			-- Prohibited directories
			local prohibited = {
				"~/Library/Mobile Documents/iCloud~md~obsidian/Documents/vault",
				"~/resume",
				"~/homelab",
			}
			for _, dir in ipairs(prohibited) do
				if cwd:find(vim.fs.normalize(dir)) then
					return false
				end
			end

			-- Prohibited filenames
			local prohibited_filenames = {
				".env",
			}
			for _, filename in ipairs(prohibited_filenames) do
				if vim.fn.expand("%:t") == filename then
					return false
				end
			end

            -- Prohibited filetypes
            local prohibited_filetypes = {
                "beancount",
            }
            for _, filetype in ipairs(prohibited_filetypes) do
                if vim.bo.filetype == filetype then
                    return false
                end
            end
			return true
		end,
	},
	-- {
	-- 	"CopilotC-Nvim/CopilotChat.nvim",
	-- 	dependencies = {
	-- 		{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
	-- 		{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
	-- 	},
	-- 	build = "make tiktoken", -- Only on MacOS or Linux
	-- 	opts = {
	-- 		-- See Configuration section for options
	-- 	},
	-- 	-- See Commands section for default commands if you want to lazy load on them
	-- },
}

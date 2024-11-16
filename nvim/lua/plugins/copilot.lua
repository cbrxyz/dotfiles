-- return {
--     "zbirenbaum/copilot.lua",
--     cmd = "Copilot",
--     event = "InsertEnter",
--     config = function()
--         require("copilot").setup({
--             server_opts_overrides = {
--                 trace = "verbose",
--             },
--             copilot_node_command = "/opt/homebrew/bin/node",
--         })
--         vim.lsp.set_log_level('debug')
--     end,
-- }
return {
    "github/copilot.vim",
    config = function()
        vim.api.nvim_set_keymap('i', 'jh', 'copilot#Accept("<CR>")', { expr = true, silent = true })
        -- Set g:copilot_proxy
        vim.g.copilot_proxy = "http://localhost:8999"
    end,
    -- Conditionally load copilot based on security factors
    cond = function()
        local cwd = vim.fn.getcwd() -- vim.api.nvim_buf_get_name(0)

        -- Prohibited directories
        local prohibited = {
            "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/vault",
            "~/resume",
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
        return true
    end,
}

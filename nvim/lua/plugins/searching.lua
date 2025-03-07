return {
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- calling `setup` is optional for customization
            require("fzf-lua").setup({
                winopts = {
                    height = 0.75,
                    width = 0.75,
                    row = 0.5,
                    hl = { normal = "Pmenu" },
                    border = "none",
                },
                fzf_opts = {
                    ["--no-info"] = "",
                    ["--info"] = "hidden",
                    ["--padding"] = "13%,5%,13%,5%",
                    ["--header"] = " ",
                    ["--no-scrollbar"] = "",
                },
                files = {
                    formatter = "path.filename_first",
                    git_icons = true,
                    prompt = "files:",
                    no_header = true,
                    cwd_header = false,
                    cwd_prompt = false,
                    cwd = require("utils").git_root(),
                    actions = {
                        ["ctrl-d"] = function(...)
                            fzf.actions.file_vsplit(...)
                            vim.cmd("windo diffthis")
                            local switch = vim.api.nvim_replace_termcodes("<C-w>h", true, false, true)
                            vim.api.nvim_feedkeys(switch, "t", false)
                        end,
                    },
                },
            })
            -- <leader>zf to search files
            vim.api.nvim_set_keymap("n", "<leader>zf", "<cmd>lua require('fzf-lua').files()<cr>",
                { noremap = true, silent = true })
            -- <leader>zg to grep
            vim.api.nvim_set_keymap("n", "<leader>zg", "<cmd>lua require('fzf-lua').live_grep()<cr>",
                { noremap = true, silent = true })
            -- <leader>zd to search through definitions
            vim.api.nvim_set_keymap("n", "<leader>zd", "<cmd>lua require('fzf-lua').lsp_document_symbols()<cr>",
                { noremap = true, silent = true })
            -- <leader>ze to search through diagnostics (errors)
            vim.api.nvim_set_keymap("n", "<leader>ze", "<cmd>lua require('fzf-lua').lsp_document_diagnostics()<cr>",
                { noremap = true, silent = true })
            -- <leader>zE to search through diagnostics (all)
            vim.api.nvim_set_keymap("n", "<leader>zE", "<cmd>lua require('fzf-lua').lsp_workspace_diagnostics()<cr>",
                { noremap = true, silent = true })
            -- <leader>zc to search through config files
            vim.api.nvim_set_keymap("n", "<leader>zc", "<cmd>lua require('fzf-lua').files({cwd = \"~/.config\"})<cr>",
                { noremap = true, silent = true })
        end
    },
}

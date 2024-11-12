return {
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- calling `setup` is optional for customization
            require("fzf-lua").setup({})
            -- <leader>zf to search files
            vim.api.nvim_set_keymap("n", "<leader>zf", "<cmd>lua require('fzf-lua').files()<cr>", { noremap = true, silent = true })
            -- <leader>zg to search git files
            vim.api.nvim_set_keymap("n", "<leader>zg", "<cmd>lua require('fzf-lua').git_files()<cr>", { noremap = true, silent = true })
        end
    },
}

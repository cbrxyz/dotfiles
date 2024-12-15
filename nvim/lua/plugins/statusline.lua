return {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
        local function wordcount()
            return tostring(vim.fn.wordcount().words) .. ' words'
        end

        local function is_markdown()
            return vim.bo.filetype == "markdown" or vim.bo.filetype == "asciidoc"
        end

        require("lualine").setup({
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = {
                    { wordcount, cond = is_markdown },
                    'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
        })
    end,
}

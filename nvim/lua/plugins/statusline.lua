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

        require("lualine").setup({
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = {
                    { wordcount, cond = is_markdown },
                    'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location', { selection_count, cond = is_visual } }
            },
        })
    end,
}

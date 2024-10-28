return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup {
            size = 100,
            open_mapping = [[<C-\>]],
            direction = 'float',
            float_opts = {
                border = 'curved'
            }
        }
    end,
}

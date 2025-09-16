-- Enable syntax highlighting
vim.cmd("syntax on")

-- Basic settings
vim.o.number = true -- Line numbers
vim.o.relativenumber = true -- Relative line numbers
vim.o.swapfile = false -- Disable swapfile
vim.o.hlsearch = true -- Highlight search
vim.o.ignorecase = true -- Ignore case in search
vim.o.incsearch = true -- Incremental search
vim.o.hidden = true -- Allow hidden buffers
vim.o.tabstop = 4 -- Tab width
vim.o.softtabstop = 4 -- Soft tab width
vim.o.shiftwidth = 4 -- Shift width
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.smarttab = true -- Smart tab behavior
vim.o.autoindent = true -- Auto indent
vim.o.smartindent = true -- Smart indenting
vim.o.scrolloff = 8 -- Scroll offset
vim.o.signcolumn = "yes" -- Always show sign column
vim.o.colorcolumn = "80" -- Highlight column at 80 chars
vim.o.gdefault = true -- Global substitute by default
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

-- Backup and swap settings
vim.o.backup = false
vim.o.writebackup = false

-- UI Settings
vim.o.cmdheight = 2
vim.o.updatetime = 50
vim.opt.shortmess:append("c")
vim.o.clipboard = "unnamed"

-- Key mappings
vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true })
vim.g.mapleader = " "

-- Custom highlighting
vim.api.nvim_set_hl(0, "VirtualTextError", { link = "RedSign" })
vim.api.nvim_set_hl(0, "VirtualTextWarning", { link = "YellowSign" })
vim.api.nvim_set_hl(0, "VirtualTextInfo", { link = "BlueSign" })
vim.api.nvim_set_hl(0, "VirtualTextHint", { link = "Number" })

-- rbuf file
vim.filetype.add({
	extension = {
		rbuf = "rbuf",
	},
})

-- Light mode
vim.cmd([[
  function! LightMode()
    set background=light
    colorscheme edge
  endfunction
  command! Light call LightMode()
]])

-- Move between windows
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true })

-- Tab navigation
vim.api.nvim_set_keymap("n", "tn", ":tabn<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "tp", ":tabp<CR>", { noremap = true })

-- Folding setup
vim.o.foldmethod = "syntax"
vim.o.foldlevel = 99

-- Language-specific settings
vim.cmd([[
  augroup FileTypeSpecificAutocommands
    autocmd!
    autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType php setlocal tabstop=2 softtabstop=2 shiftwidth=2
  augroup END
]])

-- Auto-save
vim.cmd([[
  autocmd TextChanged,TextChangedI <buffer> if &readonly == 0 && filereadable(bufname('%')) | silent write | endif
]])

-- Move between windows
vim.api.nvim_set_keymap("n", "<leader>j", "<C-W><C-J>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>k", "<C-W><C-K>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>l", "<C-W><C-L>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>h", "<C-W><C-H>", { noremap = true, silent = true })

-- Terminal exit mapping
vim.api.nvim_set_keymap("t", "<C-Space>", [[<C-\><C-n>]], { noremap = true })

-- Persistent undo
vim.o.undodir = vim.fs.normalize("~/.vim_runtime/temp_dirs/undodir")
vim.o.undofile = true

-- Enable completion
vim.o.completeopt = "menu,menuone,noselect"

-- Plugins
require("config.lazy")
require("config.autocorrect")
require("config.quickfix")

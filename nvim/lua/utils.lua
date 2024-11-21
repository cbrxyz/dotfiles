local M = {}

M.git_root = function()
	local git_path = vim.fn.finddir(".git", ".;")
	return vim.fn.fnamemodify(git_path, ":h")
end



return M

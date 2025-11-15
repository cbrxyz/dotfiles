return {
	cmd = {
		"clangd",
		"-j=" .. 16,
		"--background-index",
		"--clang-tidy",
		"--completion-style=detailed",
		"--inlay-hints",
		"--malloc-trim",
		"--pch-storage=memory",
		"--log=verbose",
	},
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	init_options = {
		fallbackFlags = { "-std=c++20" },
	},
}

return {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"-j=16",
		"--malloc-trim",
		"--pch-storage=memory",
	},
	init_options = {
		InlayHints = {
			Designators = true,
			Enabled = true,
			ParameterNames = true,
			DeducedTypes = true,
		},
		fallbackFlags = { "-std=c++20" },
	},
}

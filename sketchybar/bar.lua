local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
	topmost = "window",
	height = 40,
	color = colors.bar.bg,
	padding_right = 0,
	padding_left = 0,
	margin = 0,
	-- corner_radius = 12,
	y_offset = 0,
	border_color = colors.transparent,
	border_width = 0,
	blur_radius = 30,
})

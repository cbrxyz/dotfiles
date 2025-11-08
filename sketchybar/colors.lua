local is_dark_mode = require("helpers.is_dark_mode") == "dark"

local colors = {
	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then
			return color
		end
		return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
	end,
}

local theme = {
	black = 0xff232136, -- Base
	white = 0xffe0def4, -- Text
	red = 0xffeb6f92, -- Love
	green = 0xff9ccfd8, -- Foam
	actually_green = 0xffa2d89c, -- Mint
	blue = 0xff3e8fb0, -- Pine
	yellow = 0xfff6c177, -- Gold
	orange = 0xffea9a97, -- Rose
	pink = 0xffc4a7e7, -- Iris
	purple = 0xffa581db,
	other_purple = 0xff2a273f, -- Surface
	cyan = 0xff6e6a86, -- Muted
	grey = 0xff908caa, -- Subtle
	dirty_white = 0xc8e0def4, -- Text with alpha
	dark_grey = 0xff2a283e, -- Highlight Low
	transparent = 0x00000000, -- Transparent
	bar = {
		bg = 0xf8400f32, -- Base with alpha
		border = 0xff2a273f, -- Surface
	},
	popup = {
		bg = 0xd3222136, -- Base with alpha
		border = 0xd32a273f, -- Surface with alpha
	},
	bg1 = 0x33232136, -- Base with low alpha
	bg2 = 0xff393552, -- Overlay
}

for k, v in pairs(theme) do
	colors[k] = v
end

if is_dark_mode then
	colors.fg = theme.bg2
	colors.fg_highlight = theme.purple
	colors.fg_secondary = theme.bg2
	colors.bg = theme.pink
	colors.border = theme.purple
	colors.active = theme.white
else
	colors.fg = theme.dark
	colors.fg_highlight = theme.github_blue
	colors.fg_secondary = theme.light_grey
	colors.bg = theme.light
	colors.border = theme.silver
	colors.active = theme.white
end

return colors

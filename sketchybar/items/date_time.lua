local settings = require("settings")
local colors = require("colors")

sbar.add("item", { position = "right", width = settings.group_paddings })

-- Date item
local date_date = sbar.add("item", "widgets.date_date", {
	position = "right",
	padding_left = 5,
	padding_right = 5,
	width = 0,
	icon = {
		color = colors.white,
		padding_right = 0, -- Remove padding to avoid separation
		font = {
			style = settings.font.style_map["Black"],
			size = 9.0,
		},
		string = os.date("%a %b %d %Y"),
	},
	label = {
		drawing = false, -- Hide label for date item as it's using the icon
	},
	y_offset = 5, -- Adjust to overlap with time
	update_freq = 60,
})

-- Time item
local date_time = sbar.add("item", "widgets.date_time", {
	position = "right",
	padding_left = -5,
	label = {
		color = colors.white,
		padding_right = 0, -- Remove padding to bring time closer
		font = {
			family = settings.font.numbers,
			size = 9.0,
		},
		string = os.date("%I:%M:%S%p"),
	},
	icon = {
		drawing = false, -- Hide icon for time item as it's using the label
	},
	y_offset = -5, -- Adjust to overlap with date
	update_freq = 1,
})

-- Bracket to group date and time items
local date_bracket = sbar.add("bracket", "widgets.date_bracket", {
	date_date.name,
	date_time.name,
}, {
	background = {
		color = colors.bg2,
		height = 29,
	},
})

-- Padding item required because of bracket
sbar.add("item", { position = "right", width = 40 })

-- Update both items with current date and time
local function update_calendar()
	date_date:set({ icon = { string = os.date("%a %b %d %Y") } })
	date_time:set({ label = { string = os.date("%I:%M:%S%p") } })
end

date_date:subscribe({ "forced", "routine", "system_woke" }, update_calendar)
date_time:subscribe({ "forced", "routine", "system_woke" }, update_calendar)

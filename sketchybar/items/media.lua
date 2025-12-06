local icons = require("icons")
local colors = require("colors")

local whitelist = { ["Spotify"] = true, ["Music"] = true }

local media_cover = sbar.add("item", {
	position = "right",
	background = {
		image = {
			string = "media.artwork",
			scale = 0.85,
		},
		color = colors.transparent,
	},
	label = { drawing = false },
	icon = { drawing = false },
	drawing = false,
	updates = true,
	popup = {
		align = "center",
		horizontal = true,
	},
})

local media_artist = sbar.add("item", {
	position = "right",
	drawing = false,
	padding_left = 3,
	padding_right = 0,
	width = 0,
	icon = { drawing = false },
	label = {
		width = 0,
		font = { size = 9 },
		color = colors.with_alpha(colors.bg2, 0.8),
		max_chars = 18,
		y_offset = 6,
	},
})

local media_title = sbar.add("item", {
	position = "right",
	drawing = false,
	padding_left = 3,
	padding_right = 0,
	icon = { drawing = false },
	label = {
		color = colors.with_alpha(colors.bg2, 0.8),
		font = { size = 11 },
		width = 0,
		max_chars = 16,
		y_offset = -5,
	},
})

sbar.add("item", {
	position = "popup." .. media_cover.name,
	icon = { string = icons.media.back },
	label = { drawing = false },
	click_script = "nowplaying-cli previous",
})
sbar.add("item", {
	position = "popup." .. media_cover.name,
	icon = { string = icons.media.play_pause },
	label = { drawing = false },
	click_script = "nowplaying-cli togglePlayPause",
})
sbar.add("item", {
	position = "popup." .. media_cover.name,
	icon = { string = icons.media.forward },
	label = { drawing = false },
	click_script = "nowplaying-cli next",
})

local interrupt = 0
local function animate_expand(expanded)
	if not expanded then
		interrupt = interrupt - 1
	end
	if interrupt > 0 and not expanded then
		return
	end

	sbar.animate("sin", 30, function()
		media_artist:set({ label = { width = expanded and "dynamic" or 0 } })
		media_title:set({ label = { width = expanded and "dynamic" or 0 } })
	end)
end

media_cover:subscribe("media_change", function(env)
	if whitelist[env.INFO.app] then
		local currently_playing = (env.INFO.state == "playing")
		media_artist:set({ drawing = currently_playing, label = env.INFO.artist })
		media_title:set({ drawing = currently_playing, label = env.INFO.title })
		media_cover:set({ drawing = currently_playing })

		if currently_playing then
			animate_expand(true)
			interrupt = interrupt + 1
			sbar.delay(5, animate_expand)
		else
			media_cover:set({ popup = { drawing = false } })
		end
	end
end)

media_cover:subscribe("mouse.entered", function(env)
	interrupt = interrupt + 1
	animate_expand(true)
end)

media_cover:subscribe("mouse.exited", function(env)
	animate_expand(false)
end)

media_cover:subscribe("mouse.clicked", function(env)
	media_cover:set({ popup = { drawing = "toggle" } })
end)

media_title:subscribe("mouse.exited.global", function(env)
	media_cover:set({ popup = { drawing = false } })
end)

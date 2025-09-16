local icons = require("icons")
local colors = require("colors")
local settings = require("settings")
local http_request = require("http.request")

-- Define the weather item
local weather = sbar.add("item", "widgets.weather", {
	position = "right",
	icon = {
		font = {
			style = settings.font.style_map["Regular"],
			size = 19.0,
		},
		color = colors.dirty_white,
		icon = "􀖇",
	},
	label = { font = { family = settings.font.numbers } },
	update_freq = 300, -- Update every 10 minutes
	popup = { align = "center" },
})

-- Function to get weather data
local function update_weather()
	sbar.exec("/usr/local/bin/whereami", function(output)
		local lat, lon = output:match("Latitude: (-?%d+%.%d+).*Longitude: (-?%d+%.%d+)")
		lat = lat or 33.44
		lon = lon or -94.04
		-- Cap to 2 decimal places
		lat = tonumber(string.format("%.2f", lat))
		lon = tonumber(string.format("%.2f", lon))
		local url = "http://api.openweathermap.org/data/2.5/weather?lat="
			.. lat
			.. "&lon="
			.. lon
			.. "&units=imperial&appid=$OPENWEATHERMAP_API_KEY"
		local req = http_request.new_from_uri(url)
		local headers, stream = req:go()

		if headers:get(":status") ~= "200" then
			local body = assert(stream:get_body_as_string())
			local data = body and require("dkjson").decode(body) -- Use dkjson for JSON parsing
			weather:set({
				icon = { string = icons.weather.error, color = colors.red },
				label = { string = "N/A" },
			})
			return
		end

		local body = assert(stream:get_body_as_string())
		local data = body and require("dkjson").decode(body) -- Use dkjson for JSON parsing

		if data and data.main and data.weather then
			local feels_like = math.floor(data.main.feels_like)
			local icon_code = data.weather[1].icon
			local icon_map = {
				["01d"] = icons.weather.clear_day,
				["01n"] = icons.weather.clear_night,
				["02d"] = icons.weather.partly_cloudy_day,
				["02n"] = icons.weather.partly_cloudy_night,
				["03d"] = icons.weather.cloudy,
				["03n"] = icons.weather.cloudy,
				["04d"] = icons.weather.overcast,
				["04n"] = icons.weather.overcast,
				["09d"] = icons.weather.rain_showers,
				["09n"] = icons.weather.rain_showers,
				["10d"] = icons.weather.rain,
				["10n"] = icons.weather.rain,
				["11d"] = icons.weather.thunderstorm,
				["11n"] = icons.weather.thunderstorm,
				["13d"] = icons.weather.snow,
				["13n"] = icons.weather.snow,
				["50d"] = icons.weather.mist,
				["50n"] = icons.weather.mist,
			}
			local colors = {
				["01d"] = colors.yellow,
				["01n"] = colors.dirty_white,
				["02d"] = colors.yellow,
				["02n"] = colors.dirty_white,
				["03d"] = colors.grey,
				["03n"] = colors.grey,
				["04d"] = colors.dirty_white,
				["04n"] = colors.dirty_white,
				["09d"] = colors.blue,
				["09n"] = colors.blue,
				["10d"] = colors.blue,
				["10n"] = colors.blue,
				["11d"] = colors.purple,
				["11n"] = colors.purple,
				["13d"] = colors.white,
				["13n"] = colors.white,
				["50d"] = colors.dirty_white,
				["50n"] = colors.dirty_white,
			}

			local icon = icon_map[icon_code] or icons.weather.unknown
			local color = colors[icon_code] or colors.grey

			weather:set({
				icon = {
					string = icon,
					color = color,
				},
				label = { string = feels_like .. "°F" },
			})
		else
			weather:set({
				icon = { string = icons.weather.error, color = colors.red },
				label = { string = "N/A" },
			})
		end
	end)
end

-- Subscribe to update the weather periodically
weather:subscribe("routine", update_weather)
update_weather() -- Initial call to set the data

-- Optional: Mouse click to toggle a detailed popup (e.g., humidity, pressure, etc.)
weather:subscribe("mouse.clicked", function(env)
	local drawing = weather:query().popup.drawing
	weather:set({ popup = { drawing = "toggle" } })

	if drawing == "off" then
		-- Fetch and display additional weather info if desired, using same API call and parsing
		-- This part is optional and can be extended
	end
end)

-- Add padding and styling
sbar.add("bracket", "widgets.weather.bracket", { weather.name }, {
	background = { color = colors.bg2 },
})

sbar.add("item", "widgets.weather.padding", {
	position = "right",
	width = settings.group_paddings,
})

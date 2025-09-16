local sbar = require("sketchybar")
local colors = require("colors") -- Assuming `colors` module includes `BLUE`
local inspect = require("inspect")

-- Helper function to parse command output into a table
function parse_string_to_table(s)
	local result = {}
	local count = 0
	for line in s:gmatch("([^\n]+)") do
		if count < 16 then
			table.insert(result, line)
		end
		count = count + 1
	end
	return result
end

-- Fetch workspace names using aerospace
local file = io.popen("aerospace list-workspaces --all")
local result = file:read("*a")
file:close()
local workspaces = parse_string_to_table(result)
local sketchy_workspaces = {}

-- Initialize each workspace with styling and subscription to workspace change events
for i, workspace in ipairs(workspaces) do
	print(i)
	local space = sbar.add("space", "space." .. i, {
		associated_space = i,
		icon = {
			string = i,
			highlight_color = 0xFFFFFFFF,
			align = "center",
			width = 30,
		},
		background = {
			color = 0xEB1e1e2e,
			corner_radius = 15,
			border_width = 1,
			border_color = colors.pink,
		},
		label = { drawing = false },
	})
	sketchy_workspaces[i] = space.name
end

-- Create a bracket to group space items with background styling
-- local space_bracket = sbar.add("bracket", "spaces", sketchy_workspaces, {
--     background = {
--         color = 0xEB1e1e2e,
--         corner_radius = 15,
--         border_width = 1,
--         border_color = colors.yellow,
--     },
--     blur_radius = 2,
--     background_height = 30,
-- })

-- Add highlight dot for the active workspace
--local highlight_space = sbar.add("item", "highlight_space", {
--    width = 22,
--    background = {
--        color = colors.yellow,
--        height = 22,
--        corner_radius = 11,
--    },
--})
--
---- Update highlight position based on the focused workspace in aerospace
--highlight_space:subscribe("aerospace_workspace_change", function(env)
--    local sid = env.FOCUSED_WORKSPACE
--
--    -- Adjust padding to align the highlight space dot based on position
--    local length = #workspaces
--    local padding_left = -(length - (sid)) * 30 + 7
--    sbar.animate("circ", 15, function()
--        highlight_space:set({
--            background = {
--                padding_left = padding_left
--            }
--        })
--    end)
--end)

-- Initialize each workspace with styling and subscription to workspace change events
for i, workspace in ipairs(workspaces) do
	-- Secondary space overlay items with numbers on top of the highlight
	print(workspace)
	local overlay_space = sbar.add("space", "space_ex." .. i, {
		associated_space = i,
		icon = {
			string = workspace,
			highlight_color = 0xFFFFFFFF,
			padding_left = 2,
			color = colors.pink,
			align = "center",
			width = 30,
		},
		label = { drawing = false },
		click_script = "aerospace focus " .. i, -- Command to switch workspace using aerospace
		padding_left = 2,
		padding_right = 2,
	})
end

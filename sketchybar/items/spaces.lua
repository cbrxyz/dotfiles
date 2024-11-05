local colors = require("colors")

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

local file = io.popen("aerospace list-workspaces --all")
local result = file:read("*a")
file:close()

local workspaces = parse_string_to_table(result)
for i, workspace in ipairs(workspaces) do
    local space = sbar.add("item", "space." .. i, {
        icon = {
            string = workspace,
            color = colors.white,
            highlight_color = colors.red,
        },
        label = { drawing = false },
        padding_left = 2,
        padding_right = 2,
    })

    space:subscribe("aerospace_workspace_change", function(env)
        local selected = env.FOCUSED_WORKSPACE == workspace
        space:set({
            icon = { highlight = selected, },
            label = { highlight = selected },
            background = {
                border_color = selected and colors.white or colors.bg2,
            }
        })
    end)
end


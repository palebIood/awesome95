-- Standard awesome library
local awful = require("awful")

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get()
    local tags = {}
    local tagpairs = {
        --names
        names = {
            "春天", "夏天", "秋天",
            "冬天", -- "nombre5", "nombre6",
            -- "nombre7", "nombre8", "nombre9",
        },

        layout = {
            RC.layouts[1], RC.layouts[4], RC.layouts[4],
            RC.layouts[4], -- RC.layouts[9], RC.layouts[9],
            -- RC.layouts[9], RC.layouts[9], RC.layouts[9],
        }
    }

    awful.screen.connect_for_each_screen(function(s)
        -- Each screen has its own tag table.
        tags[s] = awful.tag(tagpairs.names, s, tagpairs.layout)
    end)

    return tags
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable(
    {},
    { __call = function(_, ...) return _M.get(...) end }
)

-- Standard awesome library
local gears            = require("gears")
local awful            = require("awful")

-- Wibox handling library
local wibox            = require("wibox")
--local lain             = require("lain")

-- Custom Local Library: Wallpaper, Keys and Mouse Binding
local deco             = {
    wallpaper = require("deco.wallpaper"),
    taglist   = require("deco.taglist"),
    tasklist  = require("deco.tasklist")
}

local taglist_buttons  = deco.taglist()
local tasklist_buttons = deco.tasklist()


local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local WB = {}

wibox_package = WB -- global object name

-- default statusbar
require("statusbar.default.helper_default")
require("statusbar.default.helper_empty")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Wibar

function WB.setup_common_boxes(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Create a promptbox for each screen
    s.promptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.layoutbox = awful.widget.layoutbox(s)
    s.layoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)
    ))

    -- Create a taglist widget
    s.taglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = WB.taglist
    }

    -- Create a tasklist widget
    s.tasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = WB.tasklist
    }
end

-- }}}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Main
function _M.init()
    WB.taglist  = deco.taglist()
    WB.tasklist = deco.tasklist()

    WB.initdeco()

    awful.screen.connect_for_each_screen(function(s)
        WB.setup_common_boxes(s)

        -- Create the top wibox
        WB.generate_wibox_one(s)

        -- Create the bottom wibox
        WB.generate_wibox_two(s)
    end)
end

-- }}}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.init(...) end })

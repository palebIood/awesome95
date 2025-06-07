-- {{{ Required libraries
-- Standard awesome library
local awful     = require("awful")
local beautiful = require("beautiful")

-- Wibox handling library
local wibox     = require("wibox")
local lain      = require("lain")

-- Custom Local Library
require("statusbar.default.lain")
local gmc = require("themes.clone.gmc")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local WB  = wibox_package

function WB.initdeco()
    -- Spacer
    WB.spacer         = wibox.widget.textbox(" ")
    WB.spacerline     = wibox.widget.textbox(" | ")

    -- Separators lain
    local separators  = lain.util.separators
    local arrow_color = gmc.color['red300']
    WB.arrow_dl       = separators.arrow_left("alpha", arrow_color)
    WB.arrow_ld       = separators.arrow_left(arrow_color, "alpha")
    WB.arrow_dr       = separators.arrow_right("alpha", arrow_color)
    WB.arrow_rd       = separators.arrow_right(arrow_color, "alpha")
end

-- Create a textclock widget
mytextclock      = wibox.widget.textclock()

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()
bgWidgetEnd      = wibox.widget {
    image = beautiful.widgetEndBG,
    resize = true,
    widget = wibox.widget.imagebox,
}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function WB.add_widgets_left(line, s)
    return { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        RC.launcher,
        wibox.widget.textbox(" | "),
        line.taglist,
        wibox.widget.textbox(" | "),
        line.promptbox,
        WB.spacer,
    }
end

function WB.add_widgets_middle(line, s)
    local cws     = clone_widget_set
    local cis     = clone_icon_set
    local spotify = require("statusbar.default.lain-sound")

    markup        = lain.util.markup
    return {
        layout = wibox.layout.fixed.horizontal,
        --  mpd
        cis.volume,
        cws.volume,
        cis.volume_dynamic,
        cws.volumewidget,
        spotify.icon,
        spotify.widget,
        cis.mpd,
        cws.mpd,
        bgWidgetEnd,
    } --s.tasklist -- Middle widget
end

function WB.add_widgets_right(line, s)
    local cws  = clone_widget_set
    local cis  = clone_icon_set
    local wifi = require("statusbar.default.WIFIwidget")
    markup     = lain.util.markup


    return { -- Right widgets
        layout = wibox.layout.fixed.horizontal,

        --Inician lain widgets
        --wifi

        wifi,
        wibox.widget.textbox("  "),
        bgWidgetEnd,
        --  net
        wibox.widget.textbox("  "),
        cis.netdown,
        cws.netdowninfo,
        cis.netup,
        cws.netupinfo,
        cis.mem,
        cws.mem,
        cis.cpu,
        cws.cpu,
        cis.fs,
        cws.fs,
        cis.temp,
        cws.temp,
        cis.bat,
        cws.bat,
        bgWidgetEnd,

        --otros widget
        --  wheather
        --wibox.widget.textbox("  "),
        --cis.weather,
        --cws.weather,
        --bgWidgetEnd,


        --mykeyboardlayout,
        wibox.widget.textbox("  "),
        cis.clock,
        cws.textclock,
        wibox.widget.systray(),
        line.layoutbox,
    }
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function WB.generate_wibox_one(s)
    -- layout: l_left, tasklist, l_right

    -- Create the wibox
    s.wibox_top = awful.wibar({ position = "top", screen = s, height = 25 })

    -- Add widgets to the wibox
    s.wibox_top:setup {
        layout = wibox.layout.align.horizontal,
        WB.add_widgets_left(s),
        WB.add_widgets_middle(s),
        WB.add_widgets_right(s),
    }
end

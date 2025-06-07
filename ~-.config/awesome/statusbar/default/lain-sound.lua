--[[
     Original Source Modified From: github.com/copycat-killer
     https://github.com/copycat-killer/awesome-copycats/blob/master/rc.lua.copland
--]]

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Standard awesome library
local beautiful = require("beautiful")
local bfont = beautiful.font
local gears = require("gears")
local awful = require("awful")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

-- Wibox handling library
local wibox = require("wibox")
local lain = require("lain")

local W = clone_widget_set -- object name
local I = clone_icon_set   -- object name

-- Custom Local Library
local gmc = require("themes.clone.gmc")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- ALSA volume from copycat-multicolor
I.volume = wibox.widget.imagebox(beautiful.widget_vol)

W.volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volume_now.level = volume_now.level .. "M"
        end

        widget:set_markup(markup(gmc.color['Highlight'], volume_now.level .. "% "))
    end
})

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- ALSA volume bar

-- global terminal is required in alsabar, unfortunately
terminal = RC.vars.terminal

-- ALSA volume bar from copycat-copland

I.volume_dynamic = wibox.widget.imagebox(beautiful.monitor_vol)

local volume_wibox_settings = function()
    if volume_now.status == "off" then
        I.volume_dynamic:set_image(beautiful.monitor_vol_mute)
    elseif volume_now.level == 0 then
        I.volume_dynamic:set_image(beautiful.monitor_vol_no)
    elseif volume_now.level <= 50 then
        I.volume_dynamic:set_image(beautiful.monitor_vol_low)
    else
        I.volume_dynamic:set_image(beautiful.monitor_vol)
    end
end

local volume_wibox_colors = {
    background = beautiful.bg_normal,
    mute = gmc.color['red700'],
    unmute = gmc.color['Highlight']
}

W.volume_wibox = lain.widget.alsabar({
    width = 55,
    ticks = true,
    ticks_size = 6,
    step = "2%",
    settings = volume_wibox_settings,
    colors = volume_wibox_colors
})

W.volume_wibox_buttons = my_table.join(
    awful.button({}, 1, function()
        awful.spawn(string.format("%s -e alsamixer", terminal))
    end),
    awful.button({}, 2, function()
        os.execute(string.format("%s set %s 100%%", W.volume_wibox.cmd, W.volume_wibox.channel))
        W.volume_wibox.update()
    end),
    awful.button({}, 3, function()
        os.execute(string.format("%s set %s toggle", W.volume_wibox.cmd,
            W.volume_wibox.togglechannel or W.volume_wibox.channel))
        W.volume_wibox.update()
    end),
    awful.button({}, 4, function()
        os.execute(string.format("%s set %s 1%%+", W.volume_wibox.cmd, W.volume_wibox.channel))
        W.volume_wibox.update()
    end),
    awful.button({}, 5, function()
        os.execute(string.format("%s set %s 1%%-", W.volume_wibox.cmd, W.volume_wibox.channel))
        W.volume_wibox.update()
    end)
)

W.volume_wibox.tooltip.wibox.fg = beautiful.fg_focus

W.volume_wibox.bar:buttons(W.volume_wibox_buttons)

W.volumebg = wibox.container.background(
    W.volume_wibox.bar, gmc.color['grey500'], gears.shape.rectangle)
W.volumewidget = wibox.container.margin(
    W.volumebg, dpi(2), dpi(7), dpi(6), dpi(6))

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- MPD from copycat-multicolor

I.mpd = wibox.widget.imagebox(beautiful.widget_note)
W.mpd = lain.widget.mpd({
    settings = function()
        mpd_notification_preset = {
            text = string.format("%s [%s] - %s\n%s", mpd_now.artist,
                mpd_now.album, mpd_now.date, mpd_now.title)
        }

        if mpd_now.state == "play" then
            artist = mpd_now.artist .. " > "
            title  = mpd_now.title .. " "
            I.mpd:set_image(beautiful.widget_note_on)
        elseif mpd_now.state == "pause" then
            artist = "mpd "
            title  = "paused "
        else
            artist = ""
            title  = ""
            I.mpd:set_image(nil)
        end
        widget:set_markup(markup(gmc.color['blue900'], artist)
            .. markup(gmc.color['green900'], title))
    end
})

--Spotify Script
local spotify_icon = wibox.widget.imagebox(beautiful.widget_note or beautiful.widget_music)

local spotify_widget = wibox.widget {
    widget = wibox.widget.textbox,
    font = beautiful.font or "Sans 10",
    align = "left",
    valign = "center",
}

local function update_spotify()
    awful.spawn.easy_async_with_shell(
        "playerctl --player=spotify metadata --format '{{artist}} - {{title}}'",
        function(stdout)
            local text = stdout:gsub("\n", "")
            if text == "" then
                spotify_icon:set_image(nil)
                spotify_widget:set_markup("")
            else
                spotify_icon:set_image(beautiful.widget_note_on or beautiful.widget_music)
                spotify_widget:set_markup("<span foreground='" .. gmc.color['Highlight'] .. "'>► " .. text .. "</span>")
            end
        end
    )
end

-- Timer to update widget every 5 seconds
gears.timer {
    timeout = 5,
    autostart = true,
    call_now = true,
    callback = update_spotify
}

return {
    icon = spotify_icon,
    widget = spotify_widget
}

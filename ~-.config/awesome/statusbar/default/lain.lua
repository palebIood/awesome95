--[[
     Original Source Modified From: github.com/copycat-killer
     https://github.com/copycat-killer/awesome-copycats/blob/master/rc.lua.multicolor
--]]

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Standard awesome library
local awful       = require("awful")
local beautiful   = require("beautiful")
local gears       = require("gears")

-- Wibox handling library
local wibox       = require("wibox")
local lain        = require("lain")

-- Custom Local Library
local gmc         = require("themes.clone.gmc")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local W           = {}
clone_widget_set  = W -- object name

local I           = {}
clone_icon_set    = I -- object name

-- split module, to make each file shorter,
-- all must have same package name

-- global for all splited
markup            = lain.util.markup

-- progress bar related widgets -- after global markup
local config_path = awful.util.getdir("config") .. "statusbar/default/"
dofile(config_path .. "lain-sound.lua")
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- MEM
I.mem = wibox.widget {
    image = beautiful.widget_mem,
    resize = true,
    widget = wibox.widget.imagebox,
}
W.mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup(gmc.color['blue900'], mem_now.used .. "M "))
    end
})

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- CPU
I.cpu = wibox.widget.imagebox()
I.cpu:set_image(beautiful.widget_cpu)

W.cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup(gmc.color['green900'], cpu_now.usage .. "% "))
    end
})

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Coretemp
I.temp = wibox.widget.imagebox(beautiful.widget_temp)
W.temp = lain.widget.temp({
    settings = function()
        local color = gmc.color['blue700'] -- cyan por defecto

        local temp_num = tonumber(coretemp_now)
        if temp_num then
            if temp_num >= 80 then
                color = gmc.color['red700']    -- rojo
            elseif temp_num >= 60 then
                color = gmc.color['orange900'] -- naranja
            elseif temp_num >= 40 then
                color = gmc.color['lime900']   -- amarillo
            end
        else
            coretemp_now = "N/A"
            color = gmc.color['black'] -- gris
        end

        widget:set_markup(markup(color, coretemp_now .. "°C "))
    end
})

-- Battery from copycat-multicolor

I.bat = wibox.widget.imagebox(beautiful.widget_batt)

W.bat = lain.widget.bat({
    settings = function()
        if bat_now.perc == "N/A" then
            perc = "AC "
        else
            perc = bat_now.perc .. "% "
        end
        widget:set_markup(markup(gmc.color['blue900'], perc))
    end
})
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Textclock
I.clock = wibox.widget.imagebox(beautiful.widget_clock)

W.textclock = awful.widget.textclock(
    markup(gmc.color['blue900'], "%A %d %B ")
    .. markup(gmc.color['black'], ">")
    .. markup(gmc.color['green900'], " %H:%M "))

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Calendar

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Weather
I.weather = wibox.widget.imagebox(beautiful.widget_weather)

W.weather = lain.widget.weather({
    city = MXDF, -- http://openweathermap.org/city/1642911
    settings = function()
        descr = weather_now["weather"][1]["description"]:lower()
        units = math.floor(weather_now["main"]["temp"])
        local fg_color = "#000000" -- "#eca4c4"
        widget:set_markup(markup(fg_color, descr .. " @ " .. units .. "°C "))
    end
})


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Net
I.netdown = wibox.widget.imagebox(beautiful.widget_netdown)
--netdownicon.align = "middle"

W.netdowninfo = wibox.widget.textbox()

I.netup = wibox.widget.imagebox(beautiful.widget_netup)
--netupicon.align = "middle"

W.netupinfo = lain.widget.net({
    settings = function()
        --        if iface ~= "network off" and
        --           string.match(myweather._layout.text, "N/A")
        --        then
        --            myweather.update()
        --        end

        local fg_color_up   = "#000000" -- "#e54c62"
        local fg_color_down = "#000000" -- "#87af5f"
        widget:set_markup(markup(fg_color_up, net_now.sent .. " "))
        W.netdowninfo:set_markup(markup(fg_color_down, net_now.received .. " "))
    end
})
--[[
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
-- ALSA volume from copycat-multicolor
I.volume = wibox.widget.imagebox(beautiful.widget_vol)

W.volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volume_now.level = volume_now.level .. "M"
        end

        widget:set_markup(markup(gmc.color['blue900'], volume_now.level .. "% "))
    end
})
]]
--File System
I.fs = wibox.widget.imagebox(beautiful.widget_fs)

-- Can't create more than one fs widget
W.fs = lain.widget.fs({
    settings = function()
        local root = fs_now["/"]
        local home = fs_now["/home"]
        local data = fs_now["/mnt/data"]

        local output = ""

        if root then
            output = output .. "Root: " .. root.percentage .. "% "
        end

        if data then
            output = output .. "Data: " .. data.percentage .. "% "
        end

        if home then
            output = output .. "Home: " .. home.percentage .. "% "
        end

        widget:set_markup(markup(gmc.color['Highlight'], output))
    end
})

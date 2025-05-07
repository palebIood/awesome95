local awful        = require("awful")
local wibox        = require("wibox")
local gears        = require("gears")
local beautiful    = require("beautiful")

local gmc          = require("themes.clone.gmc")

local wifi_icon    = wibox.widget.imagebox(beautiful.widget_wifi)

local wifi_text    = wibox.widget {
    widget = wibox.widget.textbox,
    markup = "test0",
    font = beautiful.font or "Sans 10",
    align = "left",
    valign = "center",
}

local wifi_widget  = wibox.widget {
    wifi_icon,
    wifi_text,
    layout = wibox.layout.fixed.horizontal
}

local wifi_tooltip = awful.tooltip {
    objects = { wifi_widget }, -- el widget al que le quieres poner el tooltip
    timer_function = function()
        -- Lo que quieras que diga el tooltip
        return "..."
    end
}

-- Función que actualiza el nombre del Wi-Fi
local function update_wifi()
    awful.spawn.easy_async_with_shell(
        "nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2",
        function(stdout)
            local ssid = stdout:gsub("\n", ""):gsub("^%s*(.-)%s*$", "%1")
            if ssid == "" then
                --wifi_text:set_markup("test1")

                wifi_text:set_text("   No conectado")
            else
                --wifi_text:set_markup("test2")

                wifi_text:set_text(" " .. ssid)
            end
        end
    )
end

-- Actualizar cada 15 segundos
gears.timer {
    timeout = 15,
    autostart = true,
    call_now = true,
    callback = update_wifi
}

-- Hacer clic para abrir nmtui

wifi_widget:buttons(gears.table.join(
    awful.button({}, 1, function()
        awful.spawn(terminal .. " -e nmtui")
    end)
))


return wifi_widget

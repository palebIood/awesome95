local awful     = require("awful")
local wibox     = require("wibox")
local gears     = require("gears")
local beautiful = require("beautiful")

local gmc       = require("themes.clone.gmc")

local wifi_icon = wibox.widget.imagebox(beautiful.widget_wifi)

local wifi_text = wibox.widget {
    widget = wibox.widget.textbox,
    markup = "test0",
    font = beautiful.font or "Sans 10",
    align = "left",
    valign = "center",
}




local wifi_signal  = wibox.widget {
    widget = wibox.widget.textbox,
    align = "center"
}

local wifi_widget  = wibox.widget {
    wifi_icon,
    wifi_text,
    wifi_signal,
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

-- Funcion que actualiza la potencia de señal
local function update_wifi_signal()
    awful.spawn.easy_async_with_shell(
        "nmcli -t -f active,signal dev wifi | grep '^yes' | cut -d: -f2",
        function(stdout)
            local quality = tonumber(stdout) or 0
            wifi_signal:set_text(" | " .. quality .. "% |")
        end
    )
end

-- Actualizar cada 10 segundos
gears.timer {
    timeout = 10,
    autostart = true,
    call_now = true,
    callback = update_wifi
}

local wifi_timer = timer({ timeout = 10 })
wifi_timer:connect_signal("timeout", update_wifi_signal)
wifi_timer:start()
update_wifi_signal()

-- Hacer clic para abrir nmtui

wifi_widget:buttons(gears.table.join(
    awful.button({}, 1, function()
        awful.spawn(terminal .. " -e nmtui")
    end)
))


return wifi_widget

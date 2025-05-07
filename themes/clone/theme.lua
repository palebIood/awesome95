local awful = require("awful")
awful.util = require("awful.util")

theme_path = awful.util.getdir("config") .. "/themes/clone/"

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- default variables

theme = {}

dofile(theme_path .. "elements.lua")
dofile(theme_path .. "titlebar.lua")
dofile(theme_path .. "layouts.lua")
dofile(theme_path .. "icons.lua")

theme.wallpaper       = theme_path .. "background.jpg"
theme.awesome_icon    = theme_path .. "launcher/desktop.png"
theme.awesome_subicon = theme_path .. "launcher/desktop.png"

theme.arrow_lr_thick  = theme_path .. "misc/clone/arrow_lr_thick.png"
theme.arrow_lr_thin   = theme_path .. "misc/clone/arrow_lr_thin.png"
theme.arrow_lr_pre    = theme_path .. "misc/clone/arrow_lr_pre.png"
theme.arrow_lr_post   = theme_path .. "misc/clone/arrow_lr_post.png"
theme.arrow_rl_thick  = theme_path .. "misc/clone/arrow_rl_thick.png"
theme.arrow_rl_thin   = theme_path .. "misc/clone/arrow_rl_thin.png"
theme.arrow_rl_pre    = theme_path .. "misc/clone/arrow_rl_pre.png"
theme.arrow_rl_post   = theme_path .. "misc/clone/arrow_rl_post.png"

theme.widgetBeginBG   = theme_path .. "misc/clone/widgetbg1.png"
theme.widgetEndBG     = theme_path .. "misc/clone/widgetbg2.png"

return theme

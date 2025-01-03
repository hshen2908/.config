-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Vicious Widget
local vicious = require("vicious")

local separatorwidget = wibox.widget.textbox("|")
separatorwidget.font = "RobotoMono Nerd Font Mono 8"

local clockwidget = wibox.widget.textbox()
clockwidget.font = "RobotoMono Nerd Font Mono 8"
vicious.cache(vicious.widgets.uptime)
vicious.register(clockwidget, vicious.widgets.date, "%F %T", 1)

local utmwidget = wibox.widget.textbox()
utmwidget.font = "RobotoMono Nerd Font Mono 8"
vicious.cache(vicious.widgets.uptime)
vicious.register(utmwidget, vicious.widgets.uptime, "UTM: $2H", 1800)

-- local pkgwidget = wibox.widget.textbox()
-- pkgwidget.font = "RobotoMono Nerd Font Mono 8"
-- vicious.cache(vicious.widgets.pkg)
-- vicious.register(pkgwidget, vicious.widgets.pkg, "PKG: $1", 3600, "Arch")

local cpuwidget = wibox.widget.textbox()
cpuwidget.font = "RobotoMono Nerd Font Mono 8"
vicious.cache(vicious.widgets.cpu)
vicious.register(cpuwidget, vicious.widgets.cpu, "CPU: $1%", 3)

local memwidget = wibox.widget.textbox()
memwidget.font = "RobotoMono Nerd Font Mono 8"
vicious.cache(vicious.widgets.mem)
vicious.register(memwidget, vicious.widgets.mem, "MEM: $1%", 15)

local dskwidget = wibox.widget.textbox()
dskwidget.font = "RobotoMono Nerd Font Mono 8"
vicious.cache(vicious.widgets.fs)
-- vicious.register(dskwidget, vicious.widgets.fs, "DSK: / ${/ used_gb}GiB /mnt/share ${/mnt/share used_gb}GiB", 300)
vicious.register(dskwidget, vicious.widgets.fs, "DSK: ${/ used_gb}GiB ${/mnt/share used_gb}GiB", 300)

local batwidget = wibox.widget.textbox()
batwidget.font = "RobotoMono Nerd Font Mono 8"
vicious.cache(vicious.widgets.bat)
vicious.register(batwidget, vicious.widgets.bat, "BAT: $2%", 61, "BAT0")

local volwidget = wibox.widget.textbox()
volwidget.font = "RobotoMono Nerd Font Mono 8"
vicious.cache(vicious.widgets.volume)
vicious.register(volwidget, vicious.widgets.volume, "VOL: $1%", 1, "Master")

local wifiwidget = wibox.widget.textbox()
wifiwidget.font = "RobotoMono Nerd Font Mono 8"
vicious.cache(vicious.widgets.wifi)
vicious.register(wifiwidget, vicious.widgets.wifi, "NET: ${ssid}", 61, "wlan0")
--- }}}

local keyboardbutton = wibox.widget.textbox("")
keyboardbutton.font = "RobotoMono Nerd Font Mono 16"
IsVirtualKeyboardOn = false
function toggle_virtual_keyboard()
    if (IsVirtualKeyboardOn) then
        awful.spawn.with_shell("killall corekeyboard")
        IsVirtualKeyboardOn = false
    else
        awful.spawn("corekeyboard")
        IsVirtualKeyboardOn = true
    end
end

keyboardbutton:buttons(gears.table.join(
    keyboardbutton:buttons(),
    awful.button({}, 1, nil, toggle_virtual_keyboard)
))

local displaybutton = wibox.widget.textbox("󰦉")
displaybutton.font = "RobotoMono Nerd Font Mono 16"
LANDSCAPE = 1
PORTRAIT = 0
TABLET_LANDSCAPE = -1
TABLET_PORTRAIT = -2


DisplayMode = LANDSCAPE
IsInverted = true
IsLandscape = true
function set_display_landscape()
    awful.spawn.with_shell(
        'xrandr --output eDP-1 --auto --rotate inverted && xrandr --output eDP-2 --auto --rotate normal --below eDP-1 && xsetwacom set "INGENIC Gadget Serial and keyboard" MapToOutput eDP-1')
end

function set_display_portrait()
    awful.spawn.with_shell(
        'xrandr --output eDP-1 --auto --rotate right && xrandr --output eDP-2 --auto --rotate left --left-of eDP-1 && xinput set-prop "INGENIC Gadget Serial and keyboard" --type=float "Coordinate Transformation Matrix"  0 -0.5 1 1 0 0 0 0 1')
end

function set_display_tablet_landscape()
    awful.spawn.with_shell(
        'xrandr --output eDP-1 --auto --rotate inverted && xrandr --output eDP-2 --off && xsetwacom set "INGENIC Gadget Serial and keyboard" MapToOutput eDP-1')
end

function set_display_tablet_portrait()
    awful.spawn.with_shell(
        'xrandr --output eDP-1 --auto --rotate right && xrandr --output eDP-2 --off && xinput set-prop "INGENIC Gadget Serial and keyboard" --type=float "Coordinate Transformation Matrix"  0 -1 1 1 0 0 0 0 1')
end

function toggle_tablet_portrait_mode()
    if DisplayMode ~= TABLET_LANDSCAPE then
        set_display_tablet_landscape()
        DisplayMode = TABLET_LANDSCAPE
    else
        set_display_tablet_portrait()
        DisplayMode = TABLET_PORTRAIT
    end
end

displaybutton:buttons(gears.table.join(
    displaybutton:buttons(),
    awful.button({}, 1, nil, toggle_tablet_portrait_mode)
))

local rotatebutton = wibox.widget.textbox("󰢅")
rotatebutton.font = "RobotoMono Nerd Font Mono 16"
function rotate_display()
    if DisplayMode ~= LANDSCAPE then
        set_display_landscape()
        DisplayMode = LANDSCAPE
    else
        set_display_portrait()
        DisplayMode = PORTRAIT
    end
end

rotatebutton:buttons(gears.table.join(
    rotatebutton:buttons(),
    awful.button({}, 1, nil, rotate_display)
))

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), "default")
beautiful.init(theme_path)

-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
    { "hotkeys",     function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual",      terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart",     awesome.restart },
    { "quit",        function() awesome.quit() end },
}

mymainmenu = awful.menu({
    items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
        { "open terminal", terminal }
    }
})

mylauncher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = mymainmenu
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
-- mytextclock = wibox.widget.textclock("%m/%d %H:%M")

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal(
                "request::activate",
                "tasklist",
                { raise = true }
            )
        end
    end),
    awful.button({}, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        -- filter  = awful.widget.taglist.filter.all,
        filter  = function(t) return t.selected or #t:clients() > 0 end,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        layout  = {
            -- forced_width = 1400,
            spacing = 12,
            spacing_widget = separatorwidget,
            layout = wibox.layout.fixed.horizontal,
        },
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 12,
            -- mylauncher,
            displaybutton,
            keyboardbutton,
            rotatebutton,
            s.mytaglist,
            s.mypromptbox,
            s.mytasklist, -- Middle widget
        },
        clockwidget,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 12,
            -- mykeyboardlayout,
            wibox.widget.systray(),
            -- clockwidget,
            utmwidget,
            separatorwidget,
            -- pkgwidget,
            -- separatorwidget,
            cpuwidget,
            separatorwidget,
            memwidget,
            separatorwidget,
            dskwidget,
            separatorwidget,
            batwidget,
            separatorwidget,
            volwidget,
            separatorwidget,
            wifiwidget,
            -- separatorwidget,
            -- displaybutton,
            -- keyboardbutton,
            -- rotatebutton,
            -- s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({}, 3, function() mymainmenu:toggle() end),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey, "Control" }, ";", function() awful.spawn.with_shell("keynav") end,
        { description = "launch keynav", group = "awesome" }),
    awful.key({ modkey, "Control" }, "/", toggle_virtual_keyboard,
        { description = "virtual keyboard", group = "awesome" }),
    awful.key({ modkey, "Control" }, "[",
        function()
            awful.spawn.with_shell(
                "xrandr --output eDP-1 --brightness 0.5 && xrandr --output eDP-2 --brightness 0.5")
        end,
        { description = "show help", group = "awesome" }),
    awful.key({ modkey, "Control" }, "]",
        function() awful.spawn.with_shell("xrandr --output eDP-1 --brightness 1 && xrandr --output eDP-2 --brightness 1") end,
        { description = "show help", group = "awesome" }),
    awful.key({ modkey, "Control" }, "0",
        function() awful.spawn.with_shell("xset dpms force off") end,
        { description = "show help", group = "awesome" }),
    awful.key({ modkey, "Control" }, "=",
        function() awful.spawn.with_shell("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+") end,
        { description = "show help", group = "awesome" }),
    awful.key({ modkey, "Control" }, "-",
        function() awful.spawn.with_shell("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-") end,
        { description = "view previous", group = "tag" }),
    awful.key({ modkey, "Control" }, "m",
        function() awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") end,
        { description = "view next", group = "tag" }),
    -- awful.key({ modkey, }, "s", hotkeys_popup.show_help,
    --     { description = "show help", group = "awesome" }),
    awful.key({ modkey, }, "Left", awful.tag.viewprev,
        { description = "view previous", group = "tag" }),
    awful.key({ modkey, }, "Right", awful.tag.viewnext,
        { description = "view next", group = "tag" }),
    awful.key({ modkey, }, "Escape", awful.tag.history.restore,
        { description = "go back", group = "tag" }),
    awful.key({ modkey, "Shift" }, "t", toggle_tablet_portrait_mode),
    awful.key({ modkey, "Shift" }, "r", rotate_display),

    awful.key({ modkey, }, "j",
        function()
            awful.client.focus.bydirection("down")
        end,
        { description = "focus down", group = "client" }
    ),
    awful.key({ modkey, }, "k",
        function()
            awful.client.focus.bydirection("up")
        end,
        { description = "focus up", group = "client" }
    ),
    awful.key({ modkey, }, "h",
        function()
            awful.client.focus.bydirection("left")
        end,
        { description = "focus left", group = "client" }
    ),
    awful.key({ modkey, }, "l",
        function()
            awful.client.focus.bydirection("right")
        end,
        { description = "focus right", group = "client" }
    ),
    -- awful.key({ modkey, }, "w", function() mymainmenu:show() end,
    --     { description = "show main menu", group = "awesome" }),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "h", function() awful.client.swap.bydirection("left") end,
        { description = "swap with left", group = "client" }),
    awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.bydirection("down") end,
        { description = "swap with down", group = "client" }),
    awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.bydirection("up") end,
        { description = "swap with up", group = "client" }),
    awful.key({ modkey, "Shift" }, "l", function() awful.client.swap.bydirection("right") end,
        { description = "swap with right", group = "client" }),
    awful.key({ modkey, "Control" }, "h", function() awful.tag.incmwfact(-0.01) end,
        { description = "swap with left", group = "client" }),
    awful.key({ modkey, "Control" }, "j", function() awful.client.incwfact(0.03) end,
        { description = "swap with down", group = "client" }),
    awful.key({ modkey, "Control" }, "k", function() awful.client.incwfact(-0.03) end,
        { description = "swap with up", group = "client" }),
    awful.key({ modkey, "Control" }, "l", function() awful.tag.incmwfact(0.01) end,
        { description = "swap with right", group = "client" }),
    awful.key({ modkey, "Control" }, "o", function() awful.screen.focus_relative(1) end,
        { description = "focus the next screen", group = "screen" }),
    awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }),
    awful.key({ modkey, }, "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        { description = "go back", group = "client" }),

    -- Standard program
    awful.key({ modkey, }, "t", function() awful.spawn(terminal) end,
        { description = "open a terminal", group = "launcher" }),
    awful.key({ modkey, }, "Return", function() awful.spawn(terminal) end,
        { description = "open a terminal", group = "launcher" }),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
        { description = "reload awesome", group = "awesome" }),
    awful.key({ modkey, "Control" }, "q", awesome.quit,
        { description = "quit awesome", group = "awesome" }),
    -- awful.key({ modkey, }, "l", function() awful.tag.incmwfact(0.05) end,
    --     { description = "increase master width factor", group = "layout" }),
    -- awful.key({ modkey, }, "h", function() awful.tag.incmwfact(-0.05) end,
    --     { description = "decrease master width factor", group = "layout" }),
    awful.key({ modkey, }, "space", function() awful.layout.inc(1) end,
        { description = "select next", group = "layout" }),
    awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end,
        { description = "select previous", group = "layout" }),

    awful.key({ modkey, "Control" }, "n",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal(
                    "request::activate", "key.unminimize", { raise = true }
                )
            end
        end,
        { description = "restore minimized", group = "client" }),

    -- Prompt
    awful.key({ modkey }, "r", function() awful.spawn.with_shell("rofi -show drun") end,
        { description = "run prompt", group = "launcher" }),
    awful.key({ modkey }, "b", function() awful.spawn.with_shell("$HOME/.config/rofi/scripts/books.sh") end,
        { description = "run prompt", group = "launcher" }),
    awful.key({ modkey }, "w", function() awful.spawn.with_shell("$HOME/.config/rofi/scripts/web.sh") end,
        { description = "run prompt", group = "launcher" }),
    awful.key({ modkey }, "i", function() awful.spawn.with_shell("kitty nmtui") end,
        { description = "run prompt", group = "launcher" }),
    awful.key({ modkey }, "v", function() awful.spawn.with_shell("google-chrome-stable --incognito") end,
        { description = "run prompt", group = "launcher" }),
    awful.key({ modkey }, "c", function() awful.spawn.with_shell("google-chrome-stable") end,
        { description = "run prompt", group = "launcher" }),
    awful.key({ modkey }, "/", function() awful.spawn.with_shell("kitty nvim") end,
        { description = "run prompt", group = "launcher" }),
    awful.key({ modkey }, "d", function() awful.spawn.with_shell("/usr/bin/emacs --daemon") end,
        { description = "run prompt", group = "launcher" }),
    awful.key({ modkey }, "e", function() awful.spawn.with_shell("emacsclient -c -a '/usr/bin/emacs'") end,
        { description = "run prompt", group = "launcher" })

-- awful.key({ modkey }, "x",
--     function()
--         awful.prompt.run {
--             prompt       = "Run Lua code: ",
--             textbox      = awful.screen.focused().mypromptbox.widget,
--             exe_callback = awful.util.eval,
--             history_path = awful.util.get_cache_dir() .. "/history_eval"
--         }
--     end,
--     { description = "lua execute prompt", group = "awesome" }),
-- -- Menubar
-- awful.key({ modkey }, "p", function() menubar.show() end,
--     { description = "show the menubar", group = "launcher" })
)

clientkeys = gears.table.join(
-- awful.key({ modkey, }, "f",
--     function(c)
--         c.fullscreen = not c.fullscreen
--         c:raise()
--     end,
--     { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey, }, "q", function(c) c:kill() end,
        { description = "close", group = "client" }),
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }),
    awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
        { description = "move to master", group = "client" }),
    awful.key({ modkey, "Shift" }, "o", function(c) c:move_to_screen() end,
        { description = "move to screen", group = "client" }),
    -- awful.key({ modkey, }, "t", function(c) c.ontop = not c.ontop end,
    --     { description = "toggle keep on top", group = "client" }),
    awful.key({ modkey, }, "n",
        function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        { description = "minimize", group = "client" }),
    awful.key({ modkey, }, "m",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        { description = "(un)maximize", group = "client" }),
    -- awful.key({ modkey, "Control" }, "m",
    --     function(c)
    --         c.maximized_vertical = not c.maximized_vertical
    --         c:raise()
    --     end,
    --     { description = "(un)maximize vertically", group = "client" }),
    awful.key({ modkey, "Shift" }, "m",
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,
        { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            { description = "view tag #" .. i, group = "tag" }),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            { description = "toggle tag #" .. i, group = "tag" }),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            { description = "move focused client to tag #" .. i, group = "tag" }),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            { description = "toggle focused client on tag #" .. i, group = "tag" })
    )
end

clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA",   -- Firefox addon DownThemAll.
                "copyq", -- Includes session name in class.
                "pinentry",
            },
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin",  -- kalarm.
                "Sxiv",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer" },

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester", -- xev.
            },
            role = {
                "AlarmWindow",   -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up",        -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    },

    -- Add titlebars to normal clients and dialogs
    {
        rule_any = { type = { "normal", "dialog" }
        },
        properties = { titlebars_enabled = true }
    },

    {
        rule = { instance = "corekeyboard"
        },
        properties = {
            screen = 1,
            maximized_horizontal = true,
            placement = function(c)
                if IsInverted then
                    return awful.placement.bottom(c, { offset = { x = 0, y = 45 } })
                else
                    return awful.placement.bottom(c, { offset = { x = 0, y = 20 } })
                end
            end,
            sticky = true,
            ontop = true,
            height = 800,
        }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

    awful.titlebar.hide(c)
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({}, 1, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c):setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        {     -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- Autostart applications
awful.spawn.with_shell("~/.config/awesome/autostart.sh")

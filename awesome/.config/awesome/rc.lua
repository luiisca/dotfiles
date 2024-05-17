--[[

     Awesome WM configuration template
     https://github.com/awesomeWM

     Freedesktop : https://github.com/lcpz/awesome-freedesktop

     Copycats themes : https://github.com/lcpz/awesome-copycats

     lain : https://github.com/lcpz/lain

--]]
-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

-- https://awesomewm.org/doc/api/documentation/05-awesomerc.md.html
-- Standard awesome library
local gears = require("gears") -- Utilities such as color parsing and objects
local awful = require("awful") -- Everything related to window managment
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
naughty.config.defaults["icon_size"] = 100

-- local menubar       = require("menubar")

local lain = require("lain")
local freedesktop = require("freedesktop")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup").widget
require("awful.hotkeys_popup.keys")
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility
local dpi = require("beautiful.xresources").apply_dpi
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors,
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        if in_error then
            return
        end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err),
        })
        in_error = false
    end)
end
-- }}}

-- {{{ Autostart windowless processes
-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end
local function case_insensitive_match(str, pattern)
    return string.match(string.lower(str), string.lower(pattern)) ~= nil
end

run_once({ "unclutter -root" }) -- entries must be comma-separated

-- {{{ Variable definitions
-- keep themes in alfabetical order for ATT
local themes = { "forest" }

-- choose your theme here
local chosen_theme = themes[1]

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)

-- modkeys
local modkey = "Mod4"
local altkey = "Mod1"
local controlL = "Control"
local controlR = "Mod2"

-- keys
local f1 = "#67"
local f2 = "#68"
local f3 = "#69"
local f4 = "#70"
local f11 = "#95"
local f12 = "#96"
local cycle_prev = true -- cycle with only the previously focused client or all https://github.com/lcpz/awesome-copycats/issues/274

-- personal variables
-- change these variables if you want
local browser1 = "vivaldi"
local browser2 = "microsoft-edge-dev"
local editor = os.getenv("EDITOR") or "nvim"
local filemanager = "vifm"
local mediaplayer = "Spotify"
local terminal = "alacritty"

-- awesome variables
awful.util.terminal = terminal
awful.util.tagnames = { "1", "2", "3", "4", "5" }
awful.layout.layouts = {
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.tile, -- awful.layout.suit.floating,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
    -- lain.layout.cascade,
    -- lain.layout.cascade.tile,
    -- lain.layout.centerwork,
    -- lain.layout.centerwork.horizontal,
    -- lain.layout.termfair,
    -- lain.layout.termfair.center,
}

-- defines exclusively mouse bindings for the taglist widget
awful.util.taglist_buttons = my_table.join(
    awful.button({}, 1, function(t)
        t:view_only()
    end),
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
    awful.button({}, 4, function(t)
        awful.tag.viewprev(t.screen)
    end),
    awful.button({}, 5, function(t)
        awful.tag.viewnext(t.screen)
    end)
)

-- mouse binding for the tasklist widget
awful.util.tasklist_buttons = my_table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            -- c:emit_signal("request::activate", "tasklist", {raise = true})<Paste>

            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() and c.first_tag then
                c.first_tag:view_only()
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
        end
    end),
    awful.button({}, 3, function()
        local instance = nil

        return function()
            if instance and instance.wibox.visible then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients({
                    theme = {
                        width = dpi(250),
                    },
                })
            end
        end
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end)
)

-- lain.layout.termfair.nmaster           = 3
-- lain.layout.termfair.ncol              = 1
-- lain.layout.termfair.center.nmaster    = 3
-- lain.layout.termfair.center.ncol       = 1
-- lain.layout.cascade.tile.offset_x      = dpi(2)
-- lain.layout.cascade.tile.offset_y      = dpi(32)
-- lain.layout.cascade.tile.extra_padding = dpi(5)
-- lain.layout.cascade.tile.nmaster       = 5
-- lain.layout.cascade.tile.ncol          = 2
-- }}}

-- {{{ Menu
local myawesomemenu =
{ {
    "hotkeys",
    function()
        return false, hotkeys_popup.show_help
    end,
}, { "arandr", "arandr" } }

awful.util.mymainmenu = freedesktop.menu.build({
    before = {
        { "Awesome", myawesomemenu }, -- { "Atom", "atom" },
        -- other triads can be put here
    },
    after = {
        { "Terminal", terminal },
        {
            "Log out",
            function()
                awesome.quit()
            end,
        },
        { "Sleep",    "systemctl suspend" },
        { "Restart",  "systemctl reboot" },
        { "Shutdown", "systemctl poweroff" }, -- other triads can be put here
    },
})
-- hide menu when mouse leaves it
-- awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function() awful.util.mymainmenu:hide() end)

-- menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function(s)
    local only_one = #s.tiled_clients == 1
    for _, c in pairs(s.clients) do
        if only_one and not c.floating or c.maximized then
            c.border_width = 2
        else
            c.border_width = beautiful.border_width
        end
    end
end)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s)
    beautiful.at_screen_connect(s)
    s.systray = wibox.widget.systray()
    s.systray.visible = true
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(my_table.join(
    awful.button({}, 3, function()
        awful.util.mymainmenu:toggle()
    end),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = my_table.join( -- {{{ Personal keybindings
-- dmenu
    awful.key({ modkey, "Shift" }, "d", function()
        awful.spawn(
            string.format(
                "dmenu_run -i -nb '#191919' -nf '#fea63c' -sb '#fea63c' -sf '#191919' -fn NotoMonoRegular:bold:pixelsize=14",
                beautiful.bg_normal,
                beautiful.fg_normal,
                beautiful.bg_focus,
                beautiful.fg_focus
            )
        )
    end, {
        description = "show dmenu",
        group = "hotkeys",
    }), -- super + ... function keys
    awful.key({ modkey }, "F6", function()
        awful.util.spawn("vlc --video-on-top")
    end, {
        description = "vlc",
        group = "function keys",
    }),
    awful.key({ modkey }, "F11", function()
        awful.util.spawn("rofi -theme-str 'window {width: 100%;height: 100%;}' -show drun")
    end, {
        description = "rofi fullscreen",
        group = "function keys",
    }), -- super + ...
    awful.key({ modkey }, ".", function()
        awful.util.spawn(
            "rofimoji --selector-args='-theme ~/.config/rofimoji/grid-theme.rasi -kb-row-left Left -kb-row-right Right -kb-move-char-back Control+b -kb-move-char-forward Control+f' --hidden-descriptions"
        )
    end, {
        description = "emoji selector",
        group = "super",
    }),
    awful.key({ modkey }, "w", function()
        awful.util.spawn(browser1)
    end, {
        description = browser1,
        group = "super",
    }),
    awful.key({ modkey }, "v", function()
        awful.util.spawn(browser2)
    end, {
        description = browser2,
        group = "super",
    }),
    awful.key({ modkey }, "e", function()
        awful.util.spawn("alacritty -e nvim")
    end, {
        description = "run gui editor",
        group = "super",
    }),
    awful.key({ modkey }, "r", function()
        awful.util.spawn("rofi -show")
    end, {
        description = "rofi",
        group = "super",
    }),
    awful.key({ modkey }, "x", function()
        awful.util.spawn("archlinux-logout")
    end, {
        description = "exit",
        group = "hotkeys",
    }),
    awful.key({ modkey, "Shift" }, "x", function()
        awful.util.spawn("xkill")
    end, {
        description = "Kill proces",
        group = "hotkeys",
    }), -- ctrl + shift + ...
    awful.key({ modkey, "Shift" }, "h", function()
        awful.util.spawn("alacritty -e htop")
    end, {
        description = "htop",
        group = "ctrl+shift",
    }), -- ctrl+alt +  ...
    awful.key({ controlL, altkey }, "o", function()
        awful.spawn.with_shell("$HOME/.config/awesome/scripts/picom-toggle.sh")
    end, {
        description = "Picom toggle",
        group = "alt+ctrl",
    }),
    awful.key({ controlL, altkey }, "s", function()
        awful.util.spawn(mediaplayer)
    end, {
        description = mediaplayer,
        group = "alt+ctrl",
    }),
    awful.key({ controlL, altkey }, "u", function()
        awful.util.spawn("pavucontrol")
    end, {
        description = "pulseaudio control",
        group = "alt+ctrl",
    }),
    awful.key({ controlL, altkey }, "m", function()
        awful.util.spawn("xfce4-settings-manager")
    end, {
        description = "Xfce settings manager",
        group = "alt+ctrl",
    }),
    awful.key({ controlL, altkey }, "Return", function()
        awful.util.spawn("scrot 'ArcoLinux-%Y-%m-%d-%s_screenshot_$wx$h.jpg' -e 'mv $f $$(xdg-user-dir PICTURES)'")
    end, {
        description = "Take a screenshot",
        group = "screenshots",
    }), -- alt + shift ...
    awful.key({ altkey, "Shift" }, "Return", function()
        awful.util.spawn("alacritty -e vifm")
    end, {
        description = "vifm",
        group = "alt+shift",
    }), -- }}}
    -- Hotkeys Awesome
    awful.key({ modkey }, "s", hotkeys_popup.show_help, {
        description = "show help",
        group = "awesome",
    }), -- Tag browsing with modkey
    awful.key({ modkey }, "Left", awful.tag.viewprev, {
        description = "view previous",
        group = "tag",
    }),
    awful.key({ modkey }, "Right", awful.tag.viewnext, {
        description = "view next",
        group = "tag",
    }),
    awful.key({ altkey }, "Escape", awful.tag.history.restore, {
        description = "go back",
        group = "tag",
    }), -- Tag browsing alt + tab
    awful.key({ altkey }, "Tab", awful.tag.viewnext, {
        description = "view next",
        group = "tag",
    }),
    awful.key({ altkey, "Shift" }, "Tab", awful.tag.viewprev, {
        description = "view previous",
        group = "tag",
    }), -- Clients browsing modkey + tab
    awful.key({ modkey }, "Tab", function()
        if cycle_prev then
            awful.client.focus.history.previous()
        else
            awful.client.focus.byidx(-1)
        end
        if client.focus then
            client.focus:raise()
        end
    end, {
        description = "cycle with previous/go back",
        group = "client",
    }), -- Non-empty tag browsing
    -- awful.key({ modkey }, "Left", function () lain.util.tag_view_nonempty(-1) end,
    -- {description = "view  previous nonempty", group = "tag"}),
    -- awful.key({ modkey }, "Right", function () lain.util.tag_view_nonempty(1) end,
    -- {description = "view  next nonempty", group = "tag"}),
    -- Default client focus
    -- awful.key({ altkey }, "j", function()
    -- 	awful.client.focus.byidx(1)
    -- end, {
    -- 	description = "focus next by index",
    -- 	group = "client",
    -- }),
    -- awful.key({ altkey }, "k", function()
    -- 	awful.client.focus.byidx(-1)
    -- end, {
    -- 	description = "focus previous by index",
    -- 	group = "client",
    -- }),
    -- By direction client focus
    awful.key({ modkey }, "j", function()
        awful.client.focus.global_bydirection("down")
        if client.focus then
            client.focus:raise()
        end
    end, {
        description = "focus down",
        group = "client",
    }),
    awful.key({ modkey }, "k", function()
        awful.client.focus.global_bydirection("up")
        if client.focus then
            client.focus:raise()
        end
    end, {
        description = "focus up",
        group = "client",
    }),
    awful.key({ modkey }, "h", function()
        awful.client.focus.global_bydirection("left")
        if client.focus then
            client.focus:raise()
        end
    end, {
        description = "focus left",
        group = "client",
    }),
    awful.key({ modkey }, "l", function()
        awful.client.focus.global_bydirection("right")
        if client.focus then
            client.focus:raise()
        end
    end, {
        description = "focus right",
        group = "client",
    }), -- By direction client focus with arrows
    awful.key({ controlL, modkey }, "Down", function()
        awful.client.focus.global_bydirection("down")
        if client.focus then
            client.focus:raise()
        end
    end, {
        description = "focus down",
        group = "client",
    }),
    awful.key({ controlL, modkey }, "Up", function()
        awful.client.focus.global_bydirection("up")
        if client.focus then
            client.focus:raise()
        end
    end, {
        description = "focus up",
        group = "client",
    }),
    awful.key({ controlL, modkey }, "Left", function()
        awful.client.focus.global_bydirection("left")
        if client.focus then
            client.focus:raise()
        end
    end, {
        description = "focus left",
        group = "client",
    }),
    awful.key({ controlL, modkey }, "Right", function()
        awful.client.focus.global_bydirection("right")
        if client.focus then
            client.focus:raise()
        end
    end, {
        description = "focus right",
        group = "client",
    }), -- Layout manipulation
    awful.key({ modkey, "Shift" }, "j", function()
        awful.client.swap.byidx(1)
    end, {
        description = "swap with next client by index",
        group = "client",
    }),
    awful.key({ modkey, "Shift" }, "k", function()
        awful.client.swap.byidx(-1)
    end, {
        description = "swap with previous client by index",
        group = "client",
    }),
    awful.key({ modkey, "Control" }, "j", function()
        awful.screen.focus_relative(1)
    end, {
        description = "focus the next screen",
        group = "screen",
    }),
    awful.key({ modkey, "Control" }, "k", function()
        awful.screen.focus_relative(-1)
    end, {
        description = "focus the previous screen",
        group = "screen",
    }),
    awful.key({ modkey }, "u", awful.client.urgent.jumpto, {
        description = "jump to urgent client",
        group = "client",
    }),
    awful.key({ controlL }, "Tab", function()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end, {
        description = "go back",
        group = "client",
    }), -- Show/Hide Wibox
    awful.key({ modkey }, "b", function()
        for s in screen do
            s.mywibox.visible = not s.mywibox.visible
            if s.mybottomwibox then
                s.mybottomwibox.visible = not s.mybottomwibox.visible
            end
        end
    end, {
        description = "toggle wibox",
        group = "awesome",
    }), -- On the fly useless gaps change
    awful.key({ altkey, "Control" }, "j", function()
        lain.util.useless_gaps_resize(1)
    end, {
        description = "increment useless gaps",
        group = "tag",
    }),
    awful.key({ altkey, "Control" }, "k", function()
        lain.util.useless_gaps_resize(-1)
    end, {
        description = "decrement useless gaps",
        group = "tag",
    }), -- Dynamic tagging
    awful.key({ modkey, "Shift" }, "n", function()
        lain.util.add_tag()
    end, {
        description = "add new tag",
        group = "tag",
    }),
    awful.key({ modkey, "Control" }, "r", function()
        lain.util.rename_tag()
    end, {
        description = "rename tag",
        group = "tag",
    }), -- awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
    --          {description = "move tag to the left", group = "tag"}),
    -- awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
    --          {description = "move tag to the right", group = "tag"}),
    awful.key({ modkey, "Shift" }, "y", function()
        lain.util.delete_tag()
    end, {
        description = "delete tag",
        group = "tag",
    }), -- Standard program
    awful.key({ modkey }, "Return", function()
        awful.spawn(terminal)
    end, {
        description = terminal,
        group = "super",
    }),
    awful.key({ modkey, "Shift" }, "r", awesome.restart, {
        description = "reload awesome",
        group = "awesome",
    }), -- awful.key({ modkey, "Shift"   }, "x", awesome.quit,
    --          {description = "quit awesome", group = "awesome"}),
    awful.key({ altkey, "Shift" }, "l", function()
        awful.tag.incmwfact(0.05)
    end, {
        description = "increase master width factor",
        group = "layout",
    }),
    awful.key({ altkey, "Shift" }, "h", function()
        awful.tag.incmwfact(-0.05)
    end, {
        description = "decrease master width factor",
        group = "layout",
    }),
    awful.key({ modkey, "Shift" }, "h", function()
        awful.tag.incnmaster(1, nil, true)
    end, {
        description = "increase the number of master clients",
        group = "layout",
    }),
    awful.key({ modkey, "Shift" }, "l", function()
        awful.tag.incnmaster(-1, nil, true)
    end, {
        description = "decrease the number of master clients",
        group = "layout",
    }),
    awful.key({ modkey, "Control" }, "h", function()
        awful.tag.incncol(1, nil, true)
    end, {
        description = "increase the number of columns",
        group = "layout",
    }),
    awful.key({ modkey, "Control" }, "l", function()
        awful.tag.incncol(-1, nil, true)
    end, {
        description = "decrease the number of columns",
        group = "layout",
    }),
    awful.key({ modkey }, "space", function()
        awful.layout.inc(1)
    end, {
        description = "select next",
        group = "layout",
    }),
    awful.key({ modkey, "Shift" }, "space", function()
        awful.layout.inc(-1)
    end, {
        description = "select previous",
        group = "layout",
    }),
    awful.key({ modkey, "Control" }, "n", function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            client.focus = c
            c:raise()
        end
    end, {
        description = "restore minimized",
        group = "client",
    }), -- Widgets popups
    -- awful.key({ altkey, }, "c", function () lain.widget.calendar.show(7) end,
    -- {description = "show calendar", group = "widgets"}),
    -- awful.key({ altkey, }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end,
    -- {description = "show filesystem", group = "widgets"}),
    -- awful.key({ altkey, }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end,
    -- {description = "show weather", group = "widgets"}),

    -- @TODO: setup backlight
    -- Brightness
    awful.key({}, "XF86MonBrightnessUp", function()
        os.execute("xbacklight -inc 10")
    end, {
        description = "+10%",
        group = "hotkeys",
    }),
    awful.key({}, "XF86MonBrightnessDown", function()
        os.execute("xbacklight -dec 10")
    end, {
        description = "-10%",
        group = "hotkeys",
    }),

    -- ALSA volume control
    -- awful.key({f3}, "XF86AudioRaiseVolume",
    -- volume up
    awful.key({ modkey }, "=", function()
        os.execute(string.format("amixer -q set %s 5%%+", beautiful.volume.channel))
        beautiful.volume.update()
    end),
    -- awful.key({}, "XF86AudioLowerVolume",
    -- volume down
    awful.key({ modkey }, "-", function()
        os.execute(string.format("amixer -q set %s 5%%-", beautiful.volume.channel))
        beautiful.volume.update()
    end),
    -- awful.key({}, "XF86AudioMute",
    -- @TODO: mute, seems like it runs two times when using custom modifier keys setup at ~/.Xmodmap
    -- awful.key({'Mod2' }, "BackSpace", function () os.execute("amixer -D pulse sset Master toggle") end),
    -- awful.key({'Mod2'}, "BackSpace", function()
    --     os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
    --     beautiful.volume.update()
    -- end),

    -- spotify, vlc, etc
    -- awful.key({}, "XF86AudioPlay",
    awful.key({ modkey }, "Escape", function()
        awful.util.spawn("playerctl --player=spotify play-pause", false)
    end),
    -- awful.key({}, "XF86AudioNext",
    awful.key({}, f2, function()
        os.execute("playerctl --player=spotify next")
    end),
    -- awful.key({}, "XF86AudioPrev",
    awful.key({}, f1, function()
        os.execute("playerctl --player=spotify previous")
    end),

    -- Copy primary to clipboard (terminals to gtk)
    -- awful.key({ modkey }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end,
    -- {description = "copy terminal to gtk", group = "hotkeys"}),
    -- Copy clipboard to primary (gtk to terminals)
    -- awful.key({ modkey }, "v", function () awful.spawn.with_shell("xsel -b | xsel") end,
    -- {description = "copy gtk to terminal", group = "hotkeys"}),
    -- Default
    --[[ Menubar

    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "super"})
    --]]
    awful.key({ altkey }, "x", function()
        awful.prompt.run({
            prompt = "Run Lua code: ",
            textbox = awful.screen.focused().mypromptbox.widget,
            exe_callback = awful.util.eval,
            history_path = awful.util.get_cache_dir() .. "/history_eval",
        })
    end, {
        description = "lua execute prompt",
        group = "awesome",
    })
)

clientkeys = my_table.join(
    awful.key({ altkey, "Shift" }, "m", lain.util.magnify_client, {
        description = "magnify client",
        group = "client",
    }),
    awful.key({ modkey }, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, {
        description = "toggle fullscreen",
        group = "client",
    }),
    awful.key({ altkey, "Shift" }, "space", function(c)
        c:kill()
    end, {
        description = "close",
        group = "hotkeys",
    }),
    awful.key({ modkey, "Shift" }, "space", awful.client.floating.toggle, {
        description = "toggle floating",
        group = "client",
    }),
    awful.key({ modkey, "Control" }, "Return", function(c)
        c:swap(awful.client.getmaster())
    end, {
        description = "move to master",
        group = "client",
    }),
    awful.key({ modkey, "Shift" }, "Left", function(c)
        c:move_to_screen()
    end, {
        description = "move to screen",
        group = "client",
    }),
    awful.key({ modkey, "Shift" }, "Right", function(c)
        c:move_to_screen()
    end, {
        description = "move to screen",
        group = "client",
    }), -- awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
    -- {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey }, "n", function(c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
    end, {
        description = "minimize",
        group = "client",
    }),
    awful.key({ modkey }, "m", function(c)
        c.maximized = not c.maximized
        c:raise()
    end, {
        description = "maximize",
        group = "client",
    })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {
            description = "view tag #",
            group = "tag",
        }
        descr_toggle = {
            description = "toggle tag #",
            group = "tag",
        }
        descr_move = {
            description = "move focused client to tag #",
            group = "tag",
        }
        descr_toggle_focus = {
            description = "toggle focused client on tag #",
            group = "tag",
        }
    end
    globalkeys = my_table.join(
        globalkeys, -- View tag only.
        awful.key({ modkey }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                tag:view_only()
            end
        end, descr_view), -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end, descr_toggle), -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                    tag:view_only()
                end
            end
        end, descr_move), -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end, descr_toggle_focus)
    )
end

-- mouse bindings to focus, move and resize clients
clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {
            raise = true,
        })
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {
            raise = true,
        })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", {
            raise = true,
        })
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
local exe_callback_executed = {}
local clients_positioned = {}

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
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
            size_hints_honor = false,
        },
    },
    -- Titlebars
    {
        rule_any = {
            type = { "dialog", "normal" },
        },
        properties = {
            titlebars_enabled = false,
        },
    },
    -- Programs
    {
        rule = {
            class = 'Alacritty',
        },
        properties = {
            exe_callback = function(c)
                if not exe_callback_executed[c.class] then
                    c.fullscreen = true

                    exe_callback_executed[c.class] = true
                end
            end,
        },
    },
    {
        rule = {
            class = 'Vivaldi-stable',
        },
        properties = {
            exe_callback = function(c)
                Signal = function()
                    local linear_matched = case_insensitive_match(c.name, 'linear')
                    local chatgpt_matched = case_insensitive_match(c.name, 'chatgpt')

                    if linear_matched then
                        -- naughty.notify({
                        --     preset = naughty.config.presets.critical,
                        --     title = "Linear",
                        --     text = tostring(c.window),
                        -- })
                        c:move_to_tag(screen[1].tags[3])
                        clients_positioned[c.window] = true
                        local cmd = "xdotool windowfocus " .. tostring(c.window) .. "; xdotool key F11"

                        -- naughty.notify({
                        --     preset = naughty.config.presets.critical,
                        --     title = "cmd",
                        --     text = tostring(cmd),
                        -- })
                        -- awful.spawn.with_shell("xdotool windowfocus " .. tostring(c.window) .. "; xdotool key F11")

                        c:disconnect_signal("property::name", Signal)
                    elseif chatgpt_matched then
                        c:move_to_tag(screen[1].tags[4])
                        clients_positioned[c.window] = true
                        -- awful.spawn.with_shell("xdotool windowfocus " .. tostring(c.window) .. "; xdotool key F11")

                        c:disconnect_signal("property::name", Signal)
                    end
                end

                local clients_positioned_count = 0
                for _ in pairs(clients_positioned) do
                    clients_positioned_count = clients_positioned_count + 1
                end
                if clients_positioned_count >= 2 then
                    if clients_positioned_count == 2 then
                        c:move_to_tag(screen[1].tags[2])
                    end
                else
                    -- naughty.notify({
                    --     preset = naughty.config.presets.critical,
                    --     title = "Vivaldi",
                    --     text = tostring(c.window),
                    -- })
                    c:connect_signal("property::name", Signal)
                end
            end,
        }
    },
    {
        rule = {
            class = 'obsidian',
        },
        properties = {
            exe_callback = function(c)
                if not exe_callback_executed[c.class] then
                    c:move_to_tag(screen[1].tags[3])
                    c.fullscreen = true

                    exe_callback_executed[c.class] = true
                end
            end,
        }
    },
    {
        rule = {
            class = mediaplayer,
        },
        properties = {
            exe_callback = function(c)
                c:move_to_tag(screen[1].tags[4])
                gears.timer.start_new(2, function()
                    if not exe_callback_executed[c.class] then
                        c.minimized = true
                    end
                    exe_callback_executed[c.class] = true
                end)
            end,
        },
    },
}
-- }}}
--
-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then
        awful.client.setslave(c)
    end

    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = my_table.join(
        awful.button({}, 1, function()
            c:emit_signal("request::activate", "titlebar", {
                raise = true,
            })
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
            c:emit_signal("request::activate", "titlebar", {
                raise = true,
            })
            awful.mouse.client.resize(c)
        end)
    )

    awful
        .titlebar(c, {
            size = dpi(21),
        })
        :setup({
            { -- Left
                awful.titlebar.widget.iconwidget(c),
                buttons = buttons,
                layout = wibox.layout.fixed.horizontal,
            },
            {     -- Middle
                { -- Title
                    align = "center",
                    widget = awful.titlebar.widget.titlewidget(c),
                },
                buttons = buttons,
                layout = wibox.layout.flex.horizontal,
            },
            { -- Right
                awful.titlebar.widget.floatingbutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.stickybutton(c),
                awful.titlebar.widget.ontopbutton(c),
                awful.titlebar.widget.closebutton(c),
                layout = wibox.layout.fixed.horizontal(),
            },
            layout = wibox.layout.align.horizontal,
        })
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {
        raise = false,
    })
end)

client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)
-- }}}

-- {{{
-- Autostart applications
awful.spawn.with_shell("~/.config/awesome/autostart.sh")
awful.spawn.with_shell("picom -b --config  $HOME/.config/awesome/picom.conf")
-- }}}

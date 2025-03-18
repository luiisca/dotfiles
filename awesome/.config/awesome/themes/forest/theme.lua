--[[

     Steamburn Awesome WM theme 3.0
     github.com/lcpz

--]]

local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
local naughty = require("naughty")
naughty.config.defaults["icon_size"] = 100

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme = {}
theme.dir = os.getenv("HOME") .. "/.config/awesome/themes/forest"
-- theme.wallpaper = "~/wallpaper.jpg"
theme.font = "FiraCode Nerd Font Mono 11"
theme.fg_normal = "#e2ccb0" -- font color
theme.fg_focus = "#d77f48" -- font when focused
theme.fg_urgent = "#CC9393"
theme.bg_normal = "#2f383e" -- color of wibar top etc
theme.bg_focus = "#2f383e" -- focused wibar and window or tag
theme.bg_urgent = "#2f383e"
theme.border_width = dpi(1)
theme.border_normal = "#302627"
theme.border_focus = "#569d79" -- small border around window
theme.border_marked = "#CC9393"
theme.taglist_fg_focus = "#d88166"
theme.tasklist_bg_focus = "#2f383e"
theme.tasklist_fg_focus = "#d88166"
-- theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
-- theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.menu_height = dpi(16)
theme.menu_width = dpi(140)
theme.awesome_icon = theme.dir .. "/icons/awesome.png"
theme.menu_submenu_icon = theme.dir .. "/icons/submenu.png"
theme.layout_tile = theme.dir .. "/icons/tile.png"
theme.layout_tileleft = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop = theme.dir .. "/icons/tiletop.png"
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true
theme.useless_gap = dpi(0)
-- theme.titlebar_close_button_normal              = theme.dir .."/titlebar/close_normal.png"
-- theme.titlebar_close_button_focus               = theme.dir .."/titlebar/close_focus.png"
-- theme.titlebar_minimize_button_normal           = theme.dir .."/titlebar/minimize_normal.png"
-- theme.titlebar_minimize_button_focus            = theme.dir .."/titlebar/minimize_focus.png"
-- theme.titlebar_ontop_button_normal_inactive     = theme.dir .."/titlebar/ontop_normal_inactive.png"
-- theme.titlebar_ontop_button_focus_inactive      = theme.dir .."/titlebar/ontop_focus_inactive.png"
-- theme.titlebar_ontop_button_normal_active       = theme.dir .."/titlebar/ontop_normal_active.png"
-- theme.titlebar_ontop_button_focus_active        = theme.dir .."/titlebar/ontop_focus_active.png"
-- theme.titlebar_sticky_button_normal_inactive    = theme.dir .."/titlebar/sticky_normal_inactive.png"
-- theme.titlebar_sticky_button_focus_inactive     = theme.dir .."/titlebar/sticky_focus_inactive.png"
-- theme.titlebar_sticky_button_normal_active      = theme.dir .."/titlebar/sticky_normal_active.png"
-- theme.titlebar_sticky_button_focus_active       = theme.dir .."/titlebar/sticky_focus_active.png"
-- theme.titlebar_floating_button_normal_inactive  = theme.dir .."/titlebar/floating_normal_inactive.png"
-- theme.titlebar_floating_button_focus_inactive   = theme.dir.."/titlebar/floating_focus_inactive.png"
-- theme.titlebar_floating_button_normal_active    = theme.dir .."/titlebar/floating_normal_active.png"
-- theme.titlebar_floating_button_focus_active     = theme.dir .."/titlebar/floating_focus_active.png"
-- theme.titlebar_maximized_button_normal_inactive = theme.dir .."/titlebar/maximized_normal_inactive.png"
-- theme.titlebar_maximized_button_focus_inactive  = theme.dir .."/titlebar/maximized_focus_inactive.png"
-- theme.titlebar_maximized_button_normal_active   = theme.dir .."/titlebar/maximized_normal_active.png"
-- theme.titlebar_maximized_button_focus_active    = theme.dir .."/titlebar/maximized_focus_active.png"

-- lain related
theme.layout_txt_termfair = "[termfair]"
theme.layout_txt_centerfair = "[centerfair]"

local markup = lain.util.markup
local gray = "#94928F"

-- Textclock
local mytextclock = wibox.widget.textclock("%H:%M ")
mytextclock.font = theme.font

-- Calendar
theme.cal = lain.widget.cal({
	attach_to = { mytextclock },
	notification_preset = {
		font = "Fira Code 11",
		fg = theme.fg_normal,
		bg = theme.bg_normal,
	},
})

-- Mail IMAP check
--[[ to be set before use
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        mail  = ""
        count = ""

        if mailcount > 0 then
            mail = "Mail "
            count = mailcount .. " "
        end

        widget:set_markup(markup(gray, mail) .. count)
    end
})
--]]

-- MPD
theme.mpd = lain.widget.mpd({
	settings = function()
		artist = mpd_now.artist .. " "
		title = mpd_now.title .. " "

		if mpd_now.state == "pause" then
			artist = "mpd "
			title = "paused "
		elseif mpd_now.state == "stop" then
			artist = ""
			title = ""
		end

		widget:set_markup(markup.font(theme.font, markup(gray, artist) .. title))
	end,
})

-- CPU
local cpu = lain.widget.sysload({
	settings = function()
		widget:set_markup(markup.font(theme.font, markup(gray, " Cpu ") .. load_1 .. " "))
	end,
})

-- MEM
local mem = lain.widget.mem({
	settings = function()
		widget:set_markup(markup.font(theme.font, markup(gray, " Mem ") .. mem_now.used .. " "))
	end,
})

-- /home fs
--[[ commented because it needs Gio/Glib >= 2.54
theme.fs = lain.widget.fs({
    partition = "/home",
    notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "Terminus 10.5" },
})
--]]

-- Net checker
-- local net = lain.widget.net({
--     settings = function()
--         if net_now.state == "up" then net_state = "On"
--         else net_state = "Off" end
--         widget:set_markup(markup.font(theme.font, markup(gray, " Net ") .. net_state .. " "))
--     end
-- })

-- ALSA volume
theme.volume = lain.widget.alsa({
	settings = function()
		header = " Vol "
		vlevel = volume_now.level

		if volume_now.status == "off" then
			vlevel = vlevel .. "M "
		else
			vlevel = vlevel .. " "
		end

		widget:set_markup(markup.font(theme.font, markup(gray, header) .. vlevel))
	end,
})

-- Battery (dual for T480) Widget with Real-Time AC Detection
local battery_widget = wibox.widget.textbox()
-- Battery Icons (Nerd Fonts)
local battery_icons = {
	charging = "󰢝", -- charging
	discharging = "󰂎", -- empty
	full = "󰁹", -- full
	levels = {
		"󰂎", -- 0-10%
		"󰁺", -- 10-30%
		"󰁼", -- 30-50%
		"󰁾", -- 50-70%
		"󰂀", -- 70-90%
		"󰂂", -- 90-100%
	},
	charging_levels = {
		"󰢟", -- 0-10%
		"󰢜", -- 10-30%
		"󰂇", -- 30-50%
		"󰢝", -- 50-70%
		"󰢞", -- 70-90%
		"󰂋", -- 90-100%
	},
}

-- Horizontal AC Icon
local ac_icon = "󱐥"

local function read_file(path)
	local file = io.open(path)
	if not file then
		return 0
	end
	local content = file:read("*a")
	file:close()
	return tonumber(content) or 0
end

local function get_icon(capacity, charging)
	local level = math.floor(capacity / 20) + 1
	if charging then
		return battery_icons.charging_levels[math.min(level, 6)]
	else
		return battery_icons.levels[math.min(level, 6)]
	end
end

local battery_tooltip = awful.tooltip({
	objects = { battery_widget },
	timer_function = function()
		local function read_bat(bat, file)
			return tonumber(io.open("/sys/class/power_supply/" .. bat .. "/" .. file):read("*a")) or 0
		end

		-- BAT0 Details
		local bat0_status = io.open("/sys/class/power_supply/BAT0/status"):read("*a"):gsub("\n", "")
		local bat0_cap = read_bat("BAT0", "capacity")
		local bat0_power = read_bat("BAT0", "power_now") / 1000000 -- Convert μW to W

		-- BAT1 Details
		local bat1_status = io.open("/sys/class/power_supply/BAT1/status"):read("*a"):gsub("\n", "")
		local bat1_cap = read_bat("BAT1", "capacity")
		local bat1_power = read_bat("BAT1", "power_now") / 1000000

		-- Calculate time remaining
		local time_remaining = "Calculating..."
		if bat0_status == "Discharging" or bat1_status == "Discharging" then
			-- Get energy remaining in Watt-hours
			local energy0 = (read_bat("BAT0", "energy_now") / 1000000) -- μWh → Wh
			local energy1 = (read_bat("BAT1", "energy_now") / 1000000)
			local total_energy = energy0 + energy1

			-- Total power draw
			local total_power = bat0_power + bat1_power

			if total_power > 0 then
				local hours = total_energy / total_power
				local mins = (hours % 1) * 60
				time_remaining = string.format("%d:%02d remaining", math.floor(hours), math.floor(mins))
			end
		else
			-- TODO: show either a more accurate remaining charge or how much is left for full charge
			time_remaining = "AC connected"
		end

		return string.format(
			'<span font="FiraCode Nerd Font Mono 11">' -- Larger font size
				.. "BAT0: %d%% (%s)\n"
				.. "BAT1: %d%% (%s)\n\n"
				.. "Total: %s"
				.. "</span>",
			bat0_cap,
			bat0_status:lower(),
			bat1_cap,
			bat1_status:lower(),
			time_remaining
		)
	end,
	margin_leftright = dpi(20),
	margin_topbottom = dpi(10),
	bg = theme.bg_normal,
	fg = theme.fg_normal,
})

local function update_battery()
	-- Read both batteries
	local bat0 = read_file("/sys/class/power_supply/BAT0/capacity")
	local bat1 = read_file("/sys/class/power_supply/BAT1/capacity")

	-- Check AC status
	local ac_online = read_file("/sys/class/power_supply/AC/online")
	-- Calculate average
	local avg = math.floor((bat0 + bat1) / 2)
	local icon = get_icon(avg, ac_online == 1)

	battery_widget:set_markup(markup.font(theme.font, icon .. " " .. avg .. "% "))
end

-- Add hover effects
battery_widget:connect_signal("mouse::enter", function()
	battery_tooltip:show()
end)

battery_widget:connect_signal("mouse::leave", function()
	battery_tooltip:hide()
end)

-- Listen for AC power events
awful.spawn.with_line_callback("udevadm monitor --property --subsystem=power_supply", {
	stdout = function(line)
		if line:match("POWER_SUPPLY_ONLINE=") then
			-- AC status changed - update immediately
			update_battery()
		end
	end,
})

-- Still keep the 60s timer for capacity updates
gears.timer({
	timeout = 30,
	call_now = true,
	autostart = true,
	callback = update_battery,
})

-- Weather
--[[ to be set before use
theme.weather = lain.widget.weather({
    --APPID =
    city_id = 2643743, -- placeholder (London)
})
--]]

-- Separators
local first = wibox.widget.textbox(markup.font("Terminus 4", " "))
local spr = wibox.widget.textbox(" ")

local function update_txt_layoutbox(s)
	-- Writes a string representation of the current layout in a textbox widget
	local txt_l = theme["layout_txt_" .. awful.layout.getname(awful.layout.get(s))] or ""
	s.mytxtlayoutbox:set_text(txt_l)
end

function theme.at_screen_connect(s)
	-- Quake application
	s.quake = lain.util.quake({ app = awful.util.terminal })

	-- If wallpaper is a function, call it with the screen
	local wallpaper = theme.wallpaper
	if type(wallpaper) == "function" then
		wallpaper = wallpaper(s)
	end
	gears.wallpaper.maximized(wallpaper, s, false)

	-- Tags
	awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()

	-- Textual layoutbox
	s.mytxtlayoutbox = wibox.widget.textbox(theme["layout_txt_" .. awful.layout.getname(awful.layout.get(s))])
	awful.tag.attached_connect_signal(s, "property::selected", function()
		update_txt_layoutbox(s)
	end)
	awful.tag.attached_connect_signal(s, "property::layout", function()
		update_txt_layoutbox(s)
	end)
	s.mytxtlayoutbox:buttons(my_table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 2, function()
			awful.layout.set(awful.layout.layouts[1])
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

	-- Create the wibox
	s.mywibox = awful.wibar({ position = "bottom", screen = s, height = dpi(18), visible = false })

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			first,
			s.mytaglist,
			spr,
			s.mytxtlayoutbox,
			--spr,
			s.mypromptbox,
			spr,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			-- wibox.widget.systray(),
			spr,
			battery_widget,
			-- theme.mpd.widget,
			--theme.mail.widget,
			cpu.widget,
			mem.widget,
			-- bat.widget,
			-- net.widget,
			theme.volume.widget,
			mytextclock,
		},
	})
end

return theme

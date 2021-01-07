local awful       = require("awful")
local naughty     = require("naughty")
local gears       = require("gears")
local beautiful   = require("beautiful")
local apps        = require("apps")
local decorations = require("decorations")
local helpers     = require("helpers")

local keys = {}

-- Mod keys
modkey = "Mod4"
altkey = "Mod1"
ctrlkey = "Control"
shiftkey = "Shift"

-- {{{ Keymap
key.globalkeys = gears.table.join
(
    -- {{ Window management
        -- Focus windows with mod + hjkl
        awful.key({modkey}, "h",
            function()
                awful.client.focus.bydirection("left")
            end,
            {description = "focus left"}
        ),
        awful.key({modkey}, "j",
            function()
                awful.client.focus.bydirection("down")
            end,
            {description = "focus down"}
        ),
        awful.key({modkey}, "k",
            function()
                awful.client.focus.bydirection("up")
            end,
            {description = "focus up"}
        ),
        awful.key({modkey}, "l",
            function()
                awful.client.focus.bydirection("right")
            end,
            {description = "focus right"}
         ),

        -- Cycle through windows
        awful.key({modkey}, "Tab",
            function()
                window_switcher_show(awful.screen.focused())
            end,
            {description = "activate window switcher", group = "client"}
        ),

        -- Gaps
        awful.key({modkey}, "equal",
            function()
                awful.tag.incgap(5, nil)
            end,
            {description = "increment gap size in current space", group = "client"}),
        awful.key({modkey}, "minus",
            function()
                awful.tag.incgap(-5, nil)
            end,
            {description = "decrement gap size in current space", group = "client"}
        ),

        -- Float focused window
        awful.key({modkey, shiftkey}, "space",
            awful.client.floating.toggle,
            {description = "(un)float current window", group = "client"}
        ),
        -- Hide window (Minimize)
        awful.key({modkey}, "m",
            function()
                c.minimized = true
            end,
            {description = "hide/minimize window", group = "client"}
        ),

        -- Unhide window (Unminimize)
        awful.key({modkey, ctrlkey}, "m",
            function()
                local c = awful.client.restore()
                -- Focus restored window
                if c then
                    client.focus = c
                end
            end,
            {description = "unhide/unminimize window", group = "client"}
        ),

        -- Close focused window
        awful.key({modkey}, "w",
            function(c)
                c:kill()
            end,
            {description = "close window", group = "client"}
        ),
        
    -- }}

    -- {{ Launch programs
        -- Default run prompt
        awful.key({modkey}, "r",
            function()
                awfult.screen.focused().mypromptbox:run()
            end,
            {description = "open default run prompt", group = "launcher"}
        ),
        -- Spawn terminal
        awful.key({modkey}, "Enter",
            function()
                awful.spawn(user.terminal)
            end,
            {description = "open a terminal window", group = "launcher"}
        ),

        -- Launch Rofi
        awful.key({modkey}, "space",
            function()
                awful.spawn(/usr/bin/rofi -show drun - modi drun)
            end,
            {description = "launch rofi", group = "launcher"}
        ),

        -- Launch editor
        awful.key({modkey}, "space",
            apps.editor
            {description = "editor", group = "launcher"}
        ),

        -- Launch Vivaldi
        awful.key({modkey}, "v",
            function()
                awful.spawn(/usr/bin/vivaldi)
            end,
            {description = "launch vivaldi", group = "launcher"}
        ),

        -- Launch Spotify
        awful.key({modkey}, "s",
            function()
                awful.spawn(spotify)
            end,
            {description = "launch spotify", group = "launcher"}
        ),

        -- Launch Discord
        awful.key({modkey}, "d",
            function()
                awful.spawn(discord)
            end,
            {description = "launch discord", group = "launcher"}
        ),

        -- Launch file browser
        awful.key({modkey}, "b",
            function()
                awful.spawn(filemanager)
            end,
            {description = "launch file manager", group = "launcher"}
        ),
    -- }}

    -- {{ Media keys
        -- Volume down
        awful.key({}, "XF86AudioLowerVolume",
            function()
                awful.util.spawn("amixer set Master 5%-")
            end,
            {description = "lower volume", group = "volume"}
        ),

        -- Volume up
        awful.key({}, "XF86AudioRaiseVolume",
            function()
                awful.util.spawn("amixer set Master 5%+")
            end,
            {description = "raise volume", group = "volume"}
        ),

        -- Check helpers file
        -- Mute volume
        awful.key({}, "XF86AudioMute",
            function()
                awful.util.spawn("amixer set Master 0%")
            end,
            {description = "(un)mute volume", group = "volume"}
        ),

        -- Play/pause
        awful.key({}, "XF86AudioPlay",
            function()
                awful.util.spawn("playerctl play-pause")
            end,
            {description = "play/pause", group = "volume"}
        ),

        -- Next track
        awful.key({}, "XF86AudioNext",
            function()
                awful.util.spawn("playerctl next")
            end,
            {description = "next track", group = "volume"}
        ),

        -- Previous track
        awful.key({}, "XF86AudioPrev",
            function()
                awful.util.spawn("playerctl previous")
            end,
            {description = "previous track", group = "volume"}
        ),

        -- Microphone ("p" for phone)
        awful.key({modkey}, "p",
            function()
                awful.spawn.with_shell("pactl set-source-mute @DEFAULT_SOURCE@ toggle")
            end,
            {description = "(un)mute microphone", group = "volume"}
        ),
    -- }}
    
    -- {{ Screenshots
        -- Save screenshot of full screen
        awful.key({modkey, shiftkey}, "3",
            function()
                apps.screenshot("full")
            end,
            {description = "save full screenshot", group = "screenshots"}
        ),
        
        -- Save screenshot of selected area
        awful.key({modkey, shiftkey}, "4",
            function()
                apps.screenshot("selection")
            end,
            {description = "save screenshot of selected area", group = "screenshots"}
        ),

        -- Copy screenshot of selected area
        awful.key({modkey, shiftkey, altkey}, "4",
            function()
                apps.screenshot("clipboard")
            end,
            {description = "copy screenshot of selected area", group = "screenshots"}
        ),
    -- }}

    -- {{ Exiting
        -- Close all windows on current space
        awful.key({modkey}, "q",
            function()
                local clients = awful.screen.focused().clients
                for _, c in pairs(clients) do
                    c:kill()
                end
            end,
            {description = "close all windows on current space", group = "client"}
         ),

        -- Restart Awesome
        awful.key({modkey, ctrlkey}, "r",
            awesome.restart,
            {description = "restart awesome", group = "awesome"}
        ),

        -- Logout of Awesome
        awful.key({modkey, shiftkey}, "q",
            awesome.quit,
            {description = "logout of awesome", group = "awesome"}
        ),

        -- Show exit menu
        awful.key({}, "XF86PowerOff",
            function()
                exit_screen_show()
            end,
            {description = "show exit menu", group = "awesome"}
        )
    -- }}
)

-- {{ (More) window management
keys.clientkeys = gears.table.join
(
        awful.key({modkey, ctrlkey}, "h",
            function(c)
                c:relative_move(dpi(-20), 0, 0, 0)
            end),
        awful.key({modkey, ctrlkey}, "j",
            function(c)
                c:relative_move(0, dpi(20), 0, 0)
            end),
        awful.key({modkey, ctrlkey}, "k",
            function(c)
                c:relative_move(0, dpi(-20), 0, 0)
            end),
        awful.key({modkey, ctrlkey}, "l",
            function(c)
                c:relative_move(dpi(20), 0, 0, 0)
            end),
        
        -- Toggle titlebar on focused window
        awful.key({modkey}, "t",
            function(c)
                decorations.cycle(c)
            end,
            {description = "toggle titlebar on focused window", group = "client"} 
        ),

        -- Toggle titlebars in current space
        awful.key({modkey, shiftkey}, "t",
            function(c)
                local client = awful.screen.focused().clients
                for _, c in pairs(clients) do
                    decoration.cycle(c)
                end
            end,
            {description = "toggle titlebars in current space", group = "client"} 
        ),

        -- Toggle fullscreen
        awful.key({modkey}, "f",
            function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = "toggle fullscreen", group = "client"} 
        )
)
-- }}

-- {{ Manipulate spaces (tags)
local ntags = 10
for i = 1, ntags do
    keys.globalkeys = gears.table.join(keys.globalkeys,
        -- Switch space
        awful.key({modkey}, "#" .. i + 9,
            function()
                helpers.tag_back_and_forth(i)
            end,
            {description = "switch to space #" .. i, group = "space"}
        ),

        -- Toggle space display
        awful.key({modkey, ctrlkey}, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle space #" .. i, group = "space"}
        ),
        
        -- Move window to space
        awful.key({modkey, shiftkey}, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag
                    end
                end
            end,
            {description = "move focused client to space #" .. i, group = "space"}
        ),
        -- Move window to space and focus that space
        awful.key({altkey, shiftkey}, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag
                    end
                    tag:view_only()
                end
            end,
            {description = "move focused to space and focus that space #" .. i, group = "space"}
        ),

        -- Move all visible windows to space and focus that space
        awful.key({modkey, altkey}, "#" .. i + 9,
            function()
                local tag = client.focus.screen.tags[i]
                local clients = awful.screen.focused().clients
                if tag then
                    for _, c in pairs(clients) do
                        c:move_to_tag(tag)
                end
                tag:view_only
            end,
        end,
            {description = "move all visible windows to space and focus that space" .. i, group = "space"}
        ),

        -- Toggle window on focused window
        awful.key({modkey, ctrlkey, shiftkey}, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {description = "toggle focused window on space #" .. i, group = "space"}
        )
    )
end

-- }}

-- }}}



-- {{{ Mouse bindings
keys.desktopbuttons = gears.table.join
(
    awful.button({ }, 1, function ()
        -- Single tap
        awesome.emit_signal("elemental::dismiss")
        naughty.destroy_all_notifications()
        if mymainmenu then
            mymainmenu:hide()
        end
        if sidebar_hide then
            sidebar_hide()
        end
        -- Double tap
        local function double_tap()
            uc = awful.client.urgent.get()
            -- If there is no urgent client, go back to last tag
            if uc == nil then
                awful.tag.history.restore()
            else
                awful.client.urgent.jumpto()
            end
        end
        helpers.single_double_tap(function() end, double_tap)
    end),

    -- Right click - Show app drawer
    -- awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 3, function ()
        if app_drawer_show then
            app_drawer_show()
        end
    end),

    -- Middle button - Toggle dashboard
    awful.button({ }, 2, function ()
        if dashboard_show then
            dashboard_show()
        end
    end)

    -- Scrolling - Switch tags
    --awful.button({ }, 4, awful.tag.viewprev),
    --awful.button({ }, 5, awful.tag.viewnext),

    -- Side buttons - Control volume (need to check on helpers file)
--    awful.button({ }, 9, function () helpers.volume_control(5) end),
--    awful.button({ }, 8, function () helpers.volume_control(-5) end)
)
-- {{ Mouse buttons on whole window regardless of titlebar
keys.clientbuttons = gears.table.join
(
    -- Focus client when clicked on
    awful.button({}, 1,
       function(c)
           client.focus = c
       end
    ),

    -- Move client while holding mod key and dragging with left button
    awful.button({modkey}, 1, 
        awful.mouse.client.move
    ),

    -- Resize client while holding mod key and dragging with right button
    awful.button({modkey}, 3, 
        function(c)
            client.focus = c
            awful.mouse.client.resize(c)
        end
    )
)
-- }}

-- }}}

-- Set root (desktop keys)
root.keys(keys.gloablkeys)
root.buttons(keys.desktopbuttons)

return keys

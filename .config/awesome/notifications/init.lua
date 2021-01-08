local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")

local notifications = {}

-- Notification settings
-- Icon size
naughty.config.defaults['border_width'] = beautiful.notification_border_width

-- Timeouts
naughty.config.defaults.timeout = 5
naughty.config.presets.low.timeout = 2
naughty.config.presets.critical.timeout = 12

-- >> Notify DWIM
function notifications.notify_dwim(args, notif)
    local n = notif
    if n and not n.private.is_destroyed and not n.is_expired then
        notif.title = args.title or notif.title
        notif.message = args.message or notif.message
        notif.icon = args.icon or notif.icon
        notif.timeout = args.timeout or notif.timeout
    else
        n = naughty.notification(args)
    end
    return n
end

return notifications

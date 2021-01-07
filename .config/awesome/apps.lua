local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")
local helpers = require("helpers")
--local icons = require("icons")
--local notifications = require("notifications")

local apps = {}

apps.editor = function ()
    helpers.run_or_raise({instance = 'editor'}, false, user.editor, {switchtotag = true})
end

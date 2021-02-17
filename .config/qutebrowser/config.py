import subprocess
import os
import dracula.draw

from qutebrowser.api import interceptor

# Immediately allow skipping YouTube ad
def filter_yt(info:interceptor.Request):
    url = info.request_url
    if(
        url.host() == "www.youtube.com"
        and url.path() == "/get_video_info"
        and "&adformat=" in url.query()
    ):
        info.block()

interceptor.register(filter_yt)

config.load_autoconfig()

config.set("colors.webpage.darkmode.enabled", True)
#c.content.user_stylesheets = ['~/.config/qutebrowser/css/duolingo-dark.css']


# Mpv keybindings
config.bind(',M', 'spawn mpv {url}')
config.bind(',m', 'hint links spawn mpv {hint-url}')
config.bind(';m', 'hint links spawn funnel "{hint-url}"')

c.editor.command = ['termite', '-e', 'vim {}']
c.tabs.position = "top"
c.url.searchengines = { "DEFAULT" : "https://searx.bar/search?q={}", "d" : "https://duckduckgo.com/?q={}&ia=web", "g" : "https://google.com/search?q={}", "y" : "https://www.youtube.com/results?search_query={}" }

# Dracula theme
dracula.draw.blood(c, {
    'speacing':{
        'vertical': 6,
        'horizontal': 8
    }
})

# Xresources colors
#def read_xresources(prefix):
#    props = {}
#    x = subprocess.run(["xrdb", "-query"], stdout=subprocess.PIPE)
#    lines = x.stdout.decode().split("\n")
#    for line in filter(lambda l: l.startswith(prefix), lines):
#        prop, _, value = line.partition(":\t")
#        props[prop] = value
#    return props
#
#xresources = read_xresources("*")
#
#c.colors.statusbar.normal.bg = xresources['*.background']
#c.colors.statusbar.normal.fg = xresources["*.foreground"]
#c.colors.statusbar.command.bg = xresources["*.background"]
#c.colors.statusbar.command.fg = xresources["*.foreground"]
c.statusbar.show = "in-mode"
c.statusbar.widgets = ["keypress", "url", "progress"]
#
#c.colors.tabs.even.bg = xresources["*.background"]
#c.colors.tabs.odd.bg = xresources["*.background"]
#c.colors.tabs.even.fg = xresources["*.foreground"]
#c.colors.tabs.odd.fg = xresources["*.foreground"]
#c.colors.tabs.selected.even.bg = xresources["*.color8"]
#c.colors.tabs.selected.odd.bg = xresources["*.color8"]
#c.colors.tabs.hints.bg = xresources["*.background"]
#c.colors.tabs.hints.fg = xresources["*.foreground"]
c.tabs.show = "multiple"
c.tabs.last_close = "close"

c.prompt.radius = 20

c.scrolling.smooth = True

# Title Format
c.tabs.title.format = "{audio}{current_title}"

# Font size
c.fonts.web.size.default = 15

#c.colors.tabs.indicator.stop = xresources["*.color14"]
#c.colors.completion.odd.bg = xresources["*.background"]
#c.colors.completion.even.bg = xresources["*.background"]
#c.colors.completion.fg = xresources["*.foreground"]
#c.colors.completion.category.bg = xresources["*.background"]
#c.colors.completion.category.fg = xresources["*.foreground"]
#c.colors.completion.item.selected.bg = xresources["*.background"]
#c.colors.completion.item.selected.fg = xresources["*.foreground"]

# If not light theme
#if xresources["*.background"] != "#ffffff":
#    c.colors.webpage.darkmode.enabled = True
#    c.hints.border = "1px solid #FFFFFF"

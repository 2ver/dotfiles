import subprocess
import os
import lena.draw

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

config.load_autoconfig(False)

#config.set("colors.webpage.darkmode.enabled", True)

# Mpv keybindings
config.bind(',M', 'spawn mpv {url}')
config.bind(',m', 'hint links spawn mpv {hint-url}')
config.bind(';m', 'hint links spawn funnel "{hint-url}"')

# List bookmarks
config.bind('b', 'set-cmd-text -s :bookmark-load')
config.bind('B', 'set-cmd-text -s :bookmark-load -t')

# List quickmarks
config.bind('q', 'set-cmd-text -s :quickmark-load')
config.bind('Q', 'set-cmd-text -s :quickmark-load -t')

# Aliases
# Alias for moving tabs
c.aliases['tabm'] = 'tab-move'

c.editor.command = ['termite', '-e', 'vim {}']
c.tabs.position = "top"
c.url.start_pages = ["~/.config/qutebrowser/startpage/index.html"]
#c.url.start_pages.append('~/.config/qutebrowser/startpage/index.html')
c.url.default_page = ("~/.config/qutebrowser/startpage/index.html")
c.url.searchengines = { "DEFAULT" : "https://searx.bar/search?q={}", "d" : "https://duckduckgo.com/?q={}&ia=web", "g" : "https://google.com/search?q={}", "y" : "https://www.youtube.com/results?search_query={}", "gh" : "https://github.com/search?q={}&ref=opensearch" }

# Lena theme
lena.draw.lena(c, {
   'spacing':{
        'vertical': 6,
        'horizontal': 8
    }
})

c.statusbar.show = "in-mode"
c.statusbar.widgets = ["keypress", "url", "progress"]

c.tabs.show = "multiple"
c.tabs.last_close = "close"

c.prompt.radius = 40

c.scrolling.smooth = True

# Title Format
c.tabs.title.format = "{audio}{current_title}"

# Font size
c.fonts.web.size.default = 15

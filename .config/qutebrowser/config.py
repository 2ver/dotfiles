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

#c.colors.webpage.preferred_color_scheme = dark
#config.set("colors.webpage.darkmode.enabled", True)

# Colemak Bindings
c.bindings.commands['normal'] = {
	# Navigation
	'n' : 'scroll left',
	'e' : 'scroll down',
	'i' : 'scroll up',
	'o' : 'scroll right',

	'N' : 'back',
	'I' : 'tab-next',
	'E' : 'tab-prev',
	'O' : 'forward',
	
	# Remap displaced keys
	'h' : 'mode-enter insert',
	'k' : 'search-next',
	'K' : 'search-prev',
	'l' : 'set-cmd-text -s :open',

	'L' : 'set-cmd-text -s :open -t',

	# Kakoune specific
	'ge' : 'scroll-to-perc',
}

c.bindings.commands['caret'] = {
	'go' : 'move-to-end-of-line',
	'gn' : 'move-to-start-of-line',
	'ge' : 'move-to-end-of-document',
	'N' : 'scroll left',
	'E' : 'scroll down',
	'I' : 'scroll up',
	'O' : 'scroll right',
	'n' : 'move-to-prev-char',
	'e' : 'move-to-next-line',
	'i' : 'move-to-prev-line',
	'o' : 'move-to-next-char',
	'j' : 'move-to-end-of-word',
	'q' : 'move-to-prev-word',
}

c.hints.chars = ('arstgmneio')

# Mpv keybindings
config.bind('<space>M', 'spawn umpv {url}')
config.bind('<space>m', 'hint links spawn umpv {hint-url}')
config.bind(';m', 'hint --rapid links spawn umpv "{hint-url}"')

# List bookmarks
config.bind('b', 'set-cmd-text -s :bookmark-load')
config.bind('B', 'set-cmd-text -s :bookmark-load -t')

# List quickmarks
config.bind('q', 'set-cmd-text -s :quickmark-load')
config.bind('Q', 'set-cmd-text -s :quickmark-load -t')

# Aliases
# Alias for moving tabs
c.aliases['tabm'] = 'tab-move'

c.editor.command = ['kitty', 'kak', '{}']
c.tabs.position = "top"
c.url.start_pages = ["~/.config/qutebrowser/startpage/index.html"]
c.url.default_page = ("~/.config/qutebrowser/startpage/index.html")
c.url.searchengines = { "DEFAULT" : "https://searx.cedars.xyz/search?q={}", "d" : "https://duckduckgo.com/?q={}&ia=web", "g" : "https://google.com/search?q={}", "y" : "https://www.youtube.com/results?search_query={}", "gh" : "https://github.com/search?q={}&ref=opensearch", "w" : "https://wiby.me/?q={}" }

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

# ■           __  ___   _____  _____
# ■ ■        / / / / | / / _ \/ ___/
# ■ ■ ■     / /_/ /| |/ /  __/ /
# ■ ■ ■ ■   \____/ |___/\___/_/

import subprocess
import os
import lena.draw

config.load_autoconfig(False)  # Ignore configuration set from within browser

## Bindings
c.bindings.commands['normal'] = {
   # Colemak navigation
   'n'       : 'scroll left',
   'e'       : 'scroll down',
   'i'       : 'scroll up',
   'o'       : 'scroll right',
   'N'       : 'back',
   'I'       : 'tab-next',
   'E'       : 'tab-prev',
   'O'       : 'forward',

   # Displaced keys
   'h'       : 'mode-enter insert',
   'k'       : 'search-next',
   '<Alt-k>' : 'search-prev',
   'l'       : 'set-cmd-text -s :open',
   'L'       : 'set-cmd-text -s :open -t',

   # Kakoune
   'ge'      : 'scroll-to-perc',
}

c.bindings.commands['caret'] = {
   # Colemak navigation
   'n'  : 'move-to-prev-char',
   'e'  : 'move-to-next-line',
   'i'  : 'move-to-prev-line',
   'o'  : 'move-to-next-char',
   'N'  : 'scroll left',
   'E'  : 'scroll down',
   'I'  : 'scroll up',
   'O'  : 'scroll right',

   # Displaced
   'j'  : 'move-to-end-of-word',

   # Kakoune
   'q'  : 'move-to-prev-word',
   'go' : 'move-to-end-of-line',
   'gn' : 'move-to-start-of-line',
   'ge' : 'move-to-end-of-document',
}

# Colemak-DH Link hints
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

## Aliases
# Alias for moving tabs
c.aliases['tabm'] = 'tab-move'

## UI
# Theme
lena.draw.lena(c, {
   'spacing':{
        'vertical': 6,
        'horizontal': 8
   }
})

config.set("colors.webpage.darkmode.enabled", True)  # Darkmode

c.tabs.position = "top"
c.tabs.title.format = "{index}: {current_title}"  # Don't show [A] for tabs with audio
c.tabs.show = "multiple"
c.tabs.last_close = "close"

c.statusbar.show = "in-mode"
c.statusbar.widgets = ["keypress", "url", "progress"]

c.url.start_pages = ["~/.config/qutebrowser/startpage/index.html"]
c.url.default_page = ("~/.config/qutebrowser/startpage/index.html")

c.prompt.radius = 40  # Rounder corners
c.scrolling.smooth = True
c.fonts.web.size.default = 15

## User settings
c.editor.command = ['kitty', 'kcr edit', '{}']
c.url.searchengines = {
   "DEFAULT" : "https://search.brave.com/search?q={}",
   "aur"     : "https://archlinux.org/packages/?q={}",
   "aw"      : "https://wiki.archlinux.org/index.php?search={}",
   "b"       : "https://search.brave.com/search?q={}",
   "d"       : "https://duckduckgo.com/?q={}&ia=web",
   "g"       : "https://google.com/search?q={}",
   "gh"      : "https://github.com/search?q={}&ref=opensearch",
   "o"       : "https://odysee.com/$/search?q={}",
   "s"       : "https://searx.bar/search?q={}",
   "t"       : "https://translate.yandex.com/?text={}",
   "y"       : "https://www.youtube.com/results?search_query={}",
   "w"       : "https://wiby.me/?q={}",
}

# Taken care of by userscript now
# from qutebrowser.api import interceptor
# Immediately allow skipping YouTube ad
# def filter_yt(info:interceptor.Request):
    # url = info.request_url
    # if(
        # url.host() == "www.youtube.com"
        # and url.path() == "/get_video_info"
        # and "&adformat=" in url.query()
    # ):
        # info.block()
# interceptor.register(filter_yt)

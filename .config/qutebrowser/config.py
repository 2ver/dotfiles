c.editor.command = ['termite', '-e', 'vim {}']
c.tabs.position = "top"

config.bind(',M', 'spawn mpv {url}')
config.bind(',m', 'hint links spawn mpv {hint-url}')

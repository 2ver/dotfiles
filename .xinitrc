# Load Xresources colors
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
# Load US internation keyboard layout
setxkbmap -rules evdev -model evdev -layout us -variant altgr-intl
#awesome
#exec bspwm
exec i3

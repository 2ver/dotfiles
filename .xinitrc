## Load Xresources colors
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

## Load US international keyboard layout
setxkbmap -rules evdev -model evdev -layout us -variant altgr-intl

## Autostart Apps
autostart &
external_monitor_connected &
~/.fehbg &
picom &

## Restart DWM without quitting Xorg
~/.bin/startdwm

## Window Manager  
# awesome
# exec bspwm
# exec i3
# exec herbstluftwm
# exec dwm

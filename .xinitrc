## Load Xresources colors
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

## Load US international keyboard layout
setxkbmap -rules evdev -model evdev -layout us -variant altgr-intl

## Autostart Apps
cursor-settings &
external-monitor &
~/.fehbg &
picom &
dunst &

## Restart DWM without quitting Xorg
# ~/.bin/startdwm

## Window Manager  
# awesome
exec bspwm
# exec i3
# exec herbstluftwm
# exec dwm

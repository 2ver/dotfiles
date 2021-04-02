## Load Xresources colors
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

## Load US international keyboard layout
setxkbmap -rules evdev -model evdev -layout us -variant altgr-intl

## Window Manager  
# awesome
# exec bspwm
# exec i3
exec herbstluftwm #--locked 
